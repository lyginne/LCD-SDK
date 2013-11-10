/****************************************************************************

    test_led.c - тест драйвера последовательного канала
                 для учебного стенда SDK-1.1

    (C) test_led.c, Ключев А.О.  2007 г.

Это свободная программа; вы можете повторно распространять ее и/или
модифицировать ее в соответствии с Универсальной Общественной
Лицензией GNU, опубликованной Фондом Свободного ПО; либо версии 2,
либо (по вашему выбору) любой более поздней версии.

Эта программа распространяется в надежде, что она будет полезной,
но БЕЗ КАКИХ-ЛИБО ГАРАНТИЙ; даже без подразумеваемых гарантий
КОММЕРЧЕСКОЙ ЦЕННОСТИ или ПРИГОДНОСТИ ДЛЯ КОНКРЕТНОЙ ЦЕЛИ.  Для
получения подробных сведений смотрите Универсальную Общественную
Лицензию GNU.

Вы должны были получить копию Универсальной Общественной Лицензии
GNU вместе с этой программой; если нет, напишите по адресу: Free
Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307 USA

----------------------------------------------------------------------------
Россия, Санкт-Петербург, кафедра вычислительной техники СПбГУИТМО  
e-mail: kluchev@d1.ifmo.ru

****************************************************************************/
#include "aduc812.h"
#include "led.h"
#include "max.h"
#include "queue.h"
#include "interrupt.h"
#include "keyboard.h"
#include "uart.h"
#include "timer.h"
volatile queue readBuffer;
volatile queue writeBuffer;
volatile queue interruptWriteBuffer;

static char tempForExpression[3];
static char expressionByteNumber = 0;

static char transmitting=0;
static char expressionReceiving=1;


static char savedKeyChar = 0;

static char delays=0;

static char number = 0;

//char symbolTable[]={'1','2','3','a','4','5','6','b','7','8','9','c','*','0','#','d'};

char checkExpression(){
	return 1;
	
}

void verifyAndSave(void)
{	
	if(tempForExpression[0]=='*'
		||tempForExpression[0]=='#'
		||tempForExpression[1]=='*'
		||tempForExpression[2]=='*'){
		expressionReceiving = 0;
		expressionByteNumber = 0;	
		return;
		
	}
	if(tempForExpression[1]=='#'){
		enqueue(&readBuffer,tempForExpression[0]);
		enqueue(&readBuffer,tempForExpression[1]);
		expressionByteNumber = 0;
		//leds(0xff);
		return;
	}
	if(tempForExpression[2]=='#'){
		enqueue(&readBuffer,tempForExpression[0]);
		enqueue(&readBuffer,tempForExpression[1]);
		enqueue(&readBuffer,tempForExpression[2]);
		expressionByteNumber = 0;
		return;
	}
	expressionByteNumber = 0;
	
}

void DelayExpired(void) __interrupt (1){
	delays = 0;
	
	if( kb_read_button_code() == savedKeyChar){
		if(savedKeyChar=='*'){
			enqueue(&interruptWriteBuffer,'\n');
			beginTranslation();
			expressionByteNumber=0;
			expressionReceiving = 1;
			return;
		}
		if(expressionReceiving){
			enqueue(&interruptWriteBuffer,savedKeyChar);
			beginTranslation();
			ET0 = 0;
		}
		if(savedKeyChar == '#' || expressionByteNumber==2){			
			tempForExpression[expressionByteNumber]=savedKeyChar;
			expressionReceiving = 0;
			enqueue(&interruptWriteBuffer,'\n');
			beginTranslation();
			verifyAndSave();
		}
		else{
			tempForExpression[expressionByteNumber]=savedKeyChar;
			expressionByteNumber++;
		}
		
	}	
}

void KeyPressedInterrupt(void) __interrupt (0){
	char buttonPressed;
	number++;
	//leds(0xf0);
	expressionReceiving=1;
	if(delays)
		return;
	
	buttonPressed = kb_read_button_code();
	if (buttonPressed == -1||buttonPressed==-2){
		//error
		return;
	}
	else{
		delays = 1;
		savedKeyChar = buttonPressed;
		SetDelayTimer(0xffff);
	}
	TCON&=0xFD;
	//leds(TCON);
}



	
void main (void) {
	unsigned char first, second, third;
	unsigned char hundredsDec, dozensDec, unitsDec;
	unsigned char result;
	unsigned char firstValue, secondValue;
	
	queueInit(&writeBuffer);
	queueInit(&readBuffer);
	write_max(ENA,0x60);
	
	initUart(&writeBuffer,&interruptWriteBuffer);
	SetVector(0x2003, (void*)KeyPressedInterrupt);
	EX0=1;
	//EX1=1;
	TCON|=0x01;
	SetVector(0x200B, (void*)DelayExpired);
	ET0 = 1;
	EA = 1;
	//leds(TCON);
	SetDelayTimer(0xffff);
	//leds(TMOD);
	enqueue(&writeBuffer, 'g');
	beginTranslation();	
	
	
	for(;;){
		first = dequeue(&readBuffer);
		
		if (first==0)			
			continue;
		//else
			//parsingExpresion=1;
		second = dequeue(&readBuffer);
		if(second != '#'){
			third = dequeue(&readBuffer);
			if(first>='A')
				firstValue=first-'A'+0xA;
			else
				firstValue=first-'0';
			if(second>='A')
				secondValue=second-'A'+0xA;
			else
				secondValue=second-'0';
			result = (firstValue<<4)+(secondValue);
		}
		else{
			if(first>='A')
				firstValue=first-'A'+0xA;
			else
				firstValue=first-'0';
			result = firstValue;
		}
		//leds(result);
		hundredsDec = result/100;
		if (result>=100)
			dozensDec = (result%100)/10;
		else
			dozensDec = result/10;
		unitsDec = result%10;
		if(hundredsDec!=0)
			enqueue(&writeBuffer, hundredsDec+'0');
		if(dozensDec!=0||hundredsDec!=0)
			enqueue(&writeBuffer, dozensDec + '0');			
		enqueue(&writeBuffer, unitsDec +'0');
		beginTranslation();
	}
}


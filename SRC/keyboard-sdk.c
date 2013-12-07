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
#include "sound.h"
#include "keyboard.h"
#include "uart.h"
#include "lcd.h"
#include "timer.h"


volatile queue readBuffer;
volatile queue writeBuffer;


	

void main (void) {
	unsigned char first, second, operation;
	unsigned char thouthandsDec, hundredsDec, dozensDec, unitsDec;
	int result;
	unsigned char firstValue, secondValue;
	lcd_clear();
	queueInit(&writeBuffer);
	queueInit(&readBuffer);
	InitSound();

	initUart(&writeBuffer);
	KB_Init(&readBuffer);

	EA = 1;
	
	
	for(;;){
		result = 0;
		first = dequeue(&readBuffer);
		lcd_doYourJob();
		if (first==0)			
			continue;
		lcd_doYourJob();
		second = dequeue(&readBuffer);
		if(second == '+'
		||second == '-'
		||second == '/'
		||second == '*'){
			operation = second;
			firstValue = first-'0';
		}
		else{
			operation = dequeue(&readBuffer);
			firstValue = (first-'0')*10+second-'0';
		}
		first = dequeue(&readBuffer);		
		second = dequeue(&readBuffer);
		if(second == '='){
			secondValue = first-'0';
		}
		else{
			secondValue = (first-'0')*10+second-'0';
			dequeue(&readBuffer);
		}
		blockUserTranslation();
		if(operation == '+')
			result = firstValue + secondValue;
		else if(operation == '-')
			result = firstValue - secondValue;
			if (result<0){
				result=~result+1;
				enqueue(&writeBuffer, '-');
				lcd_putchar('-');
			}
		else if(operation == '*')
			result = firstValue * secondValue;
		else if(operation == '/'){
			if(secondValue==0){
				lcd_clear();
				enqueue(&writeBuffer, 'e');
				lcd_putchar('e');
				enqueue(&writeBuffer, 'r');
				lcd_putchar('r');
				enqueue(&writeBuffer, 'r');
				lcd_putchar('r');
				enqueue(&writeBuffer, 'o');
				lcd_putchar('o');
				enqueue(&writeBuffer, 'r');
				lcd_putchar('r');
				enqueue(&writeBuffer, '\n');
				allowUserTranslation();
				allowKernelTranslation();
				beginTranslation();
				lcd_allow();
				continue;
			} 
			result = firstValue / secondValue;
		}
		thouthandsDec = result/1000;
		if(result>1000)			
			hundredsDec = (result%1000)/100;
		else
			hundredsDec = result/100;
		if (result>=100)
			dozensDec = (result%100)/10;
		else
			dozensDec = result/10;
		unitsDec = result%10;		
		if(thouthandsDec!=0){	
			enqueue(&writeBuffer, thouthandsDec+'0');
			lcd_putchar(thouthandsDec+'0');
		}
		if(hundredsDec!=0||thouthandsDec!=0){
			enqueue(&writeBuffer, hundredsDec+'0');
			lcd_putchar(hundredsDec+'0');
		}
		if(dozensDec!=0||hundredsDec!=0||thouthandsDec!=0){
			enqueue(&writeBuffer, dozensDec + '0');	
			lcd_putchar(dozensDec + '0');	
		}	
		enqueue(&writeBuffer, unitsDec +'0');
		lcd_putchar(unitsDec +'0');
		enqueue(&writeBuffer, '\n');
		lcd_allow();
		allowUserTranslation();
		allowKernelTranslation();
		beginTranslation();
	}
}

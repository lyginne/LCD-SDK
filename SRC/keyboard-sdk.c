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
#include "timer.h"
volatile queue readBuffer;
volatile queue writeBuffer;


	

void main (void) {
	unsigned char first, second, third;
	unsigned char hundredsDec, dozensDec, unitsDec;
	unsigned char result;
	unsigned char firstValue, secondValue;
	
	queueInit(&writeBuffer);
	queueInit(&readBuffer);
	InitSound();

	initUart(&writeBuffer);
	KB_Init(&readBuffer);

	EA = 1;
	
	
	for(;;){
		first = dequeue(&readBuffer);
		
		if (first==0)			
			continue;
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
		hundredsDec = result/100;
		if (result>=100)
			dozensDec = (result%100)/10;
		else
			dozensDec = result/10;
		unitsDec = result%10;
		blockUserTranslation();
		if(hundredsDec!=0)
			enqueue(&writeBuffer, hundredsDec+'0');
		if(dozensDec!=0||hundredsDec!=0)
			enqueue(&writeBuffer, dozensDec + '0');			
		enqueue(&writeBuffer, unitsDec +'0');
		enqueue(&writeBuffer, '\n');
		beginUserTranslation();
	}
}


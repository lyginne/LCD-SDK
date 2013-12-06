#include "aduc812.h"
#include "queue.h"
#include "interrupt.h"
#include "led.h"
#include "keyboard.h"
#include "uart.h"
#include "sound.h"
#include "lcd.h"


static queue * _readBuffer;
static char * _delays;
static char _savedKeyChar;
static char tempForExpression[6];
static char expressionByteNumber = 0;

static xdata queue interruptWriteBuffer;

static char transmitting=0;
static char expressionReceiving=1;


void error(void){
	lcd_clear();
	enqueue(&interruptWriteBuffer, 'e');
	lcd_putchar('e');
	enqueue(&interruptWriteBuffer, 'r');
	lcd_putchar('r');
	enqueue(&interruptWriteBuffer, 'r');
	lcd_putchar('r');
	enqueue(&interruptWriteBuffer, 'o');
	lcd_putchar('o');
	enqueue(&interruptWriteBuffer, 'r');
	lcd_putchar('r');
	enqueue(&interruptWriteBuffer, '\n');
	makeAnErrorSound();
	lcd_block();
}
void verifyAndSave(void)
{
	char i;
	//?*	
	if(tempForExpression[0]<'0'||tempForExpression[0]>'9'){
		error();
		expressionByteNumber = 0;	
		return;
		
	}
	//if not ??*
	if(tempForExpression[1]<'0'||tempForExpression[1]>'9'){
		//?+*
		if(tempForExpression[1]=='+'
		||tempForExpression[1]=='-'
		||tempForExpression[1]=='*'
		||tempForExpression[1]=='/'){
			//if not ?+?*
			if (tempForExpression[2]<'0'||tempForExpression[2]>'9'){
				error();
				expressionByteNumber = 0;	
				return;	
			}
			//if not ?+??*
			if(tempForExpression[3]<'0'||tempForExpression[3]>'9'){
				//if ?+?=
				if(tempForExpression[3]=='='){
					for (i=0; i<=3;i++){
						enqueue(_readBuffer,tempForExpression[i]);
					}
					expressionByteNumber = 0;
					enqueue(&interruptWriteBuffer, 'B');					
					return;	
				}
				error();
				expressionByteNumber = 0;
				return;	
				
			}
			//if ?+??=
			if(tempForExpression[4]=='='){
				for (i=0; i<=4;i++){
					enqueue(_readBuffer,tempForExpression[i]);
				}
				expressionByteNumber = 0;
				enqueue(&interruptWriteBuffer, 'B');
				return;
			}
		}
		error();
		expressionByteNumber = 0;
		return;
	}
	//if ??+*
	if(tempForExpression[2]=='+'
		||tempForExpression[2]=='-'
		||tempForExpression[2]=='*'
		||tempForExpression[2]=='/'){
		//if not ??+?*
		if (tempForExpression[3]<'0'||tempForExpression[3]>'9'){
			error();
			expressionByteNumber = 0;	
			return;	
		}
		//if not ??+??*
		if(tempForExpression[4]<'0'||tempForExpression[4]>'9'){
			//if ??+?=
			if(tempForExpression[4]=='='){
				for (i=0; i<=4;i++){
					enqueue(_readBuffer,tempForExpression[i]);
				}
				expressionByteNumber = 0;
				enqueue(&interruptWriteBuffer, 'B');
				return;	
			}
			error();
			expressionByteNumber = 0;
			return;	
			
		}
		//if ??+??=
		if(tempForExpression[5]=='='){
			for (i=0; i<=5;i++){
				enqueue(_readBuffer,tempForExpression[i]);
			}
			expressionByteNumber = 0;
			enqueue(&interruptWriteBuffer, 'B');
			return;
		}
	}
	error();
	expressionByteNumber = 0;
	return;
}

void DelayExpired(void) __interrupt (1){
	*_delays = 0;
	
	if( kb_read_button_code() == _savedKeyChar){
		//leds(0xff);
		if(_savedKeyChar=='#'){
			//clear outputs
			enqueue(&interruptWriteBuffer,'\n');
			lcd_clear();
			makeASound();
			beginTranslation();
			expressionByteNumber=0;
			expressionReceiving = 1;
			return;
		}
		//Write that what was inputted
		if(expressionByteNumber==0){
			lcd_clear();
			lcd_allow();
		}
		enqueue(&interruptWriteBuffer,_savedKeyChar);
		lcd_putchar(_savedKeyChar);
		//write to lcd here
		beginTranslation();
		makeASound();
		tempForExpression[expressionByteNumber]=_savedKeyChar;
		expressionByteNumber++;
		leds(expressionByteNumber);
		//if this is the end
		if(_savedKeyChar == '=' || expressionByteNumber==6){
			expressionReceiving = 0;
			if(_savedKeyChar != '='){
				//enqueue(&interruptWriteBuffer,'\n');
				makeAnErrorSound();
			}
			beginTranslation();
			verifyAndSave();
		}
	}
}

void TimerInit(char * delays, queue * readBuffer){
	_readBuffer=readBuffer;
	_delays = delays;
	TMOD |= 0x01;
	TCON |= 0x10;
}

void SetDelayTimer(int value, char savedKeyChar){
	_savedKeyChar=savedKeyChar;
	SetVector(0x200B, (void*)DelayExpired);
	SetInterruptBuffer(&interruptWriteBuffer);
	TH0 = (value>>4);
	TL0 = value;
	ET0 = 1;
}
	


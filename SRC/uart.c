#include "aduc812.h"
#include "interrupt.h"
#include "queue.h"

volatile queue * _writeBuffer;
volatile queue * _interruptWriteBuffer;
volatile static char _lock;

volatile static char _transmitting = 0;
volatile static char _allowTranslation = 1;


static void USART_ISR (void) __interrupt ( 4 ){
	 char trasmittingData;
	_transmitting=0;
	
	if(TI){
		
		_transmitting=1;
		if(_allowTranslation){
			trasmittingData = dequeue(_writeBuffer);
			if(trasmittingData!=0){
				SBUF=trasmittingData;
				_transmitting=1;
				TI=0;
				return;
			}
		}

		trasmittingData = dequeue(_interruptWriteBuffer);
		if(trasmittingData!=0){
			SBUF=trasmittingData;
			_transmitting=1;
			TI=0;
			return;
		}
		
		
	}
}

void beginTranslation(){
	if(_lock)
		return;
	_lock=1;
	if(!_transmitting)			
		TI=1;
	_lock=0;
}
void blockUserTranslation(void){
	_allowTranslation=0;
}
void beginUserTranslation(void){
	_allowTranslation=1;
	beginTranslation();
}


void initUart(queue * writeBuffer){
	_writeBuffer=writeBuffer;
	SCON = 0x40; //8-bit no recieve, work on timer
	SetVector(0x2023, (void*) USART_ISR);
	T2CON=0x34;
	RCAP2H=0xff;
	RCAP2L=0xdc;
	ES=1;
}

void SetInterruptBuffer(queue xdata * interruptWriteBuffer){
	_interruptWriteBuffer=interruptWriteBuffer;
}


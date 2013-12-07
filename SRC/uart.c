#include "aduc812.h"
#include "interrupt.h"
#include "queue.h"

volatile queue * _writeBuffer;
volatile xdata queue * _interruptWriteBuffer;
volatile static char _lock;

volatile static char _transmitting = 0;
volatile static char _allowUserTranslation = 1;
volatile static char _allowKernelTranslation = 1;

void blockUserTranslation(void){
	_allowUserTranslation=0;
}
void blockKernelTranslation(void){
	_allowKernelTranslation=0;
}
void allowKernelTranslation(void){
	_allowKernelTranslation=1;
}
void allowUserTranslation(void){
	_allowUserTranslation=1;
}

static void USART_ISR (void) __interrupt ( 4 ){
	 char trasmittingData;
	_transmitting=0;
	
	if(TI){


		_transmitting=1;
		trasmittingData = dequeue(_writeBuffer);
		if(trasmittingData!=0){
			SBUF=trasmittingData;
			_transmitting=1;
			TI=0;
			return;
		}
		if(_allowKernelTranslation){
			trasmittingData = dequeue(_interruptWriteBuffer);
			if(trasmittingData!=0){
				if(trasmittingData=='B'){
					blockKernelTranslation();
					return;
				}
				SBUF=trasmittingData;
				_transmitting=1;
				TI=0;
				return;
			}
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

void initUart(queue * writeBuffer){
	_writeBuffer=writeBuffer;
	SCON = 0x40; //8-bit no recieve, work on timer
	SetVector(0x2023, (void*) USART_ISR);
	T2CON=0x34;
	RCAP2H=0xff;
	RCAP2L=0xdc;
	ES=1;
}

void SetInterruptBuffer(xdata queue * interruptWriteBuffer){
	_interruptWriteBuffer=interruptWriteBuffer;
}

void uart_clerQueue(void){
	queue_clear(_writeBuffer);
}


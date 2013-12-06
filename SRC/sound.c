#include "interrupt.h"
#include "aduc812.h"
#include "led.h"
#include "max.h"

static unsigned char _half_periods=0;
static char state=0;
static char ENA_Value;

void soundTimer(void) __interrupt{
	if(_half_periods>40){
		switch (state){
			case 2:
				state=3;
				_half_periods=0;
				break;
			case 3:
				state=1;
				_half_periods=0;
				break;
			default:
				state=0;
				_half_periods=0;
				break;
		}	
	}
	_half_periods++;
	if(state==3){
		TH1=0xF9;
		TL1=0x1E;
		return;
	}
	if(state!=0){
		ENA_Value=(read_max(ENA)|ENA_Value^0x1C|0x60);
		write_max(ENA,ENA_Value);
	}
	TH1=0xF9;
	TL1=0x1E;
}
void makeASound(){
	_half_periods=0;
	state=1;
	TH1=0xF9;
	TL1=0x1E;
}

void makeAnErrorSound(void){
	leds(0xff);	
	_half_periods=0;
	state=2;
	TH1=0xF9;
	TL1=0x1E;
}

void InitSound(void){
	SetVector(0X201B,(void*)soundTimer);
	TMOD |= 0x10;
	TCON |= 0x40; 
	ET1=1;	
}

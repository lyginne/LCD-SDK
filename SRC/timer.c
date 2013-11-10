#include "aduc812.h"


void TimerInit(int value){
	TMOD |= 0x01;
	TCON |= 0x10;
	TH0 = 0x00;
	TL0 = 0x00;
	ET0 = 1;
	
}

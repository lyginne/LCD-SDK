#include "max.h"
#include "led.h"
#include "queue.h"
#include "aduc812.h"
#include "lcd.h"

volatile static xdata queue interruptLCDWriteBuffer;

volatile char _allowLCD = 1;
char _shouldBreakTheLine=0; 


void lcd_block(void){
	_allowLCD=0;
}
void lcd_allow(void){
	_allowLCD=1;
}


unsigned char lcd_getBusyFlagState(void) {
	//get busy flag
	unsigned char retval = 0x00;

	write_max(C_IND, 0x03); // RS=0 RW=1 E=1 
	retval = read_max(DATA_IND);
	write_max(C_IND, 0x02); // RS=0 RW=1 E=0 
	retval = retval >> 7;

	return retval;
}

unsigned char lcd_getDdramAddress(void) {
	unsigned char retval = 0x00;

	write_max(C_IND, 0x03); // RS=0 RW=1 E=1 
	retval = read_max(DATA_IND);
	write_max(C_IND, 0x02); // RS=0 RW=1 E=0 
	retval = retval & 0x7f;

	return retval;
}

void lcd_setDdramAddress(const unsigned char addr) {
	//set ddram addr, nothing to say
	while(lcd_getBusyFlagState()) {}
	write_max(DATA_IND, addr | 0x80);
	write_max(C_IND, 0x01);
	write_max(C_IND, 0x00);
	return;
}

void lcd_clear(void) {
	//clear
	while(lcd_getBusyFlagState()) {}
	write_max(DATA_IND, 0x01);
	write_max(C_IND, 0x01);
	write_max(C_IND, 0x00);

	//shift and direction
	while(lcd_getBusyFlagState()) {}
	write_max(DATA_IND, 0x06);
	write_max(C_IND, 0x01);
	write_max(C_IND, 0x00);

	//enable cursor, display, and blink
	while(lcd_getBusyFlagState()) {}
	write_max(DATA_IND, 0x0f);
	write_max(C_IND, 0x01);
	write_max(C_IND, 0x00);

	lcd_putCharNow('0');

	while(lcd_getBusyFlagState()) {}
	write_max(DATA_IND, 0x02);
	write_max(C_IND, 0x01);
	write_max(C_IND, 0x00);
}

void lcd_putCharNow(const char charData) {
	unsigned char ddramAddress = lcd_getDdramAddress();	
	//if first string owerflows - write on second
	if ((ddramAddress > 0x0f) && (ddramAddress < 0x40)) {
		lcd_setDdramAddress(0x40);
	}
	if(_shouldBreakTheLine){
		_shouldBreakTheLine=0;
		lcd_clear();
	}
	if(charData=='\n'){
		_shouldBreakTheLine=1;
		return;
	}
	while(lcd_getBusyFlagState()) {}
	write_max(DATA_IND, charData);
	write_max(C_IND, 0x05);
	write_max(C_IND, 0x04);
	return;
}

void lcd_doYourJob(void){
	unsigned char outputData;
	if(!_allowLCD)
		return;
	while(1){
		outputData = dequeue(&interruptLCDWriteBuffer);
		if(outputData==0)
			return;
		
		if(outputData=='B'){
			lcd_block();
			return;
		}
		/*if(outputData=='C'){
			lcd_clear();
			continue;
		}*/
		lcd_putCharNow(outputData);
	}
}

void lcd_putCharQueue(char ptsData){
	enqueue(&interruptLCDWriteBuffer, ptsData);

}

void lcd_putStringQueue(char * currentData){
	enqueues(&interruptLCDWriteBuffer, currentData);
}
void lcd_putStringNow(char * inputString){
	unsigned char charsCounter = 0;
	while ((inputString[charsCounter] != '\0')) {
		lcd_putCharNow(inputString[charsCounter++]);
	}
}

void leds_clearQueue(void){
	queue_clear(&interruptLCDWriteBuffer);
}
void lcd_shouldBreakTheLine(void){
	_shouldBreakTheLine=1;
}



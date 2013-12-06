#include "max.h"
#include "lcd.h"
#include "led.h"
#include "queue.h"

volatile char _allowLCD = 1;


void lcd_block(void){
	_allowLCD=0;
}
void lcd_allow(void){
	_allowLCD=1;
}


unsigned char lcd_bfstate() {
	//get busy flag
	unsigned char retval = 0x00;

	write_max(C_IND, 0x03); // RS=0 RW=1 E=1 
	retval = read_max(DATA_IND);
	write_max(C_IND, 0x02); // RS=0 RW=1 E=0 
	retval = retval >> 7;

	return retval;
}

unsigned char lcd_get_ddram_addr(void) {
	unsigned char retval = 0x00;

	write_max(C_IND, 0x03); // RS=0 RW=1 E=1 
	retval = read_max(DATA_IND);
	write_max(C_IND, 0x02); // RS=0 RW=1 E=0 
	retval = retval & 0x7f;

	return retval;
}

void lcd_set_ddram_addr(const unsigned char addr) {
	//set ddram addr, nothing to say
	while(lcd_bfstate()) {}
	write_max(DATA_IND, addr | 0x80);
	write_max(C_IND, 0x01);
	write_max(C_IND, 0x00);
	return;
}

void lcd_clear(void) {
	//clear
	while(lcd_bfstate()) {}
	write_max(DATA_IND, 0x01);
	write_max(C_IND, 0x01);
	write_max(C_IND, 0x00);

	//shift and direction
	while(lcd_bfstate()) {}
	write_max(DATA_IND, 0x06);
	write_max(C_IND, 0x01);
	write_max(C_IND, 0x00);

	//enable cursor, display, and blink
	while(lcd_bfstate()) {}
	write_max(DATA_IND, 0x0f);
	write_max(C_IND, 0x01);
	write_max(C_IND, 0x00);
	return;
}

void lcd_putchar(const char c) {
	unsigned char ddram_addr = lcd_get_ddram_addr();
	if (_allowLCD==1){	
		if ((ddram_addr > 0x0f) && (ddram_addr < 0x40)) {
			lcd_set_ddram_addr(0x40);
		}
		while(lcd_bfstate()) {}
		write_max(DATA_IND, c);
		write_max(C_IND, 0x05);
		write_max(C_IND, 0x04);
		return;
	}
}



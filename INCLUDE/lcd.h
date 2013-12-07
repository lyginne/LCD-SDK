#include "queue.h"

#ifndef _LED_H_
#define _LED_H_

void lcd_block(void);
void lcd_allow(void);
unsigned char lcd_getBusyFlagState(void);
unsigned char lcd_getDdramAddress(void);
void lcd_setDdramAddress(const unsigned char addr);
void lcd_clear(void);
void lcd_putCharNow(const char charData);
void lcd_doYourJob(void);
void lcd_putCharQueue(char ptsData);
void lcd_putStringQueue(char * currentData);
void lcd_putStringNow(char * inputString);
void leds_clearQueue(void);
void lcd_shouldBreakTheLine(void);

#endif

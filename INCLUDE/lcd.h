#include "queue.h"

#ifndef _LED_H_
#define _LED_H_

void lcd_clear(void);
void lcd_putchar(const char c);

void lcd_block(void);
void lcd_allow(void);

#endif
#include "queue.h"

#ifndef __UART__H
#define __UART__H

//I'm just sitting here tranminning
void beginTranslation(void);

void initUart(queue * writeBuffer);

void SetInterruptBuffer(queue xdata * interruptWriteBuffer);

void blockUserTranslation(void);
void allowUserTranslation(void);
void blockKernelTranslation(void);
void allowKernelTranslation(void);
void uart_clerQueue(void);
//char parsingExpresion;

#endif

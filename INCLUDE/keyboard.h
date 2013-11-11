#include "queue.h"

#ifndef __KEYBOARD__H
#define __KEYBOARD__H

char kb_read_button_code(void);

void KB_Init(queue * readBuffer);

#endif

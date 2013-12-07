#ifndef __QUEUE__H
#define __QUEUE__H

#define QUEUESIZE       32

typedef struct {
        volatile char qdata[QUEUESIZE+1];		/* body of queue */
        volatile char first;                      /* position of first element */
        volatile char last;                       /* position of last element */
        volatile char count;                      /* number of queue elements */
} queue;

void queueInit( queue * curentQueue);

volatile void enqueue(queue *curentQueue, char curentData);

volatile char dequeue( queue *curentQueue);

volatile void enqueues(queue *curentQueue, char * curentData);

void queue_clear(queue *q);

#endif

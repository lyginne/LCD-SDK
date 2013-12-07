#include "aduc812.h"
#include "queue.h"

void queueInit(queue * curentQueue){   
	curentQueue->first=0;
	curentQueue->last=0;
	curentQueue->count=0;
}

volatile void enqueue(queue *curentQueue, char curentData)
{
	if (curentQueue->count >= QUEUESIZE){
		//return 0x0;
		//Error
		;;;;;;
	}
	else {
		EA=0;
		curentQueue->qdata[ curentQueue->last ] = curentData;    
		curentQueue->last++;
		if( curentQueue->last>=QUEUESIZE)
			curentQueue->last=0;
		curentQueue->count++;
		EA=1;
	}
}

volatile char dequeue(queue *curentQueue)
{	
	char curentData;

	if (curentQueue->count <= 0){
		return 0;
	}
	else {
		EA=0;
		curentData = curentQueue->qdata[ curentQueue->first ];
		curentQueue->first++;
		if( curentQueue->first>=QUEUESIZE)
			curentQueue->first=0;
		curentQueue->count--;
		EA=1;
	}
	return(curentData);
}

void enqueues(queue *curentQueue, const char * inputString) {
    unsigned char charsCounter = 0;

    while ((inputString[charsCounter] != '\0')) {
        enqueue(curentQueue,inputString[charsCounter++]);
    }

    return;
}

volatile void queue_clear(queue *curentQueue){
	curentQueue->first=0;
	curentQueue->last=0;
	curentQueue->count=0;
}

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
		//q->last = (q->last+1) % QUEUESIZE;
		curentQueue->qdata[ curentQueue->last ] = curentData;    
		curentQueue->last++;
		if( curentQueue->last>=QUEUESIZE)
			curentQueue->last=0;
		curentQueue->count++;
	}
}

volatile char dequeue(queue *curentQueue)
{	
	char curentData;

	if (curentQueue->count <= 0){
		return 0;
	}
	else {
		curentData = curentQueue->qdata[ curentQueue->first ];
		curentQueue->first++;
		if( curentQueue->first>=QUEUESIZE)
			curentQueue->first=0;
		curentQueue->count--;
	}
	return(curentData);
}

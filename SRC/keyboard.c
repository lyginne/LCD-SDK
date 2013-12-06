#include "max.h"
#include "aduc812.h"
#include "led.h"
#include "interrupt.h"
#include "timer.h"
#include "sound.h"

static char xdata symbolTable[]={'1','2','3','+','4','5','6','-','7','8','9','*','=','0','#','/'};
static char delays;
static char number=0;
static char savedKeyChar;
//� 4-� ������� ����� ������ ��������� �����

unsigned char kb_read_row(void){
	return (read_max(KB)>>4);
}

//���������� �������� �������
void kb_wtite_col(unsigned char column){
	write_max(KB, column);
}

//������� �������� �������
void kb_select_col(unsigned char columnNumber){
	char columnValue=1;
	columnValue<<=columnNumber;
	kb_wtite_col(~columnValue);
}
//��������� ����� ������� �������
//-2 - ������  �� ������
//-1 - ������ ������ ����� �������
char kb_read_row_number(){

	unsigned char read_row_result;
	
	read_row_result = kb_read_row();
	switch (read_row_result){
		case 0x0E:
			return 0;
		case 0x0D:
			return 1;
		case 0x0B:
			return 2;
		case 0x07:
			return 3;
		case 0x0F:
			return -2;
	}
	return -1;
}

//��������� ��� ������� �������
//-1 - ������ �� ������ ��� ������
char kb_read_button_code(void){
	char pressed = 0;
	char btnNumber=-1;
	char rowNumber=-2;
	char i;
	char tempi=0;
	for(i=0;i<4;i++){
		kb_select_col(i);
		rowNumber=kb_read_row_number();
		if(rowNumber==-2)
			continue;
		if((rowNumber==-1)||(btnNumber!=-1)){
			kb_wtite_col(0x00);
			TCON&=0xFD;
			leds(0xff);
			makeAnErrorSound();			
			return -1;
		}
		btnNumber=(rowNumber<<2)|i;
		tempi=i;
		
	}
	kb_wtite_col(0x00);
	TCON&=0xFD;
	if(btnNumber==-1)
		return -2;
	return symbolTable[btnNumber];
}

void KeyPressedInterrupt(void) __interrupt (0){
	char buttonPressed;
	leds(0x00);
	if(delays)
		return;
	
	buttonPressed = kb_read_button_code();
	kb_wtite_col(0x00);
	TCON&=0xFD;
	if(buttonPressed==-2){		
		return;	
	}
	if (buttonPressed == -1){
		return;
	}
	else{
		delays = 1;
		savedKeyChar = buttonPressed;
		SetDelayTimer(0x0000,savedKeyChar);
	}

}

void KB_Init(void * readBuffer){
	SetVector(0x2003, (void*)KeyPressedInterrupt);
	TCON|=0x01;
	TimerInit(&delays, readBuffer);
	write_max(ENA,0x60);
	kb_wtite_col(0x00);
	EX0=1;
}
	

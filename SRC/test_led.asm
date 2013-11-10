;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Mar 22 2009) (UNIX)
; This file was generated Sun Nov 10 18:56:34 2013
;--------------------------------------------------------
	.module test_led
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _KeyPressedInterrupt
	.globl _DelayExpired
	.globl _verifyAndSave
	.globl _checkExpression
	.globl _SPR0
	.globl _SPR1
	.globl _CPHA
	.globl _CPOL
	.globl _SPIM
	.globl _SPE
	.globl _WCOL
	.globl _ISPI
	.globl _I2CI
	.globl _I2CTX
	.globl _I2CRS
	.globl _I2CM
	.globl _MDI
	.globl _MCO
	.globl _MDE
	.globl _MDO
	.globl _CS0
	.globl _CS1
	.globl _CS2
	.globl _CS3
	.globl _SCONV
	.globl _CCONV
	.globl _DMA
	.globl _ADCI
	.globl _P
	.globl _F1
	.globl _OV
	.globl _RS0
	.globl _RS1
	.globl _F0
	.globl _AC
	.globl _CY
	.globl _CAP2
	.globl _CNT2
	.globl _TR2
	.globl _XEN
	.globl _TCLK
	.globl _RCLK
	.globl _EXF2
	.globl _TF2
	.globl _WDE
	.globl _WDS
	.globl _WDR2
	.globl _WDR1
	.globl _PRE0
	.globl _PRE1
	.globl _PRE2
	.globl _PX0
	.globl _PT0
	.globl _PX1
	.globl _PT1
	.globl _PS
	.globl _PT2
	.globl _PADC
	.globl _PSI
	.globl _RXD
	.globl _TXD
	.globl _INT0
	.globl _INT1
	.globl _T0
	.globl _T1
	.globl _WR
	.globl _RD
	.globl _EX0
	.globl _ET0
	.globl _EX1
	.globl _ET1
	.globl _ES
	.globl _ET2
	.globl _EADC
	.globl _EA
	.globl _RI
	.globl _TI
	.globl _RB8
	.globl _TB8
	.globl _REN
	.globl _SM2
	.globl _SM1
	.globl _SM0
	.globl _T2
	.globl _T2EX
	.globl _IT0
	.globl _IE0
	.globl _IT1
	.globl _IE1
	.globl _TR0
	.globl _TF0
	.globl _TR1
	.globl _TF1
	.globl _DACCON
	.globl _DAC1H
	.globl _DAC1L
	.globl _DAC0H
	.globl _DAC0L
	.globl _SPICON
	.globl _SPIDAT
	.globl _ADCCON3
	.globl _ADCGAINH
	.globl _ADCGAINL
	.globl _ADCOFSH
	.globl _ADCOFSL
	.globl _B
	.globl _ADCCON1
	.globl _I2CCON
	.globl _ACC
	.globl _PSMCON
	.globl _ADCDATAH
	.globl _ADCDATAL
	.globl _ADCCON2
	.globl _DMAP
	.globl _DMAH
	.globl _DMAL
	.globl _PSW
	.globl _TH2
	.globl _TL2
	.globl _RCAP2H
	.globl _RCAP2L
	.globl _T2CON
	.globl _EADRL
	.globl _WDCON
	.globl _EDATA4
	.globl _EDATA3
	.globl _EDATA2
	.globl _EDATA1
	.globl _ETIM3
	.globl _ETIM2
	.globl _ETIM1
	.globl _ECON
	.globl _IP
	.globl _P3
	.globl _IE2
	.globl _IE
	.globl _P2
	.globl _I2CADD
	.globl _I2CDAT
	.globl _SBUF
	.globl _SCON
	.globl _P1
	.globl _TH1
	.globl _TH0
	.globl _TL1
	.globl _TL0
	.globl _TMOD
	.globl _TCON
	.globl _PCON
	.globl _DPP
	.globl _DPH
	.globl _DPL
	.globl _SP
	.globl _P0
	.globl _interruptWriteBuffer
	.globl _writeBuffer
	.globl _readBuffer
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (DATA)
_P0	=	0x0080
_SP	=	0x0081
_DPL	=	0x0082
_DPH	=	0x0083
_DPP	=	0x0084
_PCON	=	0x0087
_TCON	=	0x0088
_TMOD	=	0x0089
_TL0	=	0x008a
_TL1	=	0x008b
_TH0	=	0x008c
_TH1	=	0x008d
_P1	=	0x0090
_SCON	=	0x0098
_SBUF	=	0x0099
_I2CDAT	=	0x009a
_I2CADD	=	0x009b
_P2	=	0x00a0
_IE	=	0x00a8
_IE2	=	0x00a9
_P3	=	0x00b0
_IP	=	0x00b8
_ECON	=	0x00b9
_ETIM1	=	0x00ba
_ETIM2	=	0x00bb
_ETIM3	=	0x00c4
_EDATA1	=	0x00bc
_EDATA2	=	0x00bd
_EDATA3	=	0x00be
_EDATA4	=	0x00bf
_WDCON	=	0x00c0
_EADRL	=	0x00c6
_T2CON	=	0x00c8
_RCAP2L	=	0x00ca
_RCAP2H	=	0x00cb
_TL2	=	0x00cc
_TH2	=	0x00cd
_PSW	=	0x00d0
_DMAL	=	0x00d2
_DMAH	=	0x00d3
_DMAP	=	0x00d4
_ADCCON2	=	0x00d8
_ADCDATAL	=	0x00d9
_ADCDATAH	=	0x00da
_PSMCON	=	0x00df
_ACC	=	0x00e0
_I2CCON	=	0x00e8
_ADCCON1	=	0x00ef
_B	=	0x00f0
_ADCOFSL	=	0x00f1
_ADCOFSH	=	0x00f2
_ADCGAINL	=	0x00f3
_ADCGAINH	=	0x00f4
_ADCCON3	=	0x00f5
_SPIDAT	=	0x00f7
_SPICON	=	0x00f8
_DAC0L	=	0x00f9
_DAC0H	=	0x00fa
_DAC1L	=	0x00fb
_DAC1H	=	0x00fc
_DACCON	=	0x00fd
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (DATA)
_TF1	=	0x008f
_TR1	=	0x008e
_TF0	=	0x008d
_TR0	=	0x008c
_IE1	=	0x008b
_IT1	=	0x008a
_IE0	=	0x0089
_IT0	=	0x0088
_T2EX	=	0x0091
_T2	=	0x0090
_SM0	=	0x009f
_SM1	=	0x009e
_SM2	=	0x009d
_REN	=	0x009c
_TB8	=	0x009b
_RB8	=	0x009a
_TI	=	0x0099
_RI	=	0x0098
_EA	=	0x00af
_EADC	=	0x00ae
_ET2	=	0x00ad
_ES	=	0x00ac
_ET1	=	0x00ab
_EX1	=	0x00aa
_ET0	=	0x00a9
_EX0	=	0x00a8
_RD	=	0x00b7
_WR	=	0x00b6
_T1	=	0x00b5
_T0	=	0x00b4
_INT1	=	0x00b3
_INT0	=	0x00b2
_TXD	=	0x00b1
_RXD	=	0x00b0
_PSI	=	0x00bf
_PADC	=	0x00be
_PT2	=	0x00bd
_PS	=	0x00bc
_PT1	=	0x00bb
_PX1	=	0x00ba
_PT0	=	0x00b9
_PX0	=	0x00b8
_PRE2	=	0x00c7
_PRE1	=	0x00c6
_PRE0	=	0x00c5
_WDR1	=	0x00c3
_WDR2	=	0x00c2
_WDS	=	0x00c1
_WDE	=	0x00c0
_TF2	=	0x00cf
_EXF2	=	0x00ce
_RCLK	=	0x00cd
_TCLK	=	0x00cc
_XEN	=	0x00cb
_TR2	=	0x00ca
_CNT2	=	0x00c9
_CAP2	=	0x00c8
_CY	=	0x00d7
_AC	=	0x00d6
_F0	=	0x00d5
_RS1	=	0x00d4
_RS0	=	0x00d3
_OV	=	0x00d2
_F1	=	0x00d1
_P	=	0x00d0
_ADCI	=	0x00df
_DMA	=	0x00de
_CCONV	=	0x00dd
_SCONV	=	0x00dc
_CS3	=	0x00db
_CS2	=	0x00da
_CS1	=	0x00d9
_CS0	=	0x00d8
_MDO	=	0x00ef
_MDE	=	0x00ee
_MCO	=	0x00ed
_MDI	=	0x00ec
_I2CM	=	0x00eb
_I2CRS	=	0x00ea
_I2CTX	=	0x00e9
_I2CI	=	0x00e8
_ISPI	=	0x00ff
_WCOL	=	0x00fe
_SPE	=	0x00fd
_SPIM	=	0x00fc
_CPOL	=	0x00fb
_CPHA	=	0x00fa
_SPR1	=	0x00f9
_SPR0	=	0x00f8
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; overlayable bit register bank
;--------------------------------------------------------
	.area BIT_BANK	(REL,OVR,DATA)
bits:
	.ds 1
	b0 = bits[0]
	b1 = bits[1]
	b2 = bits[2]
	b3 = bits[3]
	b4 = bits[4]
	b5 = bits[5]
	b6 = bits[6]
	b7 = bits[7]
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_readBuffer::
	.ds 36
_writeBuffer::
	.ds 36
_interruptWriteBuffer::
	.ds 36
_tempForExpression:
	.ds 3
_expressionByteNumber:
	.ds 1
_transmitting:
	.ds 1
_expressionReceiving:
	.ds 1
_savedKeyChar:
	.ds 1
_delays:
	.ds 1
_number:
	.ds 1
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area OSEG    (OVR,DATA)
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG	(DATA)
__start__stack:
	.ds	1

;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	.area IABS    (ABS,DATA)
	.area IABS    (ABS,DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area HOME    (CODE)
__interrupt_vect:
	ljmp	__sdcc_gsinit_startup
	ljmp	_KeyPressedInterrupt
	.ds	5
	ljmp	_DelayExpired
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
	.globl __sdcc_gsinit_startup
	.globl __sdcc_program_startup
	.globl __start__stack
	.globl __mcs51_genXINIT
	.globl __mcs51_genXRAMCLEAR
	.globl __mcs51_genRAMCLEAR
;	SRC/test_led.c:42: static char expressionByteNumber = 0;
	mov	_expressionByteNumber,#0x00
;	SRC/test_led.c:44: static char transmitting=0;
	mov	_transmitting,#0x00
;	SRC/test_led.c:45: static char expressionReceiving=1;
	mov	_expressionReceiving,#0x01
;	SRC/test_led.c:48: static char savedKeyChar = 0;
	mov	_savedKeyChar,#0x00
;	SRC/test_led.c:50: static char delays=0;
	mov	_delays,#0x00
;	SRC/test_led.c:52: static char number = 0;
	mov	_number,#0x00
	.area GSFINAL (CODE)
	ljmp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
__sdcc_program_startup:
	lcall	_main
;	return from main will lock up
	sjmp .
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'checkExpression'
;------------------------------------------------------------
;------------------------------------------------------------
;	SRC/test_led.c:56: char checkExpression(){
;	-----------------------------------------
;	 function checkExpression
;	-----------------------------------------
_checkExpression:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	SRC/test_led.c:57: return 1;
	mov	dpl,#0x01
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'verifyAndSave'
;------------------------------------------------------------
;------------------------------------------------------------
;	SRC/test_led.c:61: void verifyAndSave(void)
;	-----------------------------------------
;	 function verifyAndSave
;	-----------------------------------------
_verifyAndSave:
;	SRC/test_led.c:63: if(tempForExpression[0]=='*'
	mov	r2,_tempForExpression
	cjne	r2,#0x2A,00117$
	sjmp	00101$
00117$:
;	SRC/test_led.c:64: ||tempForExpression[0]=='#'
	cjne	r2,#0x23,00118$
	sjmp	00101$
00118$:
;	SRC/test_led.c:65: ||tempForExpression[1]=='*'
	mov	r3,(_tempForExpression + 0x0001)
	cjne	r3,#0x2A,00119$
	sjmp	00101$
00119$:
;	SRC/test_led.c:66: ||tempForExpression[2]=='*'){
	mov	r4,(_tempForExpression + 0x0002)
	cjne	r4,#0x2A,00102$
00101$:
;	SRC/test_led.c:67: expressionReceiving = 0;
	mov	_expressionReceiving,#0x00
;	SRC/test_led.c:68: expressionByteNumber = 0;	
	mov	_expressionByteNumber,#0x00
;	SRC/test_led.c:69: return;
	ret
00102$:
;	SRC/test_led.c:72: if(tempForExpression[1]=='#'){
	cjne	r3,#0x23,00107$
;	SRC/test_led.c:73: enqueue(&readBuffer,tempForExpression[0]);
	push	ar2
	mov	dptr,#_readBuffer
	mov	b,#0x40
	lcall	_enqueue
	dec	sp
;	SRC/test_led.c:74: enqueue(&readBuffer,tempForExpression[1]);
	push	(_tempForExpression + 0x0001)
	mov	dptr,#_readBuffer
	mov	b,#0x40
	lcall	_enqueue
	dec	sp
;	SRC/test_led.c:75: expressionByteNumber = 0;
	mov	_expressionByteNumber,#0x00
;	SRC/test_led.c:77: return;
	ret
00107$:
;	SRC/test_led.c:79: if(tempForExpression[2]=='#'){
	cjne	r4,#0x23,00109$
;	SRC/test_led.c:80: enqueue(&readBuffer,tempForExpression[0]);
	push	ar2
	mov	dptr,#_readBuffer
	mov	b,#0x40
	lcall	_enqueue
	dec	sp
;	SRC/test_led.c:81: enqueue(&readBuffer,tempForExpression[1]);
	push	(_tempForExpression + 0x0001)
	mov	dptr,#_readBuffer
	mov	b,#0x40
	lcall	_enqueue
	dec	sp
;	SRC/test_led.c:82: enqueue(&readBuffer,tempForExpression[2]);
	push	(_tempForExpression + 0x0002)
	mov	dptr,#_readBuffer
	mov	b,#0x40
	lcall	_enqueue
	dec	sp
;	SRC/test_led.c:83: expressionByteNumber = 0;
	mov	_expressionByteNumber,#0x00
;	SRC/test_led.c:84: return;
;	SRC/test_led.c:86: expressionByteNumber = 0;
	ret
00109$:
	mov	_expressionByteNumber,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'DelayExpired'
;------------------------------------------------------------
;------------------------------------------------------------
;	SRC/test_led.c:90: void DelayExpired(void) __interrupt (1){
;	-----------------------------------------
;	 function DelayExpired
;	-----------------------------------------
_DelayExpired:
	push	bits
	push	acc
	push	b
	push	dpl
	push	dph
	push	(0+2)
	push	(0+3)
	push	(0+4)
	push	(0+5)
	push	(0+6)
	push	(0+7)
	push	(0+0)
	push	(0+1)
	push	psw
	mov	psw,#0x00
;	SRC/test_led.c:91: delays = 0;
	mov	_delays,#0x00
;	SRC/test_led.c:93: if( kb_read_button_code() == savedKeyChar){
	lcall	_kb_read_button_code
	mov	a,dpl
	mov	r2,a
	cjne	a,_savedKeyChar,00117$
	sjmp	00118$
00117$:
	ljmp	00111$
00118$:
;	SRC/test_led.c:94: if(savedKeyChar=='*'){
	mov	a,#0x2A
	cjne	a,_savedKeyChar,00102$
;	SRC/test_led.c:95: enqueue(&interruptWriteBuffer,'\n');
	mov	a,#0x0A
	push	acc
	mov	dptr,#_interruptWriteBuffer
	mov	b,#0x40
	lcall	_enqueue
	dec	sp
;	SRC/test_led.c:96: beginTranslation();
	lcall	_beginTranslation
;	SRC/test_led.c:97: expressionByteNumber=0;
	mov	_expressionByteNumber,#0x00
;	SRC/test_led.c:98: expressionReceiving = 1;
	mov	_expressionReceiving,#0x01
;	SRC/test_led.c:99: return;
	sjmp	00111$
00102$:
;	SRC/test_led.c:101: if(expressionReceiving){
	mov	a,_expressionReceiving
	jz	00104$
;	SRC/test_led.c:102: enqueue(&interruptWriteBuffer,savedKeyChar);
	push	_savedKeyChar
	mov	dptr,#_interruptWriteBuffer
	mov	b,#0x40
	lcall	_enqueue
	dec	sp
;	SRC/test_led.c:103: beginTranslation();
	lcall	_beginTranslation
;	SRC/test_led.c:104: ET0 = 0;
	clr	_ET0
00104$:
;	SRC/test_led.c:106: if(savedKeyChar == '#' || expressionByteNumber==2){			
	mov	a,#0x23
	cjne	a,_savedKeyChar,00122$
	sjmp	00105$
00122$:
	mov	a,#0x02
	cjne	a,_expressionByteNumber,00106$
00105$:
;	SRC/test_led.c:107: tempForExpression[expressionByteNumber]=savedKeyChar;
	mov	a,_expressionByteNumber
	add	a,#_tempForExpression
	mov	r0,a
	mov	@r0,_savedKeyChar
;	SRC/test_led.c:108: expressionReceiving = 0;
	mov	_expressionReceiving,#0x00
;	SRC/test_led.c:109: enqueue(&interruptWriteBuffer,'\n');
	mov	a,#0x0A
	push	acc
	mov	dptr,#_interruptWriteBuffer
	mov	b,#0x40
	lcall	_enqueue
	dec	sp
;	SRC/test_led.c:110: beginTranslation();
	lcall	_beginTranslation
;	SRC/test_led.c:111: verifyAndSave();
	lcall	_verifyAndSave
	sjmp	00111$
00106$:
;	SRC/test_led.c:114: tempForExpression[expressionByteNumber]=savedKeyChar;
	mov	a,_expressionByteNumber
	add	a,#_tempForExpression
	mov	r0,a
	mov	@r0,_savedKeyChar
;	SRC/test_led.c:115: expressionByteNumber++;
	inc	_expressionByteNumber
00111$:
	pop	psw
	pop	(0+1)
	pop	(0+0)
	pop	(0+7)
	pop	(0+6)
	pop	(0+5)
	pop	(0+4)
	pop	(0+3)
	pop	(0+2)
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	pop	bits
	reti
;------------------------------------------------------------
;Allocation info for local variables in function 'KeyPressedInterrupt'
;------------------------------------------------------------
;buttonPressed             Allocated to registers r2 
;------------------------------------------------------------
;	SRC/test_led.c:121: void KeyPressedInterrupt(void) __interrupt (0){
;	-----------------------------------------
;	 function KeyPressedInterrupt
;	-----------------------------------------
_KeyPressedInterrupt:
	push	bits
	push	acc
	push	b
	push	dpl
	push	dph
	push	(0+2)
	push	(0+3)
	push	(0+4)
	push	(0+5)
	push	(0+6)
	push	(0+7)
	push	(0+0)
	push	(0+1)
	push	psw
	mov	psw,#0x00
;	SRC/test_led.c:123: number++;
	inc	_number
;	SRC/test_led.c:125: expressionReceiving=1;
	mov	_expressionReceiving,#0x01
;	SRC/test_led.c:126: if(delays)
	mov	a,_delays
	jz	00102$
;	SRC/test_led.c:127: return;
	sjmp	00107$
00102$:
;	SRC/test_led.c:129: buttonPressed = kb_read_button_code();
	lcall	_kb_read_button_code
	mov	r2,dpl
;	SRC/test_led.c:130: if (buttonPressed == -1||buttonPressed==-2){
	cjne	r2,#0xFF,00112$
	sjmp	00103$
00112$:
	cjne	r2,#0xFE,00104$
00103$:
;	SRC/test_led.c:132: return;
	sjmp	00107$
00104$:
;	SRC/test_led.c:135: delays = 1;
	mov	_delays,#0x01
;	SRC/test_led.c:136: savedKeyChar = buttonPressed;
	mov	_savedKeyChar,r2
;	SRC/test_led.c:137: SetDelayTimer(0xffff);
	mov	dptr,#0xFFFF
	lcall	_SetDelayTimer
;	SRC/test_led.c:139: TCON&=0xFD;
	anl	_TCON,#0xFD
00107$:
	pop	psw
	pop	(0+1)
	pop	(0+0)
	pop	(0+7)
	pop	(0+6)
	pop	(0+5)
	pop	(0+4)
	pop	(0+3)
	pop	(0+2)
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	pop	bits
	reti
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;first                     Allocated to registers r2 
;second                    Allocated to registers r3 
;third                     Allocated to registers 
;hundredsDec               Allocated to registers r2 
;dozensDec                 Allocated to registers r4 
;unitsDec                  Allocated to registers r3 
;result                    Allocated to registers r3 
;firstValue                Allocated to registers r4 
;secondValue               Allocated to registers r5 
;------------------------------------------------------------
;	SRC/test_led.c:146: void main (void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	SRC/test_led.c:152: queueInit(&writeBuffer);
	mov	dptr,#_writeBuffer
	mov	b,#0x40
	lcall	_queueInit
;	SRC/test_led.c:153: queueInit(&readBuffer);
	mov	dptr,#_readBuffer
	mov	b,#0x40
	lcall	_queueInit
;	SRC/test_led.c:154: write_max(ENA,0x60);
	mov	a,#0x60
	push	acc
	mov	dptr,#0x0004
	lcall	_write_max
	dec	sp
;	SRC/test_led.c:156: initUart(&writeBuffer,&interruptWriteBuffer);
	mov	a,#_interruptWriteBuffer
	push	acc
	mov	a,#(_interruptWriteBuffer >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	mov	dptr,#_writeBuffer
	mov	b,#0x40
	lcall	_initUart
	dec	sp
	dec	sp
	dec	sp
;	SRC/test_led.c:157: SetVector(0x2003, (void*)KeyPressedInterrupt);
	mov	r2,#_KeyPressedInterrupt
	mov	r3,#(_KeyPressedInterrupt >> 8)
	mov	r4,#0x80
	push	ar2
	push	ar3
	push	ar4
	mov	dptr,#0x2003
	lcall	_SetVector
	dec	sp
	dec	sp
	dec	sp
;	SRC/test_led.c:158: EX0=1;
	setb	_EX0
;	SRC/test_led.c:160: TCON|=0x01;
	orl	_TCON,#0x01
;	SRC/test_led.c:161: SetVector(0x200B, (void*)DelayExpired);
	mov	r2,#_DelayExpired
	mov	r3,#(_DelayExpired >> 8)
	mov	r4,#0x80
	push	ar2
	push	ar3
	push	ar4
	mov	dptr,#0x200B
	lcall	_SetVector
	dec	sp
	dec	sp
	dec	sp
;	SRC/test_led.c:162: ET0 = 1;
	setb	_ET0
;	SRC/test_led.c:163: EA = 1;
	setb	_EA
;	SRC/test_led.c:165: SetDelayTimer(0xffff);
	mov	dptr,#0xFFFF
	lcall	_SetDelayTimer
;	SRC/test_led.c:167: enqueue(&writeBuffer, 'g');
	mov	a,#0x67
	push	acc
	mov	dptr,#_writeBuffer
	mov	b,#0x40
	lcall	_enqueue
	dec	sp
;	SRC/test_led.c:168: beginTranslation();	
	lcall	_beginTranslation
00124$:
;	SRC/test_led.c:172: first = dequeue(&readBuffer);
	mov	dptr,#_readBuffer
	mov	b,#0x40
	lcall	_dequeue
;	SRC/test_led.c:174: if (first==0)			
	mov	a,dpl
	mov	r2,a
	jz	00124$
;	SRC/test_led.c:178: second = dequeue(&readBuffer);
	mov	dptr,#_readBuffer
	mov	b,#0x40
	push	ar2
	lcall	_dequeue
	mov	r3,dpl
	pop	ar2
;	SRC/test_led.c:179: if(second != '#'){
	cjne	r3,#0x23,00138$
	sjmp	00113$
00138$:
;	SRC/test_led.c:180: third = dequeue(&readBuffer);
	mov	dptr,#_readBuffer
	mov	b,#0x40
	push	ar2
	push	ar3
	lcall	_dequeue
	pop	ar3
	pop	ar2
;	SRC/test_led.c:181: if(first>='A')
	cjne	r2,#0x41,00139$
00139$:
	jc	00104$
;	SRC/test_led.c:182: firstValue=first-'A'+0xA;
	mov	a,#0xC9
	add	a,r2
	mov	r4,a
	sjmp	00105$
00104$:
;	SRC/test_led.c:184: firstValue=first-'0';
	mov	a,r2
	add	a,#0xd0
	mov	r4,a
00105$:
;	SRC/test_led.c:185: if(second>='A')
	cjne	r3,#0x41,00141$
00141$:
	jc	00107$
;	SRC/test_led.c:186: secondValue=second-'A'+0xA;
	mov	a,#0xC9
	add	a,r3
	mov	r5,a
	sjmp	00108$
00107$:
;	SRC/test_led.c:188: secondValue=second-'0';
	mov	a,r3
	add	a,#0xd0
	mov	r5,a
00108$:
;	SRC/test_led.c:189: result = (firstValue<<4)+(secondValue);
	mov	a,r4
	swap	a
	anl	a,#0xf0
	mov	r3,a
	mov	a,r5
	add	a,r3
	mov	r5,a
	mov	r3,a
	sjmp	00114$
00113$:
;	SRC/test_led.c:192: if(first>='A')
	cjne	r2,#0x41,00143$
00143$:
	jc	00110$
;	SRC/test_led.c:193: firstValue=first-'A'+0xA;
	mov	a,#0xC9
	add	a,r2
	mov	r4,a
	sjmp	00111$
00110$:
;	SRC/test_led.c:195: firstValue=first-'0';
	mov	a,r2
	add	a,#0xd0
	mov	r4,a
00111$:
;	SRC/test_led.c:196: result = firstValue;
	mov	ar3,r4
00114$:
;	SRC/test_led.c:199: hundredsDec = result/100;
	mov	b,#0x64
	mov	a,r3
	div	ab
	mov	r2,a
;	SRC/test_led.c:200: if (result>=100)
	cjne	r3,#0x64,00145$
00145$:
	jc	00116$
;	SRC/test_led.c:201: dozensDec = (result%100)/10;
	mov	b,#0x64
	mov	a,r3
	div	ab
	mov	r4,b
	mov	b,#0x0A
	mov	a,r4
	div	ab
	mov	r4,a
	sjmp	00117$
00116$:
;	SRC/test_led.c:203: dozensDec = result/10;
	mov	b,#0x0A
	mov	a,r3
	div	ab
	mov	r4,a
00117$:
;	SRC/test_led.c:204: unitsDec = result%10;
	mov	b,#0x0A
	mov	a,r3
	div	ab
	mov	r3,b
;	SRC/test_led.c:205: if(hundredsDec!=0)
	mov	a,r2
	jz	00119$
;	SRC/test_led.c:206: enqueue(&writeBuffer, hundredsDec+'0');
	mov	a,#0x30
	add	a,r2
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#_writeBuffer
	mov	b,#0x40
	lcall	_enqueue
	dec	sp
	pop	ar4
	pop	ar3
	pop	ar2
00119$:
;	SRC/test_led.c:207: if(dozensDec!=0||hundredsDec!=0)
	mov	a,r4
	jnz	00120$
	mov	a,r2
	jz	00121$
00120$:
;	SRC/test_led.c:208: enqueue(&writeBuffer, dozensDec + '0');			
	mov	a,#0x30
	add	a,r4
	mov	r4,a
	push	ar3
	push	ar4
	mov	dptr,#_writeBuffer
	mov	b,#0x40
	lcall	_enqueue
	dec	sp
	pop	ar3
00121$:
;	SRC/test_led.c:209: enqueue(&writeBuffer, unitsDec +'0');
	mov	a,#0x30
	add	a,r3
	mov	r3,a
	push	ar3
	mov	dptr,#_writeBuffer
	mov	b,#0x40
	lcall	_enqueue
	dec	sp
;	SRC/test_led.c:210: beginTranslation();
	lcall	_beginTranslation
	ljmp	00124$
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)

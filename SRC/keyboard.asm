;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Mar 22 2009) (UNIX)
; This file was generated Sun Nov 10 18:56:34 2013
;--------------------------------------------------------
	.module keyboard
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _kb_read_button_code
	.globl _kb_read_row_number
	.globl _kb_select_col
	.globl _kb_wtite_col
	.globl _kb_read_row
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (DATA)
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (DATA)
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_symbolTable:
	.ds 16
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area OSEG    (OVR,DATA)
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
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;	SRC/keyboard.c:3: static char symbolTable[]={'1','2','3','A','4','5','6','B','7','8','9','C','*','0','#','D'};
	mov	_symbolTable,#0x31
	mov	(_symbolTable + 0x0001),#0x32
	mov	(_symbolTable + 0x0002),#0x33
	mov	(_symbolTable + 0x0003),#0x41
	mov	(_symbolTable + 0x0004),#0x34
	mov	(_symbolTable + 0x0005),#0x35
	mov	(_symbolTable + 0x0006),#0x36
	mov	(_symbolTable + 0x0007),#0x42
	mov	(_symbolTable + 0x0008),#0x37
	mov	(_symbolTable + 0x0009),#0x38
	mov	(_symbolTable + 0x000a),#0x39
	mov	(_symbolTable + 0x000b),#0x43
	mov	(_symbolTable + 0x000c),#0x2A
	mov	(_symbolTable + 0x000d),#0x30
	mov	(_symbolTable + 0x000e),#0x23
	mov	(_symbolTable + 0x000f),#0x44
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'kb_read_row'
;------------------------------------------------------------
;------------------------------------------------------------
;	SRC/keyboard.c:5: unsigned char kb_read_row(void){
;	-----------------------------------------
;	 function kb_read_row
;	-----------------------------------------
_kb_read_row:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	SRC/keyboard.c:6: return (read_max(KB)>>4);
	mov	dptr,#0x0000
	lcall	_read_max
	mov	a,dpl
	swap	a
	anl	a,#0x0f
	mov	dpl,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'kb_wtite_col'
;------------------------------------------------------------
;column                    Allocated to registers r2 
;------------------------------------------------------------
;	SRC/keyboard.c:10: void kb_wtite_col(unsigned char column){
;	-----------------------------------------
;	 function kb_wtite_col
;	-----------------------------------------
_kb_wtite_col:
	mov	r2,dpl
;	SRC/keyboard.c:11: write_max(KB, column);
	push	ar2
	mov	dptr,#0x0000
	lcall	_write_max
	dec	sp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'kb_select_col'
;------------------------------------------------------------
;columnNumber              Allocated to registers r2 
;columnValue               Allocated to registers r2 
;------------------------------------------------------------
;	SRC/keyboard.c:15: void kb_select_col(unsigned char columnNumber){
;	-----------------------------------------
;	 function kb_select_col
;	-----------------------------------------
_kb_select_col:
	mov	r2,dpl
;	SRC/keyboard.c:17: columnValue<<=columnNumber;
	mov	b,r2
	inc	b
	mov	a,#0x01
	sjmp	00105$
00103$:
	add	a,acc
00105$:
	djnz	b,00103$
;	SRC/keyboard.c:18: kb_wtite_col(~columnValue);
	cpl	a
	mov	dpl,a
	ljmp	_kb_wtite_col
;------------------------------------------------------------
;Allocation info for local variables in function 'kb_read_row_number'
;------------------------------------------------------------
;read_row_result           Allocated to registers r2 
;------------------------------------------------------------
;	SRC/keyboard.c:23: char kb_read_row_number(){
;	-----------------------------------------
;	 function kb_read_row_number
;	-----------------------------------------
_kb_read_row_number:
;	SRC/keyboard.c:27: read_row_result = kb_read_row();
	lcall	_kb_read_row
	mov	r2,dpl
;	SRC/keyboard.c:28: switch (read_row_result){
	cjne	r2,#0x07,00114$
	sjmp	00104$
00114$:
	cjne	r2,#0x0B,00115$
	sjmp	00103$
00115$:
	cjne	r2,#0x0D,00116$
	sjmp	00102$
00116$:
	cjne	r2,#0x0E,00117$
	sjmp	00101$
00117$:
;	SRC/keyboard.c:29: case 0x0E:
	cjne	r2,#0x0F,00106$
	sjmp	00105$
00101$:
;	SRC/keyboard.c:30: return 0;
	mov	dpl,#0x00
;	SRC/keyboard.c:31: case 0x0D:
	ret
00102$:
;	SRC/keyboard.c:32: return 1;
	mov	dpl,#0x01
;	SRC/keyboard.c:33: case 0x0B:
	ret
00103$:
;	SRC/keyboard.c:34: return 2;
	mov	dpl,#0x02
;	SRC/keyboard.c:35: case 0x07:
	ret
00104$:
;	SRC/keyboard.c:36: return 3;
	mov	dpl,#0x03
;	SRC/keyboard.c:37: case 0x0F:
	ret
00105$:
;	SRC/keyboard.c:38: return -2;
	mov	dpl,#0xFE
;	SRC/keyboard.c:39: }
;	SRC/keyboard.c:40: return -1;
	ret
00106$:
	mov	dpl,#0xFF
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'kb_read_button_code'
;------------------------------------------------------------
;pressed                   Allocated to registers 
;btnNumber                 Allocated to registers r2 
;rowNumber                 Allocated to registers r4 
;i                         Allocated to registers r3 
;tempi                     Allocated to registers 
;------------------------------------------------------------
;	SRC/keyboard.c:45: char kb_read_button_code(void){
;	-----------------------------------------
;	 function kb_read_button_code
;	-----------------------------------------
_kb_read_button_code:
;	SRC/keyboard.c:47: char btnNumber=-1;
	mov	r2,#0xFF
;	SRC/keyboard.c:51: for(i=0;i<4;i++){
	mov	r3,#0x00
00106$:
	clr	c
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x84
	jnc	00109$
;	SRC/keyboard.c:52: kb_select_col(i);
	mov	dpl,r3
	push	ar2
	push	ar3
	lcall	_kb_select_col
;	SRC/keyboard.c:53: rowNumber=kb_read_row_number();
	lcall	_kb_read_row_number
	mov	r4,dpl
	pop	ar3
	pop	ar2
;	SRC/keyboard.c:54: if(rowNumber==-2)
	cjne	r4,#0xFE,00120$
	sjmp	00108$
00120$:
;	SRC/keyboard.c:56: if((rowNumber==-1)||(btnNumber!=-1)){			
	cjne	r4,#0xFF,00121$
	sjmp	00103$
00121$:
	cjne	r2,#0xFF,00122$
	sjmp	00104$
00122$:
00103$:
;	SRC/keyboard.c:57: return -1;
	mov	dpl,#0xFF
	ret
00104$:
;	SRC/keyboard.c:59: btnNumber=(rowNumber<<2)|i;
	mov	a,r4
	add	a,r4
	add	a,acc
	mov	r4,a
	mov	a,r3
	orl	ar4,a
	mov	ar2,r4
;	SRC/keyboard.c:60: tempi=i;
00108$:
;	SRC/keyboard.c:51: for(i=0;i<4;i++){
	inc	r3
	sjmp	00106$
00109$:
;	SRC/keyboard.c:63: if(btnNumber==-1)
	cjne	r2,#0xFF,00111$
;	SRC/keyboard.c:64: return -2;
	mov	dpl,#0xFE
	ret
00111$:
;	SRC/keyboard.c:65: return symbolTable[btnNumber];
	mov	a,r2
	add	a,#_symbolTable
	mov	r0,a
	mov	dpl,@r0
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)

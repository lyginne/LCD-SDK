# ---------------------------------------------------------------------------
# Имя проекта

NAME	= keyboard-sdk

# Настройки компилятора и линкера

CC      = sdcc
CFLAGS  = -I./INCLUDE -c --stack-auto
LFLAGS  = --code-loc 0x2100 --xram-loc 0x6000 --stack-auto --stack-loc 0x80 

# Настройки системы автоинкремента версии сборки

PROJECT  = $(shell cat PROJECT)
VERSION  = $(shell cat VERSION)
BUILD    = $(shell cat BUILD)
TYPE     = $(shell cat TYPE)

PROJNAME = ${PROJECT}-${VERSION}-${BUILD}-${TYPE}
TARBALL  = ${PROJNAME}.tar

# Настройки M3P

M3P		 = m3p
COMPORT	 = /dev/ttyS1
COMLOG	 = com_log.txt
BAUD	 = 9600	

# Каталоги с исходными текстами

SRC_DIR = SRC
# ---------------------------------------------------------------------------

all: test_led

clean:
	-rm -f  $(NAME).hex \
			$(NAME).bin \
			$(NAME).map \
			$(NAME).mem \
			$(NAME).lnk \
			pm3p_*.txt \
			com?_log.txt \
			$(TARBALL).gz \
			$(SRC_DIR)/*.asm \
			$(SRC_DIR)/*.rel \
			$(SRC_DIR)/*.rst \
			$(SRC_DIR)/*.sym \
			$(SRC_DIR)/*.lst 

load:
	$(M3P) lfile load.m3p


dist:
	tar cvf $(TARBALL) *
	gzip $(TARBALL)

term:
	$(M3P) echo $(COMLOG) $(BAUD)  openchannel $(COMPORT) +echo 6 term -echo bye


LIST_SRC = \
$(SRC_DIR)/led.c \
$(SRC_DIR)/max.c \
$(SRC_DIR)/keyboard-sdk.c \
$(SRC_DIR)/queue.c \
$(SRC_DIR)/interrupt.c \
$(SRC_DIR)/keyboard.c \
$(SRC_DIR)/uart.c \
$(SRC_DIR)/timer.c \
$(SRC_DIR)/sound.c

LIST_OBJ = $(LIST_SRC:.c=.rel)

test_led : $(LIST_OBJ) makefile
	$(CC) $(LIST_OBJ) -o keyboard-sdk.hex $(LFLAGS)
	$(M3P) hb166 keyboard-sdk.hex keyboard-sdk.bin bye


$(LIST_OBJ) : %.rel : %.c makefile
	$(CC) -c $(CFLAGS) $< -o $@  

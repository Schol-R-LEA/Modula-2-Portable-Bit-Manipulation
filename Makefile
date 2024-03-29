# This is a list of all non-source files that are part of the distribution.
AUX      = Makefile README.md LICENSE .gitignore

CC_PATH  = $(HOME)/opt/bin
COMPILER = $(CC_PATH)/gm2
FLAGS    = -g
INC      = defs
SRC      = impls
OBJ      = objs
BIN      = bin
TESTS    = tests

tests_portable: portable $(INC)/CardBitOps.def $(OBJ)/portable/CardBitOps.o
	$(COMPILER) $(FLAGS) -I$(INC)/ \
	$(OBJ)/portable/CardBitOps.o $(TESTS)/CardBitOpsTests.mod \
	-o $(BIN)/portable/CardBitOpsTests


tests_gnu_x86_64: gnu_x86_64 $(INC)/CardBitOps.def $(OBJ)/gnu/x86_64/CardBitOps.o
	$(COMPILER) $(FLAGS) -I$(INC)/ \
	$(OBJ)/gnu/x86_64/CardBitOps.o $(TESTS)/CardBitOpsTests.mod \
	-o $(BIN)/gnu/x86_64/CardBitOpsTests


portable: directories $(SRC)/portable/CardBitOps.mod $(INC)/CardBitOps.def
	$(COMPILER) $(FLAGS) -I$(INC)/ \
	-c $(SRC)/portable/CardBitOps.mod \
	-o $(OBJ)/portable/CardBitOps.o


gnu_x86_64: directories $(SRC)/gnu/x86_64/CardBitOps.mod $(INC)/CardBitOps.def
	$(COMPILER) $(FLAGS) -I$(INC)/ \
	-c $(SRC)/gnu/x86_64/CardBitOps.mod \
	-o $(OBJ)/gnu/x86_64/CardBitOps.o


directories:
	touch objs/
	touch bin/
	touch objs/gnu/x86_64/
	touch bin/gnu/x86_64/

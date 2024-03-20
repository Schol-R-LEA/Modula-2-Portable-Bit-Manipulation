# This is a list of all non-source files that are part of the distribution.
AUX      := Makefile README.md LICENSE .gitignore


CC_PATH  := $(HOME)/opt/bin
COMPILER := $(CC_PATH)/gm2
FLAGS    := -g -freport-bug
INC      := defs
SRC      := impls
OBJ      := objs
BIN      := bin
TESTS    := tests


tests: $(INC)/CardBitOps.def $(OBJ)/CardBitOps.o
	$(COMPILER) $(FLAGS) -I$(INC)/ \
	$(OBJ)/CardBitOps.o $(TESTS)/CardBitOpsTests.mod \
	-o $(BIN)/CardBitOpsTests


portable: $(SRC)/portable/CardBitOps.mod $(INC)/CardBitOps.def
	$(COMPILER) $(FLAGS) -I$(INC)/ \
	-c $(SRC)/portable/CardBitOps.mod \
	-o $(OBJ)/CardBitOps.o


gnu: $(SRC)/gnu/CardBitOps.mod $(INC)/CardBitOps.def
	$(COMPILER) $(FLAGS) -I$(INC)/ \
	-c $(SRC)/gnu/CardBitOps.mod \
	-o $(OBJ)/CardBitOps.o
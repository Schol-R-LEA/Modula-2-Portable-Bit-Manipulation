# This is a list of all non-source files that are part of the distribution.
AUX      := Makefile README.md LICENSE .gitignore


CC_PATH  := $(HOME)/opt/bin
COMPILER := $(CC_PATH)/gm2
FLAGS    := -g
INC      := defs
SRC      := impls
OBJ      := objs
BIN      := bin
TESTS    := tests


tests: $(INC)/Bitwise.def $(OBJ)/Bitwise.o
	$(COMPILER) $(FLAGS) -I$(INC)/ \
	$(OBJ)/Bitwise.o $(TESTS)/BitwiseTests.mod \
	-o $(BIN)/BitwiseTests


generic: $(SRC)/generic/Bitwise.mod $(INC)/Bitwise.def
	$(COMPILER) $(FLAGS) -I$(INC)/ \
	-c $(SRC)/generic/Bitwise.mod \
	-o $(OBJ)/Bitwise.o


gnu: $(SRC)/gnu/Bitwise.mod $(INC)/Bitwise.def
	$(COMPILER) $(FLAGS) -I$(INC)/ \
	-c $(SRC)/gnu/Bitwise.mod \
	-o $(OBJ)/Bitwise.o
all: parser.o lexer.o
	gcc parser.o lexer.o -lfl -o calc 

parser.c: calc.y
	bison -v -g -d -o parser.c calc.y

lexer.c: calc.lex parser.c
	flex -o lexer.c calc.lex

%.o: %.c
	gcc -c $< -o $@

clean:
	rm -f *.o calc parser.c lexer.c parser.h *.output *.dot
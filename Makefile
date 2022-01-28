all: parser.o lexer.o
	gcc parser.o lexer.o -lfl -o mini 

parser.c: mini_1.y
	bison -v -g -d -o parser.c mini_1.y

lexer.c: mini_1.lex parser.c
	flex -o lexer.c mini_1.lex

%.o: %.c
	gcc -c $< -o $@

clean:
	rm -f *.o mini parser.c lexer.c parser.h *.output *.dot calc parser

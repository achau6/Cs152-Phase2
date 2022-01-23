/* calculator. */
%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *msg);

%}

%union{
  int ival;
  /* other types of definition */
}

%error-verbose
%locations

%start S

%token <ival> INT

%% 

S: INT {
    printf("In parser: %d\n", $1);
}

%% 

int main(int argc, char **argv) {
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
   printf("** Line %d: %s\n", yylloc.first_line, msg);
}
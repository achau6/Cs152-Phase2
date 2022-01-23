   /* cs152-calculator */

%{
   /* write your C code here for defination of variables and including headers */
#include "parser.h"
%}


   /* some common rules, for example DIGIT */
DIGIT    [0-9]
   
%%
   /* specific lexer rules in regex */

"="            {printf("EQUAL\n"); }
{DIGIT}+       {printf("NUMBER %s\n", yytext); yylval.ival = atoi(yytext); return INT; }

%%
	/* C functions used in lexer */
   /* remove your original main function */

/* calculator. */
%{
#include <stdio.h>
#include <stdlib.h>
extern FILE * yyin;
void yyerror(const char *msg);

%}

%union{
  int ival;
  char* identval
}

%define parse.error verbose
%locations

/*Rename to program because of syntax document*/
%start Program

/*Change int to NUMBER b/c int and integer is confusing*/
%token <ival> NUMBER
%token <identval> IDENT

%token FUNCTION
%token BEGIN_PARAMS
%token END_PARAMS
%token BEGIN_LOCALS
%token END_LOCALS
%token BEGIN_BODY
%token END_BODY
%token INTEGER
%token ARRAY
%token OF
%token IF
%token THEN
%token ENDIF
%token ELSE
%token WHILE
%token DO
%token BEGINLOOP
%token ENDLOOP
%token CONTINUE
%token BREAK
%token READ
%token WRITE
%token NOT
%token TRUE
%token FALSE
%token RETURN
%left SUB
%left ADD
%left MULT
%left DIV
%left MOD
%token SEMICOLON
%token COLON
%token COMMA
%left L_PAREN
%left R_PAREN
%left L_SQUARE_BRACKET
%left R_SQUARE_BRACKET
%left EQ
%left NEQ
%left LT
%left GT
%left LTE
%left GTE
%right ASSIGN

%% 

Program: Functions {printf("Program -> Functions\n");};

Functions: %empty {
   printf("Functions -> epsilon\n");
}  | Function Functions {
   printf("Functions -> Function Functions\n");

};

Identifier: IDENT {printf("ident -> IDENT %s\n", yylval.identval);};
Identifiers: Identifier {printf("Identifiers -> Identifier\n");};

Function: FUNCTION Identifier SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY {
   printf("Function -> FUNCTION Identifier SEMICOLON BEGIN_PARAMS Declarations SEMICOLON END_PARAMS BEGIN_LOCALS Declarations SEMICOLON END_LOCALS BEGIN_BODY Statements SEMICOLON END_BODY\n");
};

Declarations: %empty {
   printf("Declarations -> epsilon\n");
} | Declaration SEMICOLON Declarations {
   printf("Declarations -> Declaration SEMICOLON Declarations\n");
};

Declaration: Identifiers COLON INTEGER {
   printf("Declaration -> Identifiers COLON INTEGER\n");
} | Identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {
   printf("Declaration -> Identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");
};

Statements: %empty {
   printf("Statements -> epsilon\n");
}  | Statement SEMICOLON Statements {
   printf("Statements -> Statement SEMICOLON Statements\n");
};

ElseStatement: ELSE Statements {
   printf("ElseStatement -> ELSE Statements\n");
} | %empty {
   printf("ElseStatement -> epsilon");
};
Statement: Var ASSIGN Expression {
   printf("Statement -> Var ASSIGN Expression\n");
} | IF BoolExp THEN Statements ElseStatement ENDIF {
   printf("Statement -> IF BoolExp THEN Statements ElseStatement ENDIF\n");
} | WHILE BoolExp BEGINLOOP Statements ENDLOOP {
   printf("Statement -> WHILE BoolExp BEGINLOOP Statements ENDLOOP\n");
} | DO BEGINLOOP Statements ENDLOOP WHILE BoolExp {
   printf("Statement -> DO BEGINLOOP Statements ENDLOOP WHILE BoolExp\n");
} | READ Var {
   printf("Statement -> READ Var\n");
} | WRITE Var {
   printf("Statement -> WRITE Var\n");
} | CONTINUE {
   printf("Statement -> CONTINUE\n");
} | BREAK {
   printf("Statement -> BREAK\n");
} | RETURN Expression {
   printf("Statement -> RETURN Expression\n");
};


BoolExp: Expression Comp Expression {
   printf("BoolExp -> Expression Comp Expression\n");
} | NOT BoolExp {
   printf("BoolExp -> NOT BoolExp\n");
};

Comp: ASSIGN {
   printf("Comp -> ASSIGN\n");
} | NEQ {
   printf("Comp -> NEQ\n");
} | LT {
   printf("Comp -> LT\n");
} | GT {
   printf("Comp -> GT\n");
} | LTE {
   printf("Comp -> LTE\n");
} | GTE {
   printf("Comp -> GTE\n");
};

Expression: MultExp {
   printf("Expression -> MultExp\n");
} | MultExp ADD Expression{
   printf("Expression -> MultExp ADD Expression\n");
} | MultExp SUB Expression{
   printf("Expression -> MultExp SUB Expression\n");
}; 

MultExp: Term {
   printf("MultExp -> Term\n");
} | MultExp Term MULT MultExp{
   printf("MultExp -> Term MULT MultExp\n");
} | MultExp Term DIV MultExp{
   printf("MultExp -> Term DIV MultExp\n");
} | MultExp Term MOD MultExp{
   printf("MultExp -> Term MOD MultExp\n");
}; 

Term:  Var {
   printf("Term -> Var\n");
} | NUMBER {
   printf("Term -> NUMBER\n");
} | L_PAREN Expression R_PAREN {
   printf("Term -> L_PAREN Expression R_PAREN\n");
} | Identifier L_PAREN Expression R_PAREN {
   printf("Term -> L_PAREN Expression R_PAREN\n");
} | Identifier L_PAREN Expression COMMA R_PAREN { /*Check this rule*/
   printf("Term -> L_PAREN Expression COMMA R_PAREN\n"); 
} | Identifier L_PAREN R_PAREN {
   printf("Term -> L_PAREN R_PAREN\n");
}; 

Var: Identifier {
   printf("Var -> Identifier\n");
} | Identifier L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {
   printf("Var -> Identifier L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");
};


%% 

int main(int argc, char **argv) {
   if (argc > 1) {
      yyin = fopen(argv[1], "r");
      if (yyin == 0) {
         printf("Error Open File %s\n", argv[0]);
      }
   }
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
   printf("** Line %d: %s\n", yylloc.first_line, msg);
}
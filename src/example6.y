%{
#include <stdio.h>

int yyparse();
int yylex();

void yyerror(const char *str)
{
    fprintf(stderr, "error: %s\n", str);
}

int yywrap()
{
    return 1;
}

int main()
{
    return yyparse();
}

/**
    To parse something like:

    person "John" {
        age 23;
        gender male;
    };

    person "Ann" {
        age 20;
        gender female;
    }
*/
%}

%token PERSONTOK NAMETOK AGETOK GENDERTOK OBRACE EBRACE QUOTE SEMICOLON STR NUM
%union {
    char *sval;
    int ival;
}
%type<sval> quoted_string STR
%type<ival> NUM

%%
commands:
    | commands command SEMICOLON
    ;

command:
    PERSONTOK quoted_string person_block { printf("\tGot name: %s\n", $2); }
    ;

quoted_string:
    QUOTE STR QUOTE { $$ = $2; }
    ;

person_block:
    OBRACE statements EBRACE
    ;

statements:
    | statements statement SEMICOLON
    ;

statement:
    AGETOK NUM { printf("\tGot age: %d\n", $2); }
    | GENDERTOK STR { printf("\tGot gender: %s\n", $2); }
    ;
%%

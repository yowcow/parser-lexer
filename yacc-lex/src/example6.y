%{
#include <stdio.h>
#include <stdlib.h>
#include "example6.h"

extern int yylex();
extern int yywrap();
extern void yyerror(const char *str);

int yywrap()
{
    return 1;
}

void yyerror(const char *str)
{
    fprintf(stderr, "error: %s\n", str);
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
    PERSONTOK quoted_string person_block {
        p->name = $2;

        int idx = count;
        count++;

        ppl = realloc(ppl, sizeof(Person**) * count);
        ppl[idx] = p;

        p = malloc(sizeof(Person*));
    }
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
    AGETOK NUM { p->age = $2; }
    | GENDERTOK STR { p->gender = $2; }
    ;
%%

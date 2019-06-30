%option noinput
%option nounput

%{
#include <stdio.h>
#include "example6.tab.h"
%}

%%
person  { return PERSONTOK; }
name    { return NAMETOK; }
age     { return AGETOK; }
gender  { return GENDERTOK; }

[a-zA-Z][a-zA-Z\s]* {
    yylval.sval = strdup(yytext); // TODO free
    return STR;
}

[0-9]+ {
    yylval.ival = atoi(yytext);
    return NUM;
}

\{      { return OBRACE; }
\}      { return EBRACE; }
\"      { return QUOTE; }
;       { return SEMICOLON; }
\n      /* ignore */;
[\s\t]+ /* ignore */;
%%

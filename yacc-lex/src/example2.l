%option noinput
%option nounput

%{
#include <stdio.h>
%}

%%
[0-9]+                  printf("It's a NUMBER\n");
[a-zA-Z][a-zA-Z0-9]*    printf("It's a WORD\n");
%%

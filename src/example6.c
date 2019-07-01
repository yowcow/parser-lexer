#include <stdio.h>
#include <stdlib.h>
#include "example6.h"

extern int yyparse();
extern FILE* yyin;

int count = 0;
Person* p;
Person** ppl;

int main(int argc, char* argv[])
{
    if (argc < 2) {
        fprintf(stderr, "Usage: <bin> path/to/input.txt\n");
        return 1;
    }

    FILE* fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "Failed reading file: %s\n", argv[1]);
        return 2;
    }

    p = malloc(sizeof(Person*));
    ppl = malloc(sizeof(Person**));

    yyin = fp;
    yyparse();
    fclose(fp);

    fprintf(stdout, "\n--- Result ---\n");
    for (int i = 0; i < count; i++) {
        Person* tmp = ppl[i];

        fprintf(stdout, "-> name: %s; age: %d; gender: %s;\n", tmp->name, tmp->age, tmp->gender);

        free(tmp->name);
        free(tmp->gender);
        free(tmp);
    }

    free(p->name);
    free(p->gender);
    free(p);
    free(ppl);

    return 0;
}

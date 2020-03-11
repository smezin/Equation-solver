//
//  utility_funcs.m
//  Equation solver
//

#import <Foundation/Foundation.h>

char* get_equation ()
{
    char input[1000];
    printf("Please enter an equation with no spaces\n");
    fgets(input, 1000, stdin);
    int len = (int)strlen(input);
    char* equation = malloc(len*sizeof(char));
    for (int i=0; i<len; i++)
        equation[i]=input[i];
    equation[len-1] = '\0';                             //-1 because last char is always '\n'
    return equation;
}

int get_open_index (char *equation)                     //get the innermost (
{
    int index = -1;
    int equation_len = (int)strlen(equation);
    for (int i = 0; i < equation_len; i++)
    {
        if (equation[i] == '(')
            index = i;
        if (equation[i] == ')')
            return index;
    }
    return -1;
}


int get_closing_index (char *equation)
{
    int index = 0;
    for (;equation[index] != ')'; index++);
    return index;
}


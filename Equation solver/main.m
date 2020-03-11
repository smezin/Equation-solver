//
//  main.m
//  Equation solver
//

#import <Foundation/Foundation.h>
#include "utility_funcs.h"
#include "calculate_funcs.h"

int solve_by_order (char*);
char* calculate_operands (char*, char, char);
int solve_equation (char*);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        char *equation = get_equation();
        int result = solve_equation(equation);
        printf("\nResult: %d\n", result);
    }
    return 0;
}

int solve_equation (char *equation)
{
    printf("\n%s\n", equation);
    int open_index=-1, close_index=-1, result;
    if (!strchr(equation, '('))
        return solve_by_order(equation);
    else
    {
        open_index = get_open_index(equation);
        close_index = get_closing_index(equation);
        char *inner_equation = malloc((close_index-open_index+1)*sizeof(char));
        strncpy(inner_equation, equation+open_index+1, close_index-open_index-1);
        
        result = solve_by_order(inner_equation);
        equation = replace_subequation_with_result(equation, open_index-1, close_index+1, result);
       
        return solve_equation(equation);
    }
}

int solve_by_order (char *equation)
{
    equation = calculate_operands(equation, '*','/');
    equation = calculate_operands(equation, '+','-');
    return atoi(equation);
}

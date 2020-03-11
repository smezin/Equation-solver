//
//  calculate_funcs.m
//  Equation solver

#import <Foundation/Foundation.h>
#import "calculate_funcs.h"

char* calculate_operands (char *equation, char op1, char op2)
{
    int left_value, right_value, result, start, end, index=1;
    char operator;
    
    while (equation[index] != '\0')
    {
        if (equation[index] == op1 || equation[index] == op2)
        {
            operator = equation[index];
            left_value = extract_value_from_equation(equation, index, NO);
            right_value = extract_value_from_equation(equation, index, YES);
            result = do_the_math(left_value, operator, right_value);
            end = find_edge(equation, index, YES);
            start = find_edge(equation, index, NO);
            equation = replace_subequation_with_result(equation, start, end, result);
            printf("\n%s\n", equation);
            index = 0;
        }
        index++;
    }
    return equation;
}

int extract_value_from_equation (char* equation, int start, int is_forward)
{
    int direction = is_forward?1:-1;
    int index = start + direction;
    start += direction;
    
    if (equation[start] == '-' && is_forward)                           //if number begins with unari '-', inc index to digits location
        index++;
    for (;isdigit(equation[index]) && index >= 0;index+=direction);
    if (index == 0 && equation[0] == '-')                               //for unari -
        index = -1;
    
    char *value =(char*) malloc ((abs(index-start)+2)*sizeof(char));
    
    if (is_forward)
        strncpy(value, equation + start, index-start);
    else
        strncpy(value, equation + index + 1, start-index);
        
    return atoi(value);
}

int do_the_math (int left, char operator, int right)
{
    int result=0;
    
    switch (operator)
    {
        case '+':
            result = left + right;
            break;
        case '-':
            result = left - right;
            break;
        case '*':
            result = left * right;
            break;
        case '/':
            result = left / right;
            break;
        default:
            
            break;
    }
    return result;
}



int find_edge (char* equation, int index, int is_forward)
{
    int direction = is_forward?1:-1;
    index+=direction;
    if (is_forward && equation[index] == '-')                           //for unari -
        index++;
    for (;isdigit(equation[index]) && index>0 ;index+=direction);
   
    return index;
}

char* replace_subequation_with_result (char* equation, int start, int end, int result)
{
    int eq_len = (int)strlen(equation);
    int result_len = !result?2:(floor(log10(abs(result))) + 2);
    char *output_equation = (char*)malloc(eq_len*sizeof(char));
    char *result_as_string = (char*)malloc(result_len*sizeof(char));
    sprintf(result_as_string, "%d", result);
    
    for (int i = 0; i < eq_len; i++)
        output_equation[i]='\0';
    
    if (start != 0)
    {
        strncpy(output_equation, equation, start + 1);
        strcat(output_equation, result_as_string);
    }
    else
        strcpy(output_equation, result_as_string);
    
    if (eq_len != end)
        strncat(output_equation, equation + end, eq_len-end);
    
    return output_equation;
}

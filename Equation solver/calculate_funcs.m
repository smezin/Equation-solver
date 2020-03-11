//
//  calculate_funcs.m
//  Equation solver

#import <Foundation/Foundation.h>
#import "calculate_funcs.h"
#define GO_LEFT NO
#define GO_RIGHT YES

char* calculate_operands (char *equation, char op1, char op2)
{
    double left_value, right_value, result;
    int start, end, index=1;
    char operator;
    
    while (equation[index] != '\0')
    {
        if (equation[index] == op1 || equation[index] == op2)
        {
            operator = equation[index];
            left_value = extract_value_from_equation(equation, index, GO_LEFT);
            right_value = extract_value_from_equation(equation, index, GO_RIGHT);
            result = do_the_math(left_value, operator, right_value);
            end = find_edge(equation, index, GO_RIGHT);
            start = find_edge(equation, index, GO_LEFT);
            equation = replace_subequation_with_result(equation, start, end, result);
            printf("\n%s\n", equation);
            index = 0;
        }
        index++;
    }
    return equation;
}

double extract_value_from_equation (char* equation, int start, BOOL is_forward)
{
    int direction = is_forward?1:-1;
    int index = start + direction;
    start += direction;
    
    if (equation[start] == '-' && is_forward)                           //if number begins with unari '-', inc index to digits location
        index++;
    for (;(isdigit(equation[index]) || equation[index] == '.' ) && index >= 0;index+=direction);
    if (index == 0 && equation[0] == '-')                               //for unari -
        index = -1;
    
    char *value =(char*) malloc ((abs(index-start)+5)*sizeof(char));
    
    if (is_forward)
        strncpy(value, equation + start, index-start);
    else
        strncpy(value, equation + index + 1, start-index);
    
    return strtod(value, NULL);
}

double do_the_math (double left, char operator, double right)
{
    double result=0;
    
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

int find_edge (char* equation, int index, BOOL is_forward)
{
    int direction = is_forward?1:-1;
    index+=direction;
    if (is_forward && equation[index] == '-')                           //for unari -
        index++;
    for (;(isdigit(equation[index]) || equation[index] == '.') && index>0 ;index+=direction);
   
    return index;
}

char* replace_subequation_with_result (char* equation, int start, int end, double result)
{
    int equation_len = (int)strlen(equation);
    int result_len = (result < 1 && result > -1)?5:(floor(log10(abs((int)round(result)))) + 5);
    char *output_equation = (char*)malloc(equation_len*sizeof(char));
    char *result_as_string = (char*)malloc(result_len*sizeof(char));
    
    result *= 100;
    result = round(result);
    result /= 100;
    
    sprintf(result_as_string, "%.2lf", result);
    
    for (int i = 0; i < equation_len; i++)
        output_equation[i]='\0';
    
    if (start != 0)
    {
        strncpy(output_equation, equation, start + 1);
        strcat(output_equation, result_as_string);
    }
    else
        strcpy(output_equation, result_as_string);
    
    if (equation_len != end)
        strncat(output_equation, equation + end, equation_len-end);
    
    return output_equation;
}

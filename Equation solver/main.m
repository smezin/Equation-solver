//
//  main.m
//  Equation solver
//
//  Created by natali on 10/03/2020.
//  Copyright © 2020 hyperActive. All rights reserved.
//

#import <Foundation/Foundation.h>

int solve_equation (char*);
char* get_equation (void);
char* calculate_operands (char*, char, char);
int extract_value_from_equation (char* , int, int);
int find_edge(char*, int, int);
int do_the_math(int, char, int);
char* replace_subequation_with_result(char*, int, int, int);
void return_in_parentheses (char *equation);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        char *equation = get_equation();
        int result = solve_equation(equation);
        printf("\nResult %d\n",result);
     //   return_in_parentheses(equation);
    }
    return 0;
}

int solve_it (char *equation)
{
    
    
    return 0;
}

void return_in_parentheses (char *equation)
{
    int to = 0;
    int from = (int) strlen(equation);
    
    for (;equation[to] != ')' && to != from; to++);
    for (;equation[from] != '(' && from !=0 ;from--);
    
    printf("\nlen: %d  from: %d,  to: %d\n",(int)strlen(equation), from, to);
    
}


int solve_equation (char *equation)
{
    equation = calculate_operands(equation, '*','/');
    equation = calculate_operands(equation, '+','-');
    return atoi(equation);
}

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
            printf("%s\n", equation);
            index = 0;
        }
        index++;
    }
    return equation;
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

int find_edge (char* equation, int index, int is_forward)
{
    int direction = is_forward?1:-1;
    index+=direction;
    if (is_forward && equation[index] == '-')                           //for unari -
        index++;
    for (;isdigit(equation[index]) && index>0 ;index+=direction);
   
    return index;
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

int extract_value_from_equation (char* equation, int start, int is_forward)
{
    int direction = is_forward?1:-1;
    int index = start + direction;
    start += direction;
    
    if (equation[start] == '-' && is_forward)
        index++;
    for (;isdigit(equation[index]) && index >= 0;index+=direction);
    if (index == 0 && equation[0] == '-')                               //for unari -
        index = -1;
    
    char *value =(char*) malloc ((abs(index-start)+2)*sizeof(char));
    
    int i,j;
    if (is_forward)
        for (i = start, j = 0; i < index; i++, j++)
            value[j] = equation[i];
    else
        for (i = index + 1, j = 0; i <= start; i++, j++)
            value[j] = equation[i];
        
    value[j] = '\0';
    return atoi(value);
}

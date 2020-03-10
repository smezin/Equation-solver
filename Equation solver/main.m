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


int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        char *equation = get_equation();
        int result = solve_equation(equation);
        
    }
    return 0;
}

int solve_equation (char *equation)
{
    int result = 0;
    equation = calculate_operands(equation, '*','/');
    equation = calculate_operands(equation, '+','-');
    
    
    
    return result;
}

char* get_equation ()
{
    char input[1000];
    printf("Please enter an equation with no spaces\n");
    scanf("%s", input);
    u_long len = strlen(input)+1;
    char* equation = malloc(len*sizeof(char));
    for (int i=0; i<len; i++)
        equation[i]=input[i];
    equation[len-1] = '\0';
    return equation;
}

char* calculate_operands (char *equation, char op1, char op2)
{
    int left_value, right_value, result, start, end, index=0;
    char operator;
    
    while (equation[index] != '\0')
    {
        if (equation[index] == op1 || equation[index] == op2)
        {
            operator = equation[index];
            left_value = extract_value_from_equation(equation, index, NO);
            right_value = extract_value_from_equation(equation, index, YES);
            result = do_the_math(left_value, operator, right_value);
            
            end = find_edge(equation, index, NO);
            start = find_edge(equation, index, YES);
            equation = replace_subequation_with_result(equation, start, end, result);
            printf("%s\n", equation);
        }
        index++;
    }
    return equation;
}

char* replace_subequation_with_result (char* equation, int start, int end, int result)
{
    printf("\nstart%d  end%d\n", start, end);
    u_long eq_len = strlen(equation);
    int i;
    int result_len = !result?2:(floor(log10(abs(result))) + 2);
    
    char *result_as_string = (char*)malloc(result_len*sizeof(char));
    sprintf(result_as_string, "%d", result);

    char *left_eq_part = (char*)malloc((start+1)*sizeof(char));
    for (i = 0; i <= start && start != 0; i++)
        left_eq_part[i] = equation[i];
    left_eq_part[i] = '\0';
    
    char* right_eq_part = (char*)malloc((eq_len-end + 2)*sizeof(char));
    for (i=0; end<eq_len; end++, i++)
        right_eq_part[i] = equation[end];
    right_eq_part [i] = '\0';
    

    equation = strcat(left_eq_part, result_as_string);
    equation = strcat(equation, right_eq_part);
    
    return equation;
}

int find_edge (char* equation, int index, int find_start)
{
    int direction = find_start?-1:1;
    index+=direction;
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
        
    for (;isdigit(equation[index]) && index >= 0;index+=direction);
    if (index == 0 && equation[0] == '-')
        index = -1;
    char *value =(char*) malloc ((abs(index-start)+2)*sizeof(char));
    if (is_forward)
    {
        int i,j;
        for (i = start, j = 0; i < index; i++, j++)
            value[j] = equation[i];
        value[j] = '\0';
    }
    else //extract backwards from start
    {
        int i,j;
        for (i=index+1, j=0; i <= start; i++, j++)
            value[j] = equation[i];
        value[j] = '\0';
    }
    return atoi(value);
}


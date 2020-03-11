//
//  calculate_funcs.h
//  Equation solver

#ifndef calculate_funcs_h
#define calculate_funcs_h
char*   calculate_operands (char *equation, char op1, char op2);
double  extract_value_from_equation (char* equation, int start, BOOL is_forward);
double  do_the_math (double left, char operator, double right);
int     find_edge (char* equation, int index, BOOL is_forward);
char*   replace_subequation_with_result (char* equation, int start, int end, double result);
#endif /* calculate_funcs_h */

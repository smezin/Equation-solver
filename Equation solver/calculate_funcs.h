//
//  calculate_funcs.h
//  Equation solver

#ifndef calculate_funcs_h
#define calculate_funcs_h
char*   calculate_operands (char *equation, char op1, char op2);
int     extract_value_from_equation (char* equation, int start, int is_forward);
int     do_the_math (int left, char operator, int right);
int     find_edge (char* equation, int index, int is_forward);
char*   replace_subequation_with_result (char* equation, int start, int end, int result);
#endif /* calculate_funcs_h */

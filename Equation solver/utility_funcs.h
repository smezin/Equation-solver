//  utility_funcs.h
//  Equation solver

#ifndef utility_funcs_h
#define utility_funcs_h

char* get_equation (void);
int get_open_index (char *equation);        //getting the next '(' index. regarding nesting and multiple sets
int get_closing_index (char *equation);

#endif /* utility_funcs_h */

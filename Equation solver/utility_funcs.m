//
//  utility_funcs.m
//  Equation solver
//
//  Created by natali on 11/03/2020.
//  Copyright © 2020 hyperActive. All rights reserved.
//

#import <Foundation/Foundation.h>

int get_open_index (char *equation)
{
    int index = -1;
    int eq_len = (int)strlen(equation);
    for (int i = 0; i < eq_len; i++)
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

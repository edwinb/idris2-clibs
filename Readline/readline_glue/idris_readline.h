#ifndef _IDRIS_READLINE_H
#define _IDRIS_READLINE_H

rl_compentry_func_t* my_compentry;

void idrisrl_setCompletion(rl_compentry_func_t* fn);

char* getString(void* str);
void* mkString(char* str);
void* nullString();
int isNullString(void* str);

#endif

#include "idris_ncurses.h"

char* idris_getstr(int max) {
    char* str = malloc(max);
    getnstr(str, max);
    return str;
}

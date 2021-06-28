#ifndef __IDRIS_SDL_H
#define __IDRIS_SDL_H

#include <SDL.h>

void* simple_createWindow(char* title, int x, int y, int width, int height);
void* make_renderer(void* win);
void sdl_setRenderDrawColor(void* ren, int r, int g, int b, int a);
void sdl_renderClear(void* ren);
void sdl_renderPresent(void* ren);

#endif

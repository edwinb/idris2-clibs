#include <stdio.h>
#include "idris_sdl.h"

void* simple_createWindow(char* title, int x, int y, int width, int height) {
    SDL_Init(SDL_INIT_EVERYTHING);
    SDL_Window* win = SDL_CreateWindow(title, x, y, width, height, SDL_WINDOW_SHOWN);
    return (void*)win;
}

void* simple_createRenderer(void* w) {
    SDL_Window* win = w;
    SDL_Renderer* ren = SDL_CreateRenderer(win, -1, 0);
    return (void*)ren;
}

void sdl_setRenderDrawColor(void* x, int r, int g, int b, int a) {
    SDL_Renderer* ren = x;
    SDL_SetRenderDrawColor(ren, r, g, b, a);
}

void sdl_renderClear(void* r) {
    SDL_Renderer* ren = r;
    SDL_RenderClear(ren);
}

void sdl_renderPresent(void* r) {
    SDL_Renderer* ren = r;
    SDL_RenderPresent(ren);
}


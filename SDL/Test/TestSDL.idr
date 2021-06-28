module TestSDL

import SDL

main : IO ()
main
    = do win <- createWindow "Hi" 0 0 640 480
         ren <- createRenderer win
         sdl_setRenderDrawColor ren 0 255 255 255
         sdl_renderClear ren
         sdl_renderPresent ren

         sdlDelay 1000
         sdlQuit

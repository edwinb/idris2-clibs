module SDL

sdl : String -> String
sdl f = "C:" ++ f ++ ",libidrissdl"

data SDLWindow : Type where
  MkWindow : AnyPtr -> SDLWindow

data SDLRenderer : Type where
  MkRenderer : AnyPtr -> SDLRenderer

%foreign sdl "simple_createWindow"
prim_createWindow : String -> Int -> Int -> Int -> Int -> AnyPtr

export
createWindow : HasIO io => String -> Int -> Int -> Int -> Int -> io SDLWindow
createWindow title x y w h 
    = pure (MkWindow (prim_createWindow title x y w h))

%foreign sdl "simple_createRenderer"
prim_createRenderer : AnyPtr -> AnyPtr

export
createRenderer : HasIO io => SDLWindow -> io SDLRenderer
createRenderer (MkWindow win)
    = pure (MkRenderer (prim_createRenderer win))

%foreign sdl "sdl_setRenderDrawColor"
prim_setRenderDrawColor : AnyPtr -> Int -> Int -> Int -> Int -> PrimIO ()

export
sdl_setRenderDrawColor : HasIO io =>
                         SDLRenderer -> Int -> Int -> Int -> Int -> io ()
sdl_setRenderDrawColor (MkRenderer ren) r g b a
    = primIO $ prim_setRenderDrawColor ren r g b a

%foreign sdl "sdl_renderClear"
prim_renderClear : AnyPtr -> PrimIO ()

export
sdl_renderClear : HasIO io => SDLRenderer -> io ()
sdl_renderClear (MkRenderer ren) = primIO $ prim_renderClear ren

%foreign sdl "sdl_renderPresent"
prim_renderPresent : AnyPtr -> PrimIO ()

export
sdl_renderPresent : HasIO io => SDLRenderer -> io ()
sdl_renderPresent (MkRenderer ren) = primIO $ prim_renderPresent ren

%foreign sdl "SDL_Delay"
prim_delay : Int -> PrimIO ()

export
sdlDelay : HasIO io => Int -> io ()
sdlDelay d = primIO $ prim_delay d

%foreign sdl "SDL_Quit"
prim_quit : PrimIO ()

export
sdlQuit : HasIO io => io ()
sdlQuit = primIO $ prim_quit

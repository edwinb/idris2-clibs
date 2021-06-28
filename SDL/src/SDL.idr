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
createWindow : String -> Int -> Int -> Int -> Int -> IO SDLWindow
createWindow title x y w h 
    = pure (MkWindow (prim_createWindow title x y w h))

%foreign sdl "simple_createRenderer"
prim_createRenderer : AnyPtr -> AnyPtr

export
createRenderer : SDLWindow -> IO SDLRenderer
createRenderer (MkWindow win)
    = pure (MkRenderer (prim_createRenderer win))

%foreign sdl "sdl_setRenderDrawColor"
prim_setRenderDrawColor : AnyPtr -> Int -> Int -> Int -> Int -> PrimIO ()

export
sdl_setRenderDrawColor : SDLRenderer -> Int -> Int -> Int -> Int -> IO ()
sdl_setRenderDrawColor (MkRenderer ren) r g b a
    = primIO $ prim_setRenderDrawColor ren r g b a

%foreign sdl "sdl_renderClear"
prim_renderClear : AnyPtr -> PrimIO ()

export
sdl_renderClear : SDLRenderer -> IO ()
sdl_renderClear (MkRenderer ren) = primIO $ prim_renderClear ren

%foreign sdl "sdl_renderPresent"
prim_renderPresent : AnyPtr -> PrimIO ()

export
sdl_renderPresent : SDLRenderer -> IO ()
sdl_renderPresent (MkRenderer ren) = primIO $ prim_renderPresent ren

%foreign sdl "SDL_Delay"
prim_delay : Int -> PrimIO ()

export
sdlDelay : Int -> IO ()
sdlDelay d = primIO $ prim_delay d

%foreign sdl "SDL_Quit"
prim_quit : PrimIO ()

export
sdlQuit : IO ()
sdlQuit = primIO $ prim_quit

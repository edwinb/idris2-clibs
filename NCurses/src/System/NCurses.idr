module System.NCurses

ncurses : String -> String
ncurses fn = "C:" ++ fn ++ ",libncurses 5"

ncursesGlue : String -> String
ncursesGlue fn = "C:" ++ fn ++ ",libidrisncurses"

%foreign ncurses "refresh"
prim_refresh : PrimIO ()

export
refresh : IO ()
refresh = primIO prim_refresh

%foreign ncurses "endwin"
prim_endwin : PrimIO ()

export
endwin : IO ()
endwin = primIO prim_endwin

%foreign ncurses "getch"
prim_getch : PrimIO Char

export
getch : IO Char
getch = primIO prim_getch

%foreign ncursesGlue "idris_getstr"
prim_getstr : Int -> PrimIO String

export
getnstr : Int -> IO String
getnstr x = primIO $ prim_getstr x

%foreign ncurses "printw"
prim_printw : String -> PrimIO ()

export
printw : String -> IO ()
printw str = primIO $ prim_printw str

%foreign ncurses "initscr"
prim_initscr : PrimIO ()

export
initscr : IO ()
initscr = primIO prim_initscr 

%foreign ncurses "putchar"
prim_putchar : Char -> PrimIO ()

export
putchar : Char -> IO ()
putchar c = primIO $ prim_putchar c


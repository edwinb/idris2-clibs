import System.NCurses

main : IO ()
main 
    = do initscr
         printw "Hello ncurses world!"
         refresh
         c <- getch
         endwin

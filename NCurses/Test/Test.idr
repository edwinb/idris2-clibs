import System.NCurses

main1 : IO ()
main1
    = do initscr
         printw "Hello ncurses world!"
         refresh
         c <- getch
         endwin

getString : IO String
getString
    = do c <- getch
         if c == '\n'
            then pure ""
            else do rest <- getString
                    pure (strCons c rest)

main2 : IO ()
main2
    = do initscr
         printw "Hello ncurses world!"
         refresh
         str <- getnstr 10
         printw str
         c <- getch
         endwin

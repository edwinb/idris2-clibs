import System.Readline

testComplete : Readline io => String -> io (List String)
testComplete text = pure ["hamster", "foo", "bar"]

loop : Readline io => io ()
loop = do Just x <- readline "> "
               | Nothing => putStrLn "EOF"
          putStrLn x
          when (x /= "") $ addHistory x
          if x /= "quit"
             then loop
             else putStrLn "Done"

main : IO ()
main = do setCompletion testComplete
          loop

module Main

import Data.List
import Data.List1
import Data.Strings

import System
import System.Directory

pkgs : List String
pkgs = ["NCurses", "Readline", "SDL"]

{- A tool for building all the packages.

For each package, checks that the dependencies listed in DEPS exist, and
if they do, runs the request action (either "build", "install", or "clean".

-}

fail : String -> IO ()
fail str
    = do putStrLn str
         exitWith (ExitFailure 1)

findCC : IO String
findCC
    = do Nothing <- getEnv "CC"
              | Just cc => pure cc
         Nothing <- getEnv "IDRIS_CC"
              | Just cc => pure cc
         Nothing <- getEnv "IDRIS2_CC"
              | Just cc => pure cc
         pure "cc"

-- Check for any missing dependencies.
missingDeps : String -> IO (List String)
missingDeps pkg
    = do depfile <- readFile "DEPS"
         let deps : List String
                  = case depfile of
                         Right ds => filter notEmpty (toList (lines ds))
                         Left _ => []
         pure $ mapMaybe id !(traverse missing deps)
  where
    notEmpty : String -> Bool
    notEmpty str
        = if all isSpace (unpack str)
             then False
             else True

    missing : String -> IO (Maybe String)
    missing lib
        = do cc <- findCC
             ok <- system $ "echo \"int main(){}\" | " ++ cc ++
                            " -o /dev/null -l" ++ lib ++ " -x c - > /dev/null"
             if ok == 0
                then do putStrLn $ "Found lib" ++ lib
                        pure Nothing
                else do putStrLn $ "Can't find lib" ++ lib
                        pure (Just lib)

pkgAction : String -> String -> IO ()
pkgAction act pkg
    = do [] <- missingDeps pkg
            | ds => do putStrLn $ "Skipping " ++ pkg
                       putStrLn $ "\tdue to missing dependencies: " ++ show ds
         ok <- system $ "idris2 --" ++ act ++ " " ++ pkg ++ ".ipkg"
         if ok == 0
            then pure ()
            else exitWith (ExitFailure 1)

-- Move into the appropriate directory for a package, run the action, then
-- come back out again.
action : String -> String -> IO ()
action act pkg
    = do Just dir <- currentDir
             | Nothing => fail "Can't get current directory"
         True <- changeDir pkg
             | _ => fail $ "Can't find package directory " ++ show pkg

         pkgAction act pkg

         True <- changeDir dir
             | _ => fail $ "Can't get current directory"
         pure ()

build : IO ()
build = traverse_ (action "build") pkgs

install : IO ()
install = traverse_ (action "install") pkgs

clean : IO ()
clean = traverse_ (action "clean") pkgs

usage : IO ()
usage = putStrLn "Usage: makelibs [build | install | clean]"

main : IO ()
main
    = do [_, act] <- getArgs
             | _ => usage
         traverse_ (action act) pkgs

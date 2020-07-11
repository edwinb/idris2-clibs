module System.Readline

rlib : String -> String
rlib fn = "C:" ++ fn ++ ",libidrisreadline"

public export
interface HasIO io => Readline io where
  setCompletion : (String -> io (List String)) -> io ()

%foreign (rlib "getString")
getString : Ptr String -> String

%foreign (rlib "mkString")
mkString : String -> Ptr String

%foreign (rlib "nullString")
nullString : Ptr String

%foreign (rlib "isNullString")
prim_isNullString : Ptr String -> Int

isNullString : Ptr String -> Bool
isNullString str = if prim_isNullString str == 0 then False else True

%foreign (rlib "readline")
prim_readline : String -> PrimIO (Ptr String)

export
readline : Readline io => String -> io (Maybe String)
readline s
    = do mstr <- primIO $ prim_readline s
         if isNullString mstr
            then pure $ Nothing
            else pure $ Just (getString mstr)

%foreign (rlib "add_history")
prim_add_history : String -> PrimIO ()

export
addHistory : Readline io => String -> io ()
addHistory s = primIO $ prim_add_history s

%foreign (rlib "idrisrl_setCompletion")
prim_setCompletion : (String -> Int -> PrimIO (Ptr String)) -> PrimIO ()

rlCompletion : (String -> IO (List String)) -> String -> 
               IO (String -> Int -> IO (Maybe String))
rlCompletion ifn str
    = do all <- ifn str
         pure (\_, i => pure (find (fromInteger (cast i)) all))
  where
    find : Nat -> List String -> Maybe String
    find _ [] = Nothing
    find Z (x :: xs) = Just x
    find (S k) (x :: xs) = find k xs

export
setCompletionFn : HasIO io => (String -> IO (List String)) -> io ()
setCompletionFn fn
    = primIO $ prim_setCompletion $ \s, i => toPrim $
          do rfn <- rlCompletion fn s
             mstr <- rfn s i
             case mstr of
                  Nothing => pure nullString
                  Just str => pure (mkString str)

export
Readline IO where
  setCompletion = setCompletionFn


#!/usr/bin/runhaskell
-- Script para crear los links a los nuevos productos en una instancia plone 
-- Para usar posicionarse en el directorio apropiado, ver: http://extranet.menttes.com/desarrollo/plone/DesarrolloDeProductosSVN
-- Parametros: una lista con los directorios a ser actualizados (con tag y #), se consigue facilmente haciendo un "svn status" antes del commit

module Main where
import System
import IO 

getProd :: String -> String
getProd ('/':cs) = "" 
getProd (c:cs) = (c : getProd cs)
getProd _ = ""

--foreach :: [a] -> (a -> IO ()) -> IO ()
foreach [] accion = return ()
foreach (x:xs) accion
  = do accion x 
       foreach xs accion


main :: IO ExitCode
main = do [f] <- getArgs
	  s <- openFile f ReadMode
	  lines <- readLines s
--          putStrLn $ unlines $ map getProd lines
	  foreach lines (\l -> system("ln -s /opt/plone/"++l++" "++(getProd l)))
          hClose s
	  system "echo Done\n"
		where readLines s = do 
			  eof <- hIsEOF s
			  if eof then return [] else
                	      do
				line <- hGetLine s 
				lines <- readLines s
				return (line : lines)

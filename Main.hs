module Main where
import System.IO
import System.Directory
import System.FilePath.Posix
import System.Process
import System.Info as Info

main :: IO ()
main = do
    putStrLn "1 - Ler Campanha,\n2 - Definir Lore da campanha,\n3 - Menu de Personagem\n4 - Menu de Item,\n5 - Menu de NPC,\n9 - Sair"
    opcao <- getLine
    let action = lookup opcao menus
    verificaEntradaMenu action


verificaEntradaMenu :: Maybe (IO ()) -> IO ()
verificaEntradaMenu Nothing = putStrLn "\nEntrada Invalida brooo, vlw flw\n\n"
verificaEntradaMenu (Just a) = a


menus::[(String, IO ())]
menus = [ ("1", lerCampanha)
        ]



lerCampanha :: IO ()
lerCampanha = do
    exists <- doesFileExist filePath
    if exists
        then do
            handle <- openFile filePath ReadMode
            contents <- hGetContents handle
            system "clear"
            putStrLn $ contents
            restart main
        else do
            createDirectoryIfMissing True $ takeDirectory filePath
            writeFile filePath ""
            putStrLn "Campanha não criada ainda"
            main
    
    where filePath = "data/campanha.lore"


restart :: IO () -> IO ()
restart main = do
    opcao <- getLine
    if opcao == "" then main else restart main
module Main where
import System.IO
import System.Directory
import System.FilePath.Posix
import System.Process
import System.Random
import MainPersonagem
import MainItem
import MainHabilidade
import MainLoja
import Data.List
import Data.Maybe
import Util


main :: IO ()
main = do
    existsEquipavel <- doesFileExist "data/equip.info"
    existsConsmvl <- doesFileExist "data/consmvl.info"
    existsPerson <- doesFileExist "data/persngs.bd"
    existsHabil <- doesFileExist "data/habil.info"
    existsLoja <- doesFileExist "data/loja.bd"
    if (existsEquipavel && existsHabil && existsConsmvl && existsPerson && existsLoja)
        then do
            menu
        else do
            criarArquivos
            menu


menu :: IO ()
menu = do
    system "cls"
    let menu = [ ("1", lerCampanha)
            , ("2", iniciarcampanha)
            , ("3", selPersg)
            , ("4", selItem)
            , ("5", selHabil)
            , ("6", selLoja)
            , ("9", sairBunitinho)
            ]
    putStrLn           "                  ______________"
    putStrLn           "            ,===:'.,            `-._"
    putStrLn           "                 `:.`---.__         `-._"
    putStrLn           "                   `:.     `--.         `."
    putStrLn           "                     \\         `.         `."
    putStrLn           "             (,,(,    \\          `.   ____,-`.,"
    putStrLn           "          (,'     `/   \\    ,--.___`.'"
    putStrLn           "       ( ,'   ,--.  `,  \\ ;'         `"
    putStrLn           "      {,O {      \\   :   \\;"
    putStrLn           "        \\  ,,'    /  /    //"
    putStrLn           "         |;;    /  ,' ,-//.    ,---.      ,"
    putStrLn           "        \\;'   /  ,' /  _  \\   /  _  \\    ,'/"
    putStrLn           "             \\    `'  / \\   `'  / \\   `.' /"
    putStrLn           "                `.___,'   `.__,'   `.__,'  VZ "
    putStrLn           "1 - Ler Campanha,\n2 - Definir Lore da campanha,\n3 - Menu de Personagem\n4 - Menu de Item,\n5 - Menu de Habilidades\n6 - Loja,\n9 - Sair\n"
    opcao <- getLine
    let action = lookup opcao (menu)
    verificaEntradaMenu action


selPersg :: IO ()
selPersg = do
    menuPersng
    menu

selItem :: IO ()
selItem = do
    menuItem
    menu


selHabil :: IO ()
selHabil = do
    menuHabilis
    menu


selLoja :: IO ()
selLoja = do
    menuLoja
    menu

criarArquivos :: IO ()
criarArquivos = do
    createDirectoryIfMissing True $ takeDirectory "data/habil.info"
    writeFile "data/persngs.bd" ""
    writeFile "data/consmvl.info" ""
    writeFile "data/equip.info" ""
    writeFile "data/habil.info" ""
    writeFile "data/loja.bd" ""

voltaMain :: String -> IO ()
voltaMain _ = menu


lerCampanha :: IO ()
lerCampanha = do
    exists <- doesFileExist filePath
    if exists
        then do
            handle <- openFile filePath ReadMode
            contents <- hGetContents handle
            system "cls"
            print "---> "
            putStrLn $ contents
            print " <---"
            hClose handle
            restart menu
        else do
            putStrLn "Campanha não criada ainda\nNecessário iniciar uma Campanha\nEnter parar voltar ao Menu"
            restart menu
    
    where filePath = "data/campanha.lore"


iniciarcampanha :: IO ()
iniciarcampanha = do
    system "cls"

    exists <- doesFileExist filePath
    if exists
        then do
            content <- getMultipleLines
            writeFile filePath (unlines content)
            menu
        else do
            createDirectoryIfMissing True $ takeDirectory filePath
            writeFile filePath ""
            iniciarcampanha

    where filePath = "data/campanha.lore"


sairBunitinho :: IO ()
sairBunitinho = do
    putStrLn "Encerrando o programa..."
    system "cls"
    putStrLn "Programa encerrado"
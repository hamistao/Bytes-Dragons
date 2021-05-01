module Util where
import Data.Typeable
import qualified Data.ByteString as S
import Personagem
import System.IO
import System.Process
import System.FilePath.Posix
import System.Directory
import Habilidade as Habil
import Data.List
import Item

restart :: IO () -> IO ()
restart menu = do
    opcao <- getLine
    if opcao == "" then menu else restart menu


verificaEntradaMenu :: Maybe (IO ()) -> IO ()
verificaEntradaMenu Nothing = putStrLn "\nEntrada Invalida brooo, vlw flw\n\n"
verificaEntradaMenu (Just a) = a


replacePersonOnFile :: Personagem -> Personagem -> IO ()
replacePersonOnFile new old = do
    --contents <- readFile "data/persngs.bd"
    handle <- openFile "data/persngs.bd" ReadMode
    contents <- hGetContents handle

    let personagens = transformaListaPersonagem (lines(contents))
    let personagens_finais = (unlines (map show (replacePerson new old personagens)))

    (tempName, tempHandle) <- openTempFile "data/" "temp"
    hPutStr tempHandle personagens_finais
    hClose tempHandle
    hClose handle

    fechou <- hIsClosed handle
    if fechou then do
        removeFile "data/persngs.bd"
        renameFile tempName "data/persngs.bd"
    else do
        removeFile tempName
        putStrLn "Possível erro ao completar acao"


replacePerson :: Personagem -> Personagem -> [Personagem] -> [Personagem]
replacePerson new old lista = new:[p | p <- lista, p/=old]


transformaListaPersonagem :: [String] -> [Personagem]
transformaListaPersonagem [] = []
transformaListaPersonagem (x:xs) = ((read x :: Personagem)) : (transformaListaPersonagem xs)


transformaListaEquipavel :: [String] -> [Equipavel]
transformaListaEquipavel [] = []
transformaListaEquipavel (x:xs) = ((read :: String -> Equipavel) x) : (transformaListaEquipavel xs)


transformaListaConsumivel :: [String] -> [Consumivel]
transformaListaConsumivel [] = []
transformaListaConsumivel (x:xs) = (read x :: Consumivel) : (transformaListaConsumivel xs)


getArquivoExcluir :: String -> String -> IO ()
getArquivoExcluir path contents
    | path == "data/equip.info" = checkExcluirEquip (transformaListaEquipavel (lines contents))
    | path == "data/consmvl.info" = checkExcluirConsmvl (transformaListaConsumivel (lines contents))
    | otherwise = putStrLn "Erro na leitura de Arquivo\n"


checkExcluirEquip :: [Equipavel] -> IO ()
checkExcluirEquip itens = do
    putStrLn "Qual o ID do Equipavel?"
    entrada <- getLine
    let id = read entrada :: Int
    if id < (length itens) 
        then do
            (tempName, tempHandle) <- openTempFile "data/" "temp"
            let newItens = delete (itens !! id) itens
            hPutStr tempHandle $ unlines (map show newItens)
            hClose tempHandle
            removeFile "data/equip.info"
            renameFile tempName "data/equip.info"
        else putStrLn "Item Inexistente\n"


checkExcluirConsmvl :: [Consumivel] -> IO ()
checkExcluirConsmvl itens = do
    putStrLn "Qual o ID do Consumivel?"
    entrada <- getLine
    let id = read entrada :: Int
    if id < (length itens) 
        then do
            (tempName, tempHandle) <- openTempFile "data/" "temp"
            let newItens = delete (itens !! id) itens
            hPutStr tempHandle $ unlines (map show newItens)
            hClose tempHandle
            removeFile "data/consmvl.info"
            renameFile tempName "data/consmvl.info"
        else putStrLn "Item Inexistente\n"



transformaListaHabilidades :: [String] -> [Habilidade]
transformaListaHabilidades [] = []
transformaListaHabilidades (x:xs) = ((read :: String -> Habilidade) x):(transformaListaHabilidades xs)


getHabilFromString :: String -> Habilidade
getHabilFromString habilis = (read habilis :: Habilidade)


getEquipavelFromString :: String -> Equipavel
getEquipavelFromString item = (read item :: Equipavel)


getConsmvlFromString :: String -> Consumivel
getConsmvlFromString item = (read item :: Consumivel)


getPersngFromString :: String -> Personagem
getPersngFromString persng = (read persng :: Personagem)


getFromTipo :: String -> IO String
getFromTipo "1" = readFile "data/equip.info"
getFromTipo _ = readFile "data/consmvl.info"


getMultipleLines :: IO [String]
getMultipleLines = do
    x <- getLine
    if x == ""
        then return []
        else do
            xs <- getMultipleLines
            return (x:xs)


verificaEntradaMenuComplex :: Maybe ((String -> IO ())) -> (String -> IO ())
verificaEntradaMenuComplex Nothing = (\ a -> putStrLn a)
verificaEntradaMenuComplex (Just a) = a


getPersng :: [Personagem] -> String -> (Maybe (Personagem))
getPersng [] nome = Nothing
getPersng (s:xs) nome
    | nome == (nome_personagem s) = (Just s)
    | otherwise = getPersng xs nome
module MainLoja where

import System.IO
import System.Process
import System.FilePath.Posix
import System.Directory
import Data.List
import Data.Maybe
import Loja
import Personagem as Persona
import Batalha
import Item
import Util

menuLoja :: IO ()
menuLoja = do
    system "cls"
    let menuL = [ ("1", listarLojas)
                , ("2", criarLoja)
                , ("3", adicionaItemLoja)
                , ("4", detalhesLoja)
                , ("5", excluiLoja)
                , ("6", menuNegociaLoja)
                , ("9", print "")
                ]
    putStrLn           "  _______________"
    putStrLn           " /     Loja     /"
    putStrLn           "/______________/"
    putStrLn           "| |  _[___]_   |"
    putStrLn           "| |__( o_o )___|"
    putStrLn           "| /    /|\\     |"
    putStrLn           "|/_____________|"
    putStrLn           "| |            |"
    putStrLn           "|              |"
    putStrLn           "1 - Listar Lojas\n2 - Criar Loja\n3 - Adiciona um item na Loja\n4 - Detalhes de Loja\n5 - Excluir Loja\n6 - Negociar com a Loja\n9 - Voltar Menu\n"
    tipo <- getLine
    let action = lookup tipo (menuL)
    verificaEntradaMenu action

listarLojas :: IO ()
listarLojas = do
    system "cls"
    contents <- readFile "data/loja.bd"
    print "---> "
    putStrLn $ Loja.listaLojas (transformaListaLoja (lines contents))
    print " <---"
    restart menuLoja

transformaListaLoja :: [String] -> [Loja]
transformaListaLoja [] = []
transformaListaLoja (x:xs) = ((read :: String -> Loja) x):(transformaListaLoja xs)

criarLoja :: IO ()
criarLoja = do
    putStrLn "Qual o nome da Loja?"
    nome <- getLine 
    appendFile "data/loja.bd" (show (Loja.cadastraLoja nome) ++ "\n")
    putStrLn "Loja Criada"
    restart menuLoja

adicionaItemLoja :: IO ()
adicionaItemLoja = do   
    system "cls"
    putStrLn "Qual o Tipo de Item Desejado?\n1 - Equipavel\nOu\n2 - Consumivel"
    tipo <- getLine
    if (tipo /= "1" && tipo /= "2") then putStrLn "Entrada Invalida"
        else do
            putStrLn "Qual o ID do Item?"
            entrada <- getLine
            let id = read entrada :: Int
            itemStr <- getFromTipo tipo
            if (id >= (length(lines itemStr))) then putStrLn "Id Invalida" 
                else do
                    putStrLn "Qual o preco do Item?"
                    precoStr <- getLine
                    let preco = read precoStr :: Int
                    if(preco <= 0) then putStrLn "Preco Invalido"
                        else do
                            let item = (lines itemStr) !! id
                            putStrLn "Qual o nome da Loja?"
                            nome <- getLine
                            fileLoja <- readFile "data/loja.bd"
                            let lojaString = lines fileLoja
                            let loja = getLoja (transformaListaLoja lojaString) nome
                            if (isNothing loja)
                                then do
                                    putStrLn "Loja Inexistente"
                                else do
                                    putStr "Item adicionado com sucesso"
                                    if (tipo == "1") then (adicionarEquipLoja (fromJust loja) (getEquipavelFromString item) preco)
                                        else (adicionarConsmvlLoja (fromJust loja) (getConsmvlFromString item) preco)
    restart menuLoja

getLoja :: [Loja] -> String -> (Maybe (Loja))
getLoja [] nome = Nothing
getLoja (s:xs) nome
    | nome == (nomeLoja s) = (Just s)
    | otherwise = getLoja xs nome

adicionarEquipLoja :: Loja -> Equipavel -> Int -> IO ()
adicionarEquipLoja loja item preco = do
    let new_loja = Loja.adicionaEquipavel item loja preco
    replaceLojaOnFile new_loja loja


adicionarConsmvlLoja :: Loja -> Consumivel -> Int -> IO ()
adicionarConsmvlLoja loja item preco = do
    let new_loja = Loja.adicionarConsmivel item loja preco
    replaceLojaOnFile new_loja loja

replaceLojaOnFile :: Loja -> Loja -> IO ()
replaceLojaOnFile new old = do
    --contents <- readFile "data/loja.bd"
    handle <- openFile "data/loja.bd" ReadMode
    contents <- hGetContents handle

    let lojas = transformaListaLoja (lines contents)
    let lojas_finais = (unlines (map show (replaceLoja new old lojas)))

    (tempName, tempHandle) <- openTempFile "data/" "temp"
    hPutStr tempHandle lojas_finais
    hClose tempHandle
    hClose handle


    removeFile "data/loja.bd"
    renameFile tempName "data/loja.bd"

replaceLoja :: Loja -> Loja -> [Loja] -> [Loja]
replaceLoja new old [] = []
replaceLoja new old (x:xs)
    | old == x = (new:xs)
    | otherwise = x:(replaceLoja new old xs)

detalhesLoja :: IO ()
detalhesLoja = do
    system "cls"
    putStrLn "Qual o Nome da Loja?"
    nome <- getLine
    contents <- readFile "data/loja.bd"
    putStrLn (getDetalhesLoja (lines contents) nome)
    restart menuLoja

excluiLoja :: IO ()
excluiLoja = do
    system "cls"
    putStrLn "Qual o Nome da Loja?"
    nome <- getLine
    contents <- readFile "data/loja.bd"
    let loja_possi = getDetalhesLoja (lines contents) nome
    if (loja_possi == "Loja inexistente\n") then (putStrLn loja_possi)
    else do
        (deleteLoja (lines contents) (getLoja (transformaListaLoja (lines contents)) nome))
    restart menuLoja
            
getDetalhesLoja :: [String] -> String -> String
getDetalhesLoja lojas nome = 
    (Loja.exibeLoja (transformaListaLoja lojas) nome)

deleteLoja ::  [String] -> (Maybe (Loja)) -> IO ()
deleteLoja listaLoja lojaMayb = do
    if (not (isNothing lojaMayb))
        then do
            let loja = fromJust (lojaMayb)
            (tempName, tempHandle) <- openTempFile "data/" "temp"
            hPutStr tempHandle $ unlines ((listaLoja \\ [(show(loja))]))
            hClose tempHandle
            removeFile "data/loja.bd"
            renameFile tempName "data/loja.bd"
            putStrLn "Loja excluida com Sucesso\n"
        else putStrLn "Loja inexistente\n"

menuNegociaLoja :: IO ()
menuNegociaLoja = do
    system "cls"
    let menuNL = [ 
            ("1", comprarItem),
            ("2", venderItem)
            , ("9", menuLoja)
            ]
    putStrLn "1 - Comprar um Item\n2 - Vender um Item\n9 - Voltar Menu\n"
    tipo <- getLine
    let action = lookup tipo (menuNL)
    verificaEntradaMenu action

comprarItem :: IO ()
comprarItem = do
    system "cls"
    putStrLn "Qual o nome da Loja?"
    nome <- getLine
    fileLoja <- readFile "data/loja.bd"
    let lojaString = lines fileLoja
    let loja = getLoja (transformaListaLoja lojaString) nome
    if (isNothing loja)
        then do
            putStrLn "Loja Inexistente"
        else do
            putStrLn "Qual o Tipo de Item Desejado?\n1 - Equipavel\nOu\n2 - Consumivel"
            tipo <- getLine
            if (tipo /= "1" && tipo /= "2") then putStrLn "Entrada Invalida"
                else do
                    putStrLn "Qual o ID do Item?"
                    entrada <- getLine
                    let id = read entrada :: Int
                    itemStr <- getFromTipo tipo
                    if (id >= (length(lines itemStr))) then putStrLn "Id Invalida"
                        else do
                            let item = (lines itemStr) !! id
                            if (tipo == "1" && isNothing(Loja.getPrecoEquipavel (lojaEquipaveis (fromJust loja)) (getEquipavelFromString item))) then putStrLn "Esse Item não existe nessa loja"
                            else if(tipo == "2" && isNothing(Loja.getPrecoConsumivel (lojaConsumiveis (fromJust loja)) (getConsmvlFromString item))) then putStrLn "Esse Item não existe nessa loja"
                            else do
                                putStrLn "Qual o nome do Personagem?"
                                nome <- getLine
                                filePerson <- readFile "data/persngs.bd"
                                let persngsString = lines filePerson
                                let person = getPersng (transformaListaPersonagem persngsString) nome
                                if (isNothing person) then putStrLn "Personagem Inexistente"
                                    else do
                                        if (tipo == "1") then (comprarEquipavel (fromJust person) (getEquipavelFromString item) (fromJust (Loja.getPrecoEquipavel (lojaEquipaveis (fromJust loja)) (getEquipavelFromString item))) (fromJust loja))
                                            else (comprarConsumivel (fromJust person) (getConsmvlFromString item) (fromJust (Loja.getPrecoConsumivel (lojaConsumiveis (fromJust loja)) (getConsmvlFromString item))) (fromJust loja))
    restart menuNegociaLoja


comprarEquipavel :: Personagem -> Equipavel -> Int -> Loja -> IO ()
comprarEquipavel persng item preco loja
    | (ouro persng < (fromJust (Loja.getPrecoEquipavel (lojaEquipaveis loja) item))) = putStrLn "Dinheiro insuficiente" 
    | otherwise = do
        let new_data = Loja.compraEquipavel persng item preco loja
        replacePersonOnFile (fst(new_data)) persng
        replaceLojaOnFile (snd(new_data)) loja
        putStrLn "Item comprado com sucesso"

comprarConsumivel :: Personagem -> Consumivel -> Int -> Loja -> IO ()
comprarConsumivel persng item preco loja
    | (ouro persng < (fromJust (Loja.getPrecoConsumivel (lojaConsumiveis loja) item))) = putStrLn "Dinheiro insuficiente"
    | otherwise = do
        let new_data = Loja.compraConsumivel persng item preco loja
        replacePersonOnFile (fst(new_data)) persng
        replaceLojaOnFile (snd(new_data)) loja
        putStr "Item comprado com sucesso"

venderItem :: IO ()
venderItem = do
    system "cls"
    putStrLn "Qual o Tipo de Item Desejado?\n1 - Equipavel\nOu\n2 - Consumivel"
    tipo <- getLine
    if (tipo /= "1" && tipo /= "2") then putStrLn "Entrada Invalida"
        else do
            putStrLn "Qual o ID do Item?"
            entrada <- getLine
            let id = read entrada :: Int
            itemStr <- getFromTipo tipo
            if (id >= (length(lines itemStr))) then putStrLn "Id Invalida"
                else do
                    putStrLn "Qual o preco do Item?"
                    precoStr <- getLine
                    let preco = read precoStr :: Int
                    if(preco <= 0) then putStrLn "Preco Invalido"
                        else do
                            let item = (lines itemStr) !! id
                            putStrLn "Qual o nome do Personagem?"
                            nome <- getLine
                            filePerson <- readFile "data/persngs.bd"
                            let persngsString = lines filePerson
                            let person = getPersng (transformaListaPersonagem persngsString) nome
                            if (isNothing person) then putStrLn "Personagem Inexistente"
                                else do
                                    putStrLn "Item vendido com sucesso"
                                    if (tipo == "1") then (venderEquip (fromJust person) (getEquipavelFromString item) preco)
                                        else (venderConsmvl (fromJust person) (getConsmvlFromString item) preco)
    restart menuNegociaLoja


venderEquip :: Personagem -> Equipavel -> Int -> IO ()
venderEquip persng item preco = do
    let new_person = Loja.vendeEquipavel persng item preco
    replacePersonOnFile new_person persng


venderConsmvl :: Personagem -> Consumivel -> Int -> IO ()
venderConsmvl persng item preco = do
    let new_person = Loja.vendeConsumivel persng item preco
    replacePersonOnFile new_person persng


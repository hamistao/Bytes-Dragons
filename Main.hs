module Main where
import System.IO
import System.Directory
import System.FilePath.Posix
import System.Process
import Item as Item
import Data.List

main :: IO ()
main = do
    system "clear"
    putStrLn "1 - Ler Campanha,\n2 - Definir Lore da campanha,\n3 - Menu de Personagem\n4 - Menu de Item,\n5 - Menu de NPC,\n9 - Sair\n"
    opcao <- getLine
    let action = lookup opcao (menus "main")
    verificaEntradaMenu action


verificaEntradaMenu :: Maybe (IO ()) -> IO ()
verificaEntradaMenu Nothing = putStrLn "\nEntrada Invalida brooo, vlw flw\n\n"
verificaEntradaMenu (Just a) = a


menus:: String -> [(String, IO ())]
menus "main" = 
        [ ("1", lerCampanha)
        , ("2", iniciarcampanha)
        , ("3", sairBunitinho)
        , ("4", menuItem)
        , ("5", menuNpc)
        , ("9", sairBunitinho)
        ]
menus "npc" =
        [ ("1", sairBunitinho)
        , ("2", sairBunitinho)
        , ("3", sairBunitinho)
        , ("4", sairBunitinho)
        , ("9", sairBunitinho)
        ]
menus "item" =
        [ ("1", menuEquip)
        , ("2", menuConsumvl)
        ]
menus x = []


menusItens :: [(String, (String -> IO ()))]
menusItens =
        [ ("1", listarItensNomes)
        , ("2", cadastrarItem)
        , ("4", detalheItem)
        , ("9", voltaMain)
        ]

verificaEntradaMenuComplex :: Maybe ((String -> IO ())) -> (String -> IO ())
verificaEntradaMenuComplex Nothing = (\ a -> putStrLn a)
verificaEntradaMenuComplex (Just a) = a


voltaMain :: String -> IO ()
voltaMain _ = main


lerCampanha :: IO ()
lerCampanha = do
    exists <- doesFileExist filePath
    if exists
        then do
            handle <- openFile filePath ReadMode
            contents <- hGetContents handle
            system "clear"
            print "---> "
            putStrLn $ contents
            print " <---"
            restart main
        else do
            putStrLn "Campanha não criada ainda\nNecessário iniciar uma Campanha\nEnter parar voltar ao Menu"
            restart main
    
    where filePath = "data/campanha.lore"


restart :: IO () -> IO ()
restart main = do
    opcao <- getLine
    if opcao == "" then main else restart main


iniciarcampanha :: IO ()
iniciarcampanha = do
    system "clear"

    exists <- doesFileExist filePath
    if exists
        then do
            content <- getMultipleLines
            writeFile filePath (unlines content)
            restart main
        else do
            createDirectoryIfMissing True $ takeDirectory filePath
            writeFile filePath ""
            iniciarcampanha

    where filePath = "data/campanha.lore"


getMultipleLines :: IO [String]
getMultipleLines = do
    x <- getLine
    if x == ""
        then return []
        else do
            xs <- getMultipleLines
            return (x:xs)


sairBunitinho :: IO ()
sairBunitinho = do
    putStrLn "Encerrando o programa..."
    system "clear"
    putStrLn "Programa encerrado"


menuNpc :: IO ()
menuNpc = do
    system "clear"
    putStrLn "1 - Listar NPCs,\n2 - Cadastrar NPC,\n3 - Excluir NPC\n4 - Detalhes NPC,\n9 - Retorna Menu\n"
    opcao <- getLine
    let action = lookup opcao (menus "npc")
    verificaEntradaMenu action


menuItem :: IO ()
menuItem = do
    system "clear"
    putStrLn "1 - Item Equipavel\nOu\n2 - Item Consumível"
    tipo <- getLine
    let action = lookup tipo (menus "item")
    verificaEntradaMenu action


menuEquip :: IO ()
menuEquip = do
    system "clear"
    putStrLn "1 - Listar Itens,\n2 - Cadastrar Item,\n3 - Excluir Item\n4 - Detalhes de Item,\n9 - Retorna Menu\n"
    opcao <- getLine
    let action = lookup opcao (menusItens)
    (verificaEntradaMenuComplex action) ("data/equip.info" )


menuConsumvl :: IO ()
menuConsumvl = do
    system "clear"
    putStrLn "1 - Listar Itens,\n2 - Cadastrar Item,\n3 - Excluir Item\n4 - Detalhes de Item,\n9 - Retorna Menu\n"
    opcao <- getLine
    let action = lookup opcao (menusItens)
    (verificaEntradaMenuComplex action) "data/consmvl.info" 


detalheItem :: String -> IO ()
detalheItem tipo = do
    system "clear"
    existsEquip <- doesFileExist "data/equip.info"
    existsConsmvl <- doesFileExist "data/consmvl.info"
    if existsEquip && existsConsmvl
        then do
            handle <- openFile tipo ReadMode
            contents <- hGetContents handle
            getDetalheItem tipo contents
            restart menuItem
        else do
            createDirectoryIfMissing True $ takeDirectory tipo
            writeFile "data/equip.info" ""
            writeFile "data/consmvl.info" ""
            detalheItem tipo


getDetalheItem :: String -> String -> IO ()
getDetalheItem path contents
    | path == "data/equip.info" = checkSingleEquip (transformaListaEquipavel (lines contents))
    | path == "data/consmvl.info" = checkSingleConsmvl (transformaListaConsumivel (lines contents))
    | otherwise = putStrLn "Erro na leitura de Arquivo\n"


checkSingleEquip :: [Equipavel] -> IO ()
checkSingleEquip itens = do
    putStrLn "Qual o Nome do Equipavel?"
    nome <- getLine
    let nomes = map (Item.nome_equipavel) itens
    if nome `elem` (nomes)
        then do
            mapM_ putStrLn (map Item.listarEquipavel (map (\ a -> itens !! a) (nome `elemIndices` nomes)))
        else putStrLn "Item Inexistente\n"


checkSingleConsmvl :: [Consumivel] -> IO ()
checkSingleConsmvl itens = do
    putStrLn "Qual o Nome do Equipavel?"
    nome <- getLine
    let nomes = map (Item.nomeConsumivel) itens
    if nome `elem` (nomes)
        then do
            mapM_ putStrLn (map Item.listarConsumivel (map (\ a -> itens !! a) (nome `elemIndices` nomes)))
        else putStrLn "Item Inexistente\n"


listarItensNomes :: String -> IO ()
listarItensNomes tipo = do
    system "clear"
    existsEquip <- doesFileExist "data/equip.info"
    existsConsmvl <- doesFileExist "data/consmvl.info"
    if existsEquip && existsConsmvl
        then do
            handle <- openFile tipo ReadMode
            contents <- hGetContents handle
            print "---> "
            putStrLn $ getItens tipo contents
            print " <---"
            restart menuItem
        else do
            createDirectoryIfMissing True $ takeDirectory tipo
            writeFile "data/equip.info" ""
            writeFile "data/consmvl.info" ""
            listarItensNomes tipo


cadastrarItem :: String -> IO ()
cadastrarItem tipo = do
    existsEquip <- doesFileExist "data/equip.info"
    existsConsmvl <- doesFileExist "data/consmvl.info"
    if existsEquip && existsConsmvl
        then do
            criarItemTipo tipo
            putStrLn "Item Criado"
        else do
            createDirectoryIfMissing True $ takeDirectory tipo
            writeFile "data/equip.info" ""
            writeFile "data/consmvl.info" ""
            cadastrarItem tipo


criarItemTipo :: String -> IO ()
criarItemTipo tipo
    | tipo == "data/equip.info" = criarItemEquipavel tipo
    | tipo == "data/consmvl.info" = criarItemConsmvl tipo
    | otherwise = putStrLn "Erro na Abertura de arquivo\n"


criarItemEquipavel :: String -> IO ()
criarItemEquipavel path = do
    putStrLn "Qual o nome do Equipavel?"
    nome <- getLine
    putStrLn "Qual a Alteração de Resistência?"
    resistnc <- getLine
    putStrLn "Qual a Alteração de Velocidade?"
    velocd <- getLine
    putStrLn "Onde sera Equipavel (Torso, Cabeca, Pernas, Maos)"
    tipo <- getLine
    appendFile path (show (Item.criarEquipavel nome (read resistnc) (read velocd) (read tipo :: Item.TipoEquipavel)) ++ "\n")
    restart menuEquip


criarItemConsmvl :: String -> IO ()
criarItemConsmvl path = do
    putStrLn "Qual o nome do Consumivel?"
    nome <- getLine
    putStrLn "Qual a Alteração de Vida?"
    vida <- getLine
    putStrLn "Qual a Alteração de Resistência?"
    resistnc <- getLine
    putStrLn "Qual a Alteração de Dano?"
    dano <- getLine
    putStrLn "Qual a Durabilidade?"
    durac <- getLine
    appendFile path (show (Item.criarConsumivel nome (read vida) (read resistnc) (read dano) (read durac)) ++ "\n")
    restart menuConsumvl


getItens :: String -> String -> String
getItens tipo contents
    | tipo == "data/equip.info" = Item.listarEquipaveis (transformaListaEquipavel (lines contents))
    | tipo == "data/consmvl.info" = Item.listarConsumiveis (transformaListaConsumivel (lines contents))
    | otherwise = "Erro na leitura de Arquivo\n"


transformaListaEquipavel :: [String] -> [Equipavel]
transformaListaEquipavel [] = []
transformaListaEquipavel (x:xs) = ((read :: String -> Equipavel) x) : (transformaListaEquipavel xs)


transformaListaConsumivel :: [String] -> [Consumivel]
transformaListaConsumivel [] = []
transformaListaConsumivel (x:xs) = (read x :: Consumivel) : (transformaListaConsumivel xs)


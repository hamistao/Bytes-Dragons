module MainItem where
import System.IO
import System.Process
import System.FilePath.Posix
import System.Directory
import Util
import Item

menuItem :: IO ()
menuItem = do
    system "clear"
    let menuI =[ ("1", menuEquip)
            , ("2", menuConsumvl)
            ]
    putStrLn "1 - Item Equipavel\nOu\n2 - Item Consumível\n"
    tipo <- getLine
    let action = lookup tipo (menuI)
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
    contents <- readFile tipo
    getDetalheItem tipo contents
    restart menuItem


getDetalheItem :: String -> String -> IO ()
getDetalheItem path contents
    | path == "data/equip.info" = checkListaEquip (transformaListaEquipavel (lines contents))
    | path == "data/consmvl.info" = checkListaConsmvl (transformaListaConsumivel (lines contents))
    | otherwise = putStrLn "Erro na leitura de Arquivo\n"


checkListaEquip :: [Equipavel] -> IO ()
checkListaEquip itens = do
    putStrLn "Qual o ID do Equipavel?"
    entrada <- getLine
    let id = read entrada :: Int
    if id < (length itens) then putStrLn (Item.exibirEquipavel( itens !! id))
        else putStrLn "ID inválido"


checkListaConsmvl :: [Consumivel] -> IO ()
checkListaConsmvl itens = do
    putStrLn "Qual o ID do Consumivel?"
    entrada <- getLine
    let id = read entrada :: Int
    if id < (length itens) then putStrLn (Item.exibirConsumivel (itens !! id))
        else putStrLn "ID inválido\n"


listarItensNomes :: String -> IO ()
listarItensNomes tipo = do
    system "clear"
    contents <- readFile tipo
    print "---> "
    putStrLn $ unlines (zipWith (\num item -> "Item - " ++ show num ++ "  ---------->\n" ++ item) [0..] ((getItens tipo contents)))
    print " <---"
    restart menuItem


cadastrarItem :: String -> IO ()
cadastrarItem tipo
    | tipo == "data/equip.info" = criarItemEquipavel tipo
    | tipo == "data/consmvl.info" = criarItemConsmvl tipo
    | otherwise = putStrLn "Erro na Abertura de arquivo\n"


criarItemEquipavel :: String -> IO ()
criarItemEquipavel path = do
    putStrLn "Qual o nome do Equipável?"
    nome <- getLine
    putStrLn "Qual a Alteração de Vida Máxima?"
    vida_maxima <- getLine
    putStrLn "Qual a Alteração de Força?"
    forca <- getLine
    putStrLn "Qual a Alteração de Inteligência?"
    inteligencia <- getLine
    putStrLn "Qual a Alteração de Sabedoria?"
    sabedoria <- getLine
    putStrLn "Qual a Alteração de Destreza?"
    destreza <- getLine
    putStrLn "Qual a Alteração de Constituição?"
    constituicao <- getLine
    putStrLn "Qual a Alteração de Carisma?"
    carisma <- getLine
    putStrLn "Qual a Alteração de Velocidade?"
    velocd <- getLine
    putStrLn "Onde será Equipável (Cabeca | Torso | Pernas | Maos | Arma) ?"
    tipo <- getLine
    appendFile path (show (Item.criaEquipavel nome (read vida_maxima) (read forca) (read inteligencia) (read sabedoria) (read destreza) (read constituicao) (read carisma) (read velocd) (read tipo :: Item.TipoEquipavel)) ++ "\n")
    putStrLn "Item Criado"
    restart menuEquip


criarItemConsmvl :: String -> IO ()
criarItemConsmvl path = do
    putStrLn "Qual o nome do Consumivel?"
    nome <- getLine
    putStrLn "Qual a Alteração de Vida?"
    vida <- getLine
    putStrLn "Qual a Alteração de Velocidade?"
    velocidade <- getLine
    putStrLn "Qual a Durabilidade?"
    durac <- getLine
    appendFile path (show (Item.criaConsumivel nome (read vida) (read velocidade) (read durac)) ++ "\n")
    putStrLn "Item Criado"
    restart menuConsumvl


getItens :: String -> String -> [String]
getItens tipo contents
    | tipo == "data/equip.info" = Item.listarEquipaveis (transformaListaEquipavel (lines contents))
    | tipo == "data/consmvl.info" = Item.listarConsumiveis (transformaListaConsumivel (lines contents))
    | otherwise = ["Erro na leitura de Arquivo\n"]


menusItens :: [(String, (String -> IO ()))]
menusItens =
        [ ("1", listarItensNomes)
        , ("2", cadastrarItem)
        , ("3", excluiItem)
        , ("4", detalheItem)
        , ("9", putStr)
        ]


excluiItem :: String -> IO ()
excluiItem tipo = do
    system "clear"
    contents <- readFile tipo
    getArquivoExcluir tipo contents
    putStrLn "Item Excluido"
    restart menuItem
module Main where
import System.IO
import System.Directory
import System.FilePath.Posix
import System.Process
import Item as Item
import Personagem as Persona
import Habilidade as Habil
import Raca
import Classe
import Data.List
import Data.Maybe

main :: IO ()
main = do
    existsEquipavel <- doesFileExist "data/equip.info"
    existsConsmvl <- doesFileExist "data/consmvl.info"
    existsPerson <- doesFileExist "data/persngs.bd"
    existsHabil <- doesFileExist "data/habil.info"
    if (not (existsEquipavel && existsHabil && existsConsmvl && existsPerson)) then criarArquivos
        else do
            system "clear"
            putStrLn "1 - Ler Campanha,\n2 - Definir Lore da campanha,\n3 - Menu de Personagem\n4 - Menu de Item,\n5 - Menu de Habilidades\n9 - Sair\n"
            opcao <- getLine
            let action = lookup opcao (menus "main")
            verificaEntradaMenu action


criarArquivos :: IO ()
criarArquivos = do
    createDirectoryIfMissing True $ takeDirectory "data/habil.info"
    writeFile "data/persngs.bd" ""
    writeFile "data/consmvl.info" ""
    writeFile "data/equip.info" ""
    writeFile "data/habil.info" ""


verificaEntradaMenu :: Maybe (IO ()) -> IO ()
verificaEntradaMenu Nothing = putStrLn "\nEntrada Invalida brooo, vlw flw\n\n"
verificaEntradaMenu (Just a) = a


menus :: String -> [(String, IO ())]
menus "main" = 
        [ ("1", lerCampanha)
        , ("2", iniciarcampanha)
        , ("3", menuPersng)
        , ("4", menuItem)
        , ("5", menuHabilis)
        , ("9", sairBunitinho)
        ]
menus "item" =
        [ ("1", menuEquip)
        , ("2", menuConsumvl)
        ]
menus "persona" =
        [ ("1", listarPersng)
        , ("2", criarPersng)
        , ("3", detalhesPersng)
        , ("4", excluirPersng)
        , ("9", main)
        ]
menus "habil" = 
        [ ("1", listarHabil)
        , ("2", criarHabil)
        , ("3", detalhesHabil)
        , ("4", excluirHabil)
        , ("9", main)
        ]
menus x = []

menusItens :: [(String, (String -> IO ()))]
menusItens =
        [ ("1", listarItensNomes)
        , ("2", cadastrarItem)
        , ("3", excluiItem)
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
            hClose handle
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


menuItem :: IO ()
menuItem = do
    system "clear"
    putStrLn "1 - Item Equipavel\nOu\n2 - Item Consumível\n"
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
    putStrLn "Qual a Alteração de Dano?"
    dano <- getLine
    putStrLn "Qual a Alteração de Velocidade?"
    velocidade <- getLine
    putStrLn "Qual a Durabilidade?"
    durac <- getLine
    appendFile path (show (Item.criaConsumivel nome (read vida) (read dano) (read velocidade) (read durac)) ++ "\n")
    putStrLn "Item Criado"
    restart menuConsumvl


getItens :: String -> String -> [String]
getItens tipo contents
    | tipo == "data/equip.info" = Item.listarEquipaveis (transformaListaEquipavel (lines contents))
    | tipo == "data/consmvl.info" = Item.listarConsumiveis (transformaListaConsumivel (lines contents))
    | otherwise = ["Erro na leitura de Arquivo\n"]


transformaListaEquipavel :: [String] -> [Equipavel]
transformaListaEquipavel [] = []
transformaListaEquipavel (x:xs) = ((read :: String -> Equipavel) x) : (transformaListaEquipavel xs)


transformaListaConsumivel :: [String] -> [Consumivel]
transformaListaConsumivel [] = []
transformaListaConsumivel (x:xs) = (read x :: Consumivel) : (transformaListaConsumivel xs)


excluiItem :: String -> IO ()
excluiItem tipo = do
    system "clear"
    contents <- readFile tipo
    getArquivoExcluir tipo contents
    restart menuItem


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


listarPersng :: IO ()
listarPersng = do
    system "clear"
    contents <- readFile "data/persngs.bd"
    print "---> "
    putStrLn $ Persona.listarPersonagens (transformaListaPersonagem (lines contents))
    print " <---"
    restart menuPersng


detalhesPersng :: IO ()
detalhesPersng = do
    system "clear"
    putStrLn "Qual o Nome do Personagem?"
    nome <- getLine
    contents <- readFile "data/persngs.bd"
    putStrLn (getDetalhesPersng (lines contents) nome)
    restart menuPersng
            
getDetalhesPersng :: [String] -> String -> String
getDetalhesPersng personas nome = 
    (Persona.exibePersonagem (transformaListaPersonagem personas) nome)


transformaListaPersonagem :: [String] -> [Personagem]
transformaListaPersonagem [] = []
transformaListaPersonagem (x:xs) = ((read :: String -> Personagem) x) : (transformaListaPersonagem xs)


criarPersng :: IO ()
criarPersng = do
    putStrLn "Qual o nome do Personagem?"
    nome <- getLine
    putStrLn "Qual a Raça do Personagem (Hobbit | Anao | Elfo | Gnomo | Humano | Ogro) ?"
    raca <- getLine
    putStrLn "Qual a classe do Personagem (Bruxo | Barbaro | Bardo | Clerigo | Druida | Feiticeiro | Guerreiro | Ladino | Mago | Monge | Paladino | Arqueiro) ?"
    classe <- getLine  
    appendFile "data/persngs.bd" (show (Persona.cadastraPersonagem nome (read classe :: Classe) (read raca :: Raca)) ++ "\n")
    putStrLn "Personagem Criado"
    restart menuPersng


excluirPersng :: IO ()
excluirPersng = do
    system "clear"
    putStrLn "Qual o Nome do Personagem?"
    nome <- getLine
    contents <- readFile "data/persngs.bd"
    let persng_possi = getDetalhesPersng (lines contents) nome
    if (persng_possi == "Personagem inexistente\n") then (putStrLn persng_possi) else (deletePersng (lines contents) (getPersng (transformaListaPersonagem (lines contents)) nome))
    restart menuPersng



getPersng :: [Personagem] -> String -> (Maybe (Personagem))
getPersng [] nome = Nothing
getPersng (s:xs) nome
    | nome == (nome_personagem s) = (Just s)
    | otherwise = getPersng xs nome


deletePersng ::  [String] -> (Maybe (Personagem)) -> IO ()
deletePersng listaPersng persngMayb = do
    if (not (isNothing persngMayb))
        then do
            let persng = fromJust (persngMayb)
            (tempName, tempHandle) <- openTempFile "data/" "temp"
            hPutStr tempHandle $ unlines ((listaPersng \\ [(show persng)]))
            hClose tempHandle
            removeFile "data/persngs.bd"
            renameFile tempName "data/persngs.bd"
            putStrLn "Personagem excluido com Sucesso\n"
        else putStrLn "Personagem inexistente\n"


menuHabilis :: IO ()
menuHabilis = do
    system "clear"
    putStrLn "1 - Listar Habilidades\n2 - Criar Habilidade\n3 - Detalhes de Habilidade\n4 - Excluir Habilidade\n9 - Voltar Menu\n"
    opcao <- getLine
    let action = lookup opcao (menus "habil")
    verificaEntradaMenu action


criarHabil :: IO ()
criarHabil = do
    putStrLn "Qual o nome da Habilidade?"
    nome <- getLine
    putStrLn "Qual o Buff/Debuff na Vida?"
    vida <- getLine
    putStrLn "Qual o Buff/Debuff no Dano?"
    dano <- getLine
    putStrLn "Qual o Buff/Debuff na Velocidade?"
    velocidade <- getLine
    putStrLn "Qual o Atributo da Habilidade (Forca | Inteligencia | Sabedoria | Destreza | Constituicao | Carisma) ?"
    attr <- getLine
    putStrLn "Quantos Pontos Necessários para Acerto?"
    acerto <- getLine
    putStrLn "Qual o Tipo do Dano (Cortante | Magico | Venenoso | Fogo | Gelo | Fisico) ?"
    tipo <- getLine
    appendFile "data/habil.info" (show (Persona.cadastraHabilidade nome (read vida) (read dano) (read velocidade) (read attr :: Habil.Atributo) (read acerto) (read tipo :: TipoDano)) ++ "\n")
    putStrLn "Habilidade Criada"
    restart menuHabilis


listarHabil :: IO ()
listarHabil = do
    system "clear"
    contents <- readFile filePath
    print "---> "
    printHabilidades (listarHabilidades (transformaListaHabilidades (lines contents)))
    print " <---"
    restart menuHabilis

    where filePath = "data/habil.info"


printHabilidades :: [String] -> IO ()
printHabilidades habilidades = do
    putStrLn $ unlines (zipWith (\num item -> "Habilidade - " ++ show num ++ "  ---------->\n" ++ item) [0..] (habilidades))


detalhesHabil :: IO ()
detalhesHabil = do
    system "clear"
    putStrLn "Qual o ID da Habilidade?"
    entrada <- getLine
    contents <- readFile filePath
    let habilidades = lines contents
    let id = read entrada :: Int
    if id < (length habilidades) then do
        getDetalhesHabil (habilidades !! id)
        restart menuHabilis
        else do
            putStrLn "Habilidade Inexistente\n"
    where
        filePath = "data/habil.info"

getDetalhesHabil :: String -> IO ()
getDetalhesHabil habili = do
    putStrLn $ listarHabilidade (read habili :: Habilidade)


excluirHabil :: IO ()
excluirHabil = do
    let filePath = "data/habil.info"
    habilis_io <- readFile filePath
    let habilidades = lines (habilis_io)
    putStrLn "Qual o ID da Habilidade?"
    entrada <- getLine
    let id = read entrada :: Int
    if id < (length habilidades) 
        then do
            (tempName, tempHandle) <- openTempFile "data/" "temp"
            let newHabilis = delete (habilidades !! id) habilidades
            hPutStr tempHandle $ unlines (map show newHabilis)
            hClose tempHandle
            removeFile filePath
            renameFile tempName filePath
            menuHabilis
        else putStrLn "Habilidade Inexistente\n"


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


menuPersng :: IO ()
menuPersng = do
    system "clear"
    putStrLn "1 - Listar Personagens\n2 - Criar Personagem\n3 - Detalhes de Personagem\n4 - Excluir Personagem\n5 - Equipar Item a Personagem\n6 - Alocar Habilidade a Personagem\n8 - Inicar Conflito entre Personagens\n9 - Voltar Menu\n"
    tipo <- getLine
    let action = lookup tipo (menus "persona")
    verificaEntradaMenu action



linkarItemPersng :: IO ()
linkarItemPersng = do   
    system "clear"
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
                    putStrLn "Qual o nome do Personagem?"
                    nome <- getLine
                    filePerson <- readFile "data/persngs.bd"
                    let persngsString = lines filePerson
                    let person = getPersng (transformaListaPersonagem persngsString) nome
                    if (isNothing person) then putStrLn "Personagem Inexistente"
                        else do
                            if (tipo == "1") then (linkarEquipPerson (fromJust person) (getEquipavelFromString item))
                                else (linkarConsmvlPerson (fromJust person) (getConsmvlFromString item))


getFromTipo :: String -> IO String
getFromTipo "1" = readFile "data/equip.info"
getFromTipo _ = readFile "data/consmvl.info"



linkarEquipPerson :: Personagem -> Equipavel -> IO ()
linkarEquipPerson persng item = do
    let new_person = Persona.equiparItem item persng
    replacePersonOnFile new_person persng

linkarConsmvlPerson :: Personagem -> Consumivel -> IO ()
linkarConsmvlPerson persng item = do
    let new_person = Persona.guardarConsumivel item persng
    replacePersonOnFile new_person persng

replacePerson :: Personagem -> Personagem -> [Personagem] -> [Personagem]
replacePerson new old [] =  []
replacePerson new old (x:xs)
    | old == x = (new:xs)
    | otherwise = x:(replacePerson new old xs)


replacePersonOnFile :: Personagem -> Personagem -> IO ()
replacePersonOnFile new old = do
    contents <- readFile "data/persngs.bd"
    let personagens = transformaListaPersonagem (lines contents)
    writeFile "data/persngs.bd" (unlines (map show (replacePerson new old personagens)))
module Main where
import System.IO
import System.Directory
import System.FilePath.Posix
import System.Process
import System.Random
import Item as Item
import Personagem as Persona
import Habilidade as Habil
import Loja as Loja
import Batalha
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
    if (existsEquipavel && existsHabil && existsConsmvl && existsPerson)
        then do
            menu
        else do
            criarArquivos
            menu


menu :: IO ()
menu = do
    system "clear"
    putStrLn "1 - Ler Campanha,\n2 - Definir Lore da campanha,\n3 - Menu de Personagem\n4 - Menu de Item,\n5 - Menu de Habilidades\n6 - Loja,\n9 - Sair\n"
    opcao <- getLine
    let action = lookup opcao (menus "menu")
    verificaEntradaMenu action


criarArquivos :: IO ()
criarArquivos = do
    createDirectoryIfMissing True $ takeDirectory "data/habil.info"
    writeFile "data/persngs.bd" ""
    writeFile "data/consmvl.info" ""
    writeFile "data/equip.info" ""
    writeFile "data/habil.info" ""
    writeFile "data/loja.bd" ""


verificaEntradaMenu :: Maybe (IO ()) -> IO ()
verificaEntradaMenu Nothing = putStrLn "\nEntrada Invalida brooo, vlw flw\n\n"
verificaEntradaMenu (Just a) = a


menus :: String -> [(String, IO ())]
menus "menu" = 
        [ ("1", lerCampanha)
        , ("2", iniciarcampanha)
        , ("3", menuPersng)
        , ("4", menuItem)
        , ("5", menuHabilis)
        , ("6", menuLoja)
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
        , ("5", menuItemHabil)
        , ("6", menuOuro)
        , ("7", botaResistencia)
        , ("9", menuBatalhaInicial)
        , ("0", menu)
        ]
menus "itemHabilPerson" = 
        [ ("1", linkarItemPersng)
        , ("2", linkarHabil)
        , ("3", desequiparItemPerson)
        , ("4", desalocarHabil)
        , ("9", menuPersng)
        ]
menus "habil" = 
        [ ("1", listarHabil)
        , ("2", criarHabil)
        , ("3", detalhesHabil)
        , ("4", excluirHabil)
        , ("5", encantaItem)
        , ("9", menu)
        ]
menus "loja" =
        [ ("1", listarLoja)
        , ("2", criarLoja)
        , ("3", adicionaItemLoja)
        , ("4", adicionaItemLoja)
        , ("5", detalhesLoja)
        , ("6", excluiLoja)
        , ("7", menuNegociaLoja)
        , ("9", menu)
        ]
menu "negociaLoja" =
        [ ("1", comprarItem)
        , ("2", venderItem)
        , ("9", menuLoja)
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
voltaMain _ = menu


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
            restart menu
        else do
            putStrLn "Campanha não criada ainda\nNecessário iniciar uma Campanha\nEnter parar voltar ao Menu"
            restart menu
    
    where filePath = "data/campanha.lore"


restart :: IO () -> IO ()
restart menu = do
    opcao <- getLine
    if opcao == "" then menu else restart menu


iniciarcampanha :: IO ()
iniciarcampanha = do
    system "clear"

    exists <- doesFileExist filePath
    if exists
        then do
            content <- getMultipleLines
            writeFile filePath (unlines content)
            restart menu
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
    putStrLn "Item Excluido"
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
    putStrLn "1 - Listar Habilidades\n2 - Criar Habilidade\n3 - Detalhes de Habilidade\n4 - Excluir Habilidade\n5 - Encatar um Item\n6 - Desencanta um Item\n9 - Voltar Menu\n"
    opcao <- getLine
    let action = lookup opcao (menus "habil")
    verificaEntradaMenu action



desencantaItem :: IO ()
desencantaItem = do
    system "clear"
    putStrLn "Qual o ID da Habilidade?"
    entrada <- getLine
    contents <- readFile filePath
    let habilidades = lines contents
    let id = read entrada :: Int
    if id < (length habilidades) then do
        putStrLn "Qual o ID do Equipavel?"
        entrad <- getLine
        let id_item = read entrad :: Int
        desencantaIdComHabilidade id_item (read (habilidades !! id) :: Habilidade)
        restart menuHabilis
        else do
            putStrLn "Habilidade Inexistente\n"
    where
        filePath = "data/habil.info"


desencantaIdComHabilidade :: Int -> Habilidade -> IO ()
desencantaIdComHabilidade id habilidade = do
    file <- readFile "data/equip.info"
    let itens = transformaListaEquipavel (lines file)
    if id < (length itens) 
        then do
            (tempName, tempHandle) <- openTempFile "data/" "temp"
            let old_item = itens !! id
            let newItens = (delete (old_item) itens)
            hPutStr tempHandle $ unlines (map show ((Item.removeHabilidadeEquipavel old_item habilidade):newItens))
            hClose tempHandle
            removeFile "data/equip.info"
            renameFile tempName "data/equip.info"
        else putStrLn "Item Inexistente\n"



encantaItem :: IO ()
encantaItem = do
    system "clear"
    putStrLn "Qual o ID da Habilidade?"
    entrada <- getLine
    contents <- readFile filePath
    let habilidades = lines contents
    let id = read entrada :: Int
    if id < (length habilidades) then do
        putStrLn "Qual o ID do Equipavel?"
        entrad <- getLine
        let id_item = read entrad :: Int
        encantaIdComHabilidade id_item (read (habilidades !! id) :: Habilidade)
        restart menuHabilis
        else do
            putStrLn "Habilidade Inexistente\n"
    where
        filePath = "data/habil.info"


encantaIdComHabilidade :: Int -> Habilidade -> IO ()
encantaIdComHabilidade id habilidade = do
    file <- readFile "data/equip.info"
    let itens = transformaListaEquipavel (lines file)
    if id < (length itens) 
        then do
            (tempName, tempHandle) <- openTempFile "data/" "temp"
            let old_item = itens !! id
            let newItens = (delete (old_item) itens)
            hPutStr tempHandle $ unlines (map show ((Item.atribuiHabilidadeEquipavel old_item habilidade):newItens))
            hClose tempHandle
            removeFile "data/equip.info"
            renameFile tempName "data/equip.info"
            putStr "Item encantado com sucesso"
        else putStrLn "Item Inexistente\n"



criarHabil :: IO ()
criarHabil = do
    putStrLn "Qual o nome da Habilidade?"
    nome <- getLine
    putStrLn "Qual o Buff/Debuff na Vida?"
    vida <- getLine
    putStrLn "Qual o Buff/Debuff na Velocidade?"
    velocidade <- getLine
    putStrLn "Qual o Atributo da Habilidade (Forca | Inteligencia | Sabedoria | Destreza | Constituicao | Carisma) ?"
    attr <- getLine
    putStrLn "Quantos Pontos Necessários para Acerto?"
    acerto <- getLine
    putStrLn "Qual o Tipo do Dano (Cortante | Magico | Venenoso | Fogo | Gelo | Fisico) ?"
    tipo <- getLine
    appendFile "data/habil.info" (show (Persona.cadastraHabilidade nome (read vida) (read velocidade) (read attr :: Habil.Atributo) (read acerto) (read tipo :: TipoDano)) ++ "\n")
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
    putStrLn "1 - Listar Personagens\n2 - Criar Personagem\n3 - Detalhes de Personagem\n4 - Excluir Personagem\n5 - Menu de Relacao Item/Habilidade com Personagem\n6 - Alterar ouro de Personagem\n7 - Especificar Resistencias\n9 - Inicar Batalha entre Personagens\n0 - Voltar Menu\n"
    tipo <- getLine
    let action = lookup tipo (menus "persona")
    verificaEntradaMenu action


botaResistencia :: IO ()
botaResistencia = do
    putStrLn "Qual A Resistencia? (Cortante | Magico | Venenoso | Fogo | Gelo | Fisico)"
    entrada <- getLine
    let resistencia = read entrada :: TipoDano
    putStrLn "Qual o nome do Personagem?"
    nome <- getLine
    filePerson <- readFile "data/persngs.bd"
    let persngsString = lines filePerson
    let person = getPersng (transformaListaPersonagem persngsString) nome
    if (isNothing person)
        then do
            putStrLn "Personagem Inexistente"
            restart menuPersng
        else do
            let pessoa = fromJust person
            replacePersonOnFile (Persona.adicionarImunidade pessoa resistencia) pessoa
            restart menuPersng


menuOuro :: IO ()
menuOuro = do
    putStrLn "Quanto de Ouro sera alterado?"
    entrada <- getLine
    let valor = read entrada
    putStrLn "Qual o nome do Personagem?"
    nome <- getLine
    filePerson <- readFile "data/persngs.bd"
    let persngsString = lines filePerson
    let person = getPersng (transformaListaPersonagem persngsString) nome
    if (isNothing person)
        then do
            putStrLn "Personagem Inexistente"
            restart menuPersng
        else do
            let pessoa = fromJust person
            let novo = Persona.alteraGold pessoa valor
            replacePersonOnFile novo pessoa
            restart menuPersng



menuItemHabil :: IO ()
menuItemHabil = do
    system "clear"
    putStrLn "1 - Equipar um Item\n2 - Equipar uma Habilidade\n3 - Desequipar um Item\n4 - Desalocar uma Habilidade"
    tipo <- getLine
    let action = lookup tipo (menus "itemHabilPerson")
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
                    if (isNothing person)
                        then do
                            putStrLn "Personagem Inexistente"
                        else do
                            if (tipo == "1") then (linkarEquipPerson (fromJust person) (getEquipavelFromString item))
                                else (linkarConsmvlPerson (fromJust person) (getConsmvlFromString item))
    restart menuPersng


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
    --contents <- readFile "data/persngs.bd"
    handle <- openFile "data/persngs.bd" ReadMode
    contents <- hGetContents handle  

    let personagens = transformaListaPersonagem (lines contents)
    let personagens_finais = (unlines (map show (replacePerson new old personagens)))

    (tempName, tempHandle) <- openTempFile "data/" "temp"
    hPutStr tempHandle personagens_finais
    hClose tempHandle
    hClose handle


    removeFile "data/persngs.bd"
    renameFile tempName "data/persngs.bd"


linkarHabil :: IO ()
linkarHabil = do
    system "clear"
    putStrLn "Qual o ID da Habilidade?"
    entrada <- getLine
    let id = read entrada :: Int
    contents <- readFile "data/habil.info"
    if (id >= (length(lines contents))) then putStrLn "Id Invalida" 
        else do
            let habilidade = (lines contents) !! id
            putStrLn "Qual o nome do Personagem?"
            nome <- getLine
            filePerson <- readFile "data/persngs.bd"
            let persngsString = lines filePerson
            let person = getPersng (transformaListaPersonagem persngsString) nome
            if (isNothing person) then putStrLn "Personagem Inexistente"
                else do
                    linkarHabilPerson (fromJust person) (getHabilFromString habilidade)
    restart menuPersng


linkarHabilPerson :: Personagem -> Habilidade -> IO ()
linkarHabilPerson old_person habilis = do
    let new_person = Persona.alocaHabilidade habilis old_person
    replacePersonOnFile new_person old_person


desalocarHabil :: IO ()
desalocarHabil = do
    system "clear"
    putStrLn "Qual o ID da Habilidade?"
    entrada <- getLine
    let id = read entrada :: Int
    contents <- readFile "data/habil.info"
    if (id >= (length(lines contents))) then putStrLn "Id Invalida" 
        else do
            let habilidade = (lines contents) !! id
            putStrLn "Qual o nome do Personagem?"
            nome <- getLine
            filePerson <- readFile "data/persngs.bd"
            let persngsString = lines filePerson
            let person = getPersng (transformaListaPersonagem persngsString) nome
            if (isNothing person) then putStrLn "Personagem Inexistente"
                else do
                    desalocarHabilPerson (fromJust person) (getHabilFromString habilidade)
    restart menuPersng


desalocarHabilPerson :: Personagem -> Habilidade -> IO ()
desalocarHabilPerson old_person habilis = do
    let new_person = Persona.desalocaHabilidade habilis old_person
    replacePersonOnFile new_person old_person


desequiparItemPerson :: IO ()
desequiparItemPerson = do
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
                            if (tipo == "1") then (desequiparEquipPerson (fromJust person) (getEquipavelFromString item))
                                else (desequiparConsmvlPerson (fromJust person) (getConsmvlFromString item))
    restart menuPersng


desequiparEquipPerson :: Personagem -> Equipavel -> IO ()
desequiparEquipPerson persng item = do
    let new_person = Persona.desequiparItem item persng
    replacePersonOnFile new_person persng


desequiparConsmvlPerson :: Personagem -> Consumivel -> IO ()
desequiparConsmvlPerson persng item = do
    let new_person = Persona.desequiparConsumivel item persng
    replacePersonOnFile new_person persng


menuBatalhaInicial :: IO ()
menuBatalhaInicial = do
    system "clear"
    putStrLn "Quais são os Personagem que irão participar da Batalha? (Nomes)"
    nomes <- getMultipleLines
    personagensString <- readFile "data/persngs.bd"
    let personagens = getPersonagens nomes (transformaListaPersonagem (lines personagensString))
    putStrLn "Os personagens escolhidos foram:"
    putStrLn (Persona.listarPersonagens personagens)
    putStrLn "Presione _ para\n(R)e-escolher personagens\nOu\n(C)ontinuar?"
    escolha <- getLine
    if escolha == "R" then menuBatalhaInicial
        else do
            system "clear"
            menuBatalha personagens


getPersonagens :: [String] -> [Personagem] -> [Personagem]
getPersonagens [] _ = []
getPersonagens (x:xs) personagens
    | isNothing (getPersng personagens x) = (getPersonagens xs personagens)
    | otherwise = (fromJust(getPersng personagens x)):(getPersonagens xs personagens)


menuBatalha :: [Personagem] -> IO ()
menuBatalha personagens = do
    putStrLn "Qual sera a proxima acao?\n1 - Personagem Usar Habilidade\n2 - Personagem Usar Comsumivel\n3 - Checar Personagens\n9 - Limpar as mensagens anteriores\n0 - Encerrar a Batalha\n"
    opcao <- getLine
    let action = lookup opcao [("1", batalhaHabilis), ("2", batalhaConsmvl), ("3", checarPersons),("9", limparChat), ("0", encerramento)]
    verificaEntradaBatalha action personagens


checarPersons :: [Personagem] -> IO ()
checarPersons persons = do
    putStrLn $ unlines (printarPersonagens persons)
    menuBatalha persons


printarPersonagens :: [Personagem] -> [String]
printarPersonagens [] = []
printarPersonagens (p:ps) = (Persona.exibePersonagemString p):(printarPersonagens ps)


verificaEntradaBatalha :: Maybe ([Personagem] -> IO ()) -> ([Personagem] -> IO ())
verificaEntradaBatalha Nothing = (\ a -> putStrLn "\nEntrada Invalida brooo, vlw flw\n\nps. tuas alteracoees n foram salvas :(\n\n")
verificaEntradaBatalha (Just a) = a


batalhaConsmvl :: [Personagem] -> IO ()
batalhaConsmvl personagens = do
    putStrLn "Qual dos Personagens usara o Consumivel? (Nome)"
    putStrLn (Persona.listarPersonagens personagens)
    nome <- getLine
    if not(isNothing (getPersng personagens nome)) then do
        putStrLn "Em Qual dos Personagens sera aplicado o Consumivel? (Nome)"
        putStrLn (Persona.listarPersonagens personagens)
        nome2 <- getLine
        if not((isNothing (getPersng personagens nome2)))
            then do
                putStrLn "Qual o ID do Consumivel que sera usado? (ID Geral)"
                entrada <- getLine
                let id = read entrada :: Int
                contents <- readFile "data/consmvl.info"
                let itens = lines contents
                if id < length itens
                    then do
                        let envolvidos = getPersonagens [nome, nome2] personagens 
                        let newPersons = Batalha.turnoConsumivel (head envolvidos) (last envolvidos) (getConsmvlFromString (itens !! id))
                        if(nome_personagem head(newPerson) /= nome_personagem snd(newPerson))
                            then do
                                putStrLn "Os Personagens agora estao assim:"
                                putStrLn $ Persona.exibePersonagemString head(newPersons)
                                putStrLn $ Persona.exibePersonagemString last(newPersons)
                                putStrLn "\nEnter para voltar a batalha"
                                restartBatalha menuBatalha ((Persona.atualizaPersonagem (Persona.atualizaPersonagem personagens head(newPersons)) snd(newPersons)))
                            else do
                                putStrLn "O Personagem agora esta assim:"
                                putStrLn $ Persona.exibePersonagemString head(newPersons)
                                putStrLn "\nEnter para voltar a batalha"
                                restartBatalha menuBatalha (Persona.atualizaPersonagem personagens head(newPersons))
                    else do
                        putStrLn "ID Invalido"
                        restartBatalha menuBatalha personagens
            else do
                putStrLn "Personagem Inexistente"
                restartBatalha menuBatalha personagens
        else do
            putStrLn "Personagem Inexistente"
            restartBatalha menuBatalha personagens


restartBatalha :: ([Personagem] -> IO ()) -> [Personagem] -> IO ()
restartBatalha battle personagens = do
    opcao <- getLine
    if opcao == "" then battle personagens else (restartBatalha battle personagens)



limparChat :: [Personagem] -> IO ()
limparChat personagens = do
    system "clear"
    menuBatalha personagens


batalhaHabilis :: [Personagem] -> IO ()
batalhaHabilis personagens = do
    putStrLn "Qual dos Personagens usara a Habilidade? (Nome)"
    putStrLn (Persona.listarPersonagens personagens)
    nome <- getLine
    if not((isNothing (getPersng personagens nome))) then do
        putStrLn "Em Qual dos Personagens sera aplicado a Habilidade? (Nome)"
        putStrLn (Persona.listarPersonagens personagens)
        nome2 <- getLine
        if not((isNothing (getPersng personagens nome2)))
            then do
                putStrLn "Qual o ID da habilidade que sera usada? (ID Geral)"
                entrada <- getLine
                let id = read entrada :: Int
                contents <- readFile "data/habil.info"
                let habilidades = lines contents
                if id < length habilidades
                    then do
                        let envolvidos = getPersonagens [nome, nome2] personagens
                        let habilidade = getHabilFromString (habilidades !! id)
                        random_gen <- newStdGen
                        let dados = take 2 (randomRs (1,20) random_gen)
                        putStrLn "Os Dados tirados Foram:"
                        putStrLn ((show (head dados)) ++ " - " ++ (show (last dados)))
                        putStrLn $ "A habilidade usada foi " ++ show(Habil.nome_habilidade habilidade)
                        putStrLn $ "Esta habilidade requer tirar " ++ show(Habil.pontosParaAcerto habilidade) ++ " pontos para acertar."
                        if tipoDeDano habilidade `elem` Persona.imunidades (last envolvidos) then
                          putStrLn "O receptor tem resistência ao tipo da habilidade. O dado de menor número será usado."
                        else
                          putStrLn "O receptor não tem resistência ao tipo da habilidade. O dado de maior número será usado."
                        putStrLn $ "O emissor tem " ++ show(Batalha.selecionaAtributoRelacionado (Habil.atributo_relacionado habilidade) (last envolvidos)) ++ " pontos do atributo relacionado à habilidade. Estes serão somados ao número do dado para o acerto.\n"
                        let newPerson = Batalha.turnoHabilidade (head envolvidos) (last envolvidos) habilidade (head dados) (last dados)
                        putStrLn "O receptor agora esta assim:"
                        putStrLn $ Persona.exibePersonagemString newPerson
                        putStrLn "\nEnter para voltar a batalha"

                        restartBatalha menuBatalha (Persona.atualizaPersonagem personagens ([newPerson] ++ [newPerson]))
                    else do
                        putStrLn "ID Invalido"
                        restartBatalha menuBatalha personagens
            else do
                putStrLn "Personagem Inexistente"
                restartBatalha menuBatalha personagens
        else do
            putStrLn "Personagem Inexistente"
            restartBatalha menuBatalha personagens

menuLoja :: IO ()
menuLoja = do
    system "clear"
    putStrLn "1 - Listar Lojas\n2 - Criar Loja\n3 - Adiciona um equipavel na Loja\n4 - Aciona um Consumivel na Loja\n5 - Detalhes de Loja\n6 - Excluir Loja\n7 - Negociar com a Loja\n9 - Voltar Menu\n"
    tipo <- getLine
    let action = lookup tipo (menus "loja")
    verificaEntradaMenu action

listarLojas :: IO ()
listarLojas = do
    system "clear"
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
                    putStrLn "Qual o preco do Item?"
                    precoStr <- getLine
                    let preco = read precoStr :: Int
                    if(preco <= 0) then putStrLn "Preco Invalido"
                        else do
                            let item = (lines itemStr) !! id
                            putStrLn "Qual o nome da Loja?"
                            nome <- getLine
                            fileLoja <- readFile "data/Loja.bd"
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
    --contents <- readFile "data/lojas.bd"
    handle <- openFile "data/loja.bd" ReadMode
    contents <- hGetContents handle

    let lojas = transformaListaLoja (lines contents)
    let lojas_finais = (unlines (map show (replaceLoja new old lojas)))

    (tempName, tempHandle) <- openTempFile "data/" "temp"
    hPutStr tempHandle lojas_finais
    hClose tempHandle
    hClose handle


    removeFile "data/lojas.bd"
    renameFile tempName "data/lojas.bd"

replaceLoja :: Loja -> Loja -> [Loja] -> [Loja]
replaceLoja new old [] = []
replaceLoja new old (x:xs)
    | old == x = (new:xs)
    | otherwise = x:(replaceLoja new old xs)

detalhesLoja :: IO ()
detalhesLoja = do
    system "clear"
    putStrLn "Qual o Nome da Loja?"
    nome <- getLine
    contents <- readFile "data/loja.bd"
    putStrLn (getDetalhesLoja (lines contents) nome)
    restart menuLoja

excluiLoja :: IO ()
excluiLoja = do
    system "clear"
    putStrLn "Qual o Nome da Loja?"
    nome <- getLine
    contents <- readFile "data/loja.bd"
    let loja_possi = getDetalhesLoja (lines contents) nome
    if (loja_possi == "Loja inexistente\n") then (putStrLn loja_possi)
    else putStr "Loja excluida com sucesso"
        (deleteLoja (lines contents) (getLoja (transformaListaLoja (lines contents)) nome))
    restart menuLoja
            
getDetalhesLoja :: [String] -> String -> String
getDetalhesLoja lojas nome = 
    (Loja.exibeLoja (transformaListaLoja lojas) nome)

deleteLoja ::  [String] -> (Maybe (Loja)) -> IO ()
deleteLoja listaLoja lojaMayb = do
    if (not (isNothing lojaMayb))
        then do
            let persng = fromJust (lojaMayb)
            (tempName, tempHandle) <- openTempFile "data/" "temp"
            hPutStr tempHandle $ unlines ((listaLoja \\ [(show loja)]))
            hClose tempHandle
            removeFile "data/loja.bd"
            renameFile tempName "data/loja.bd"
            putStrLn "Loja excluida com Sucesso\n"
        else putStrLn "Loja inexistente\n"

menuNegociaLoja :: IO ()
menuNegociaLoja = do
    system "clear"
    putStrLn "1 - Comprar um Item\n2 - Vender um Item\n9 - Voltar Menu\n"
    tipo <- getLine
    let action = lookup tipo (menus "negociaLoja")
    verificaEntradaMenu action

comprarItem :: IO ()

comprarEquipavel :: Int

comprarConsumivel :: Int

venderItem :: IO ()
venderItem = do
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
                                    "Item vendido com sucesso"
                                    if (tipo == "1") then (venderEquip (fromJust person) (getEquipavelFromString item) preco)
                                        else (venderConsmvl (fromJust person) (getConsmvlFromString item) preco)
    restart menuNegociaLoja


venderEquip :: Personagem -> Equipavel -> Int -> IO ()
venderEquip persng item = do
    let new_person = Loja.vendeEquipavel persng item preco
    replacePersonOnFile new_person persng


venderConsmvl :: Personagem -> Consumivel -> Int -> IO ()
venderConsmvl persng item preco = do
    let new_person = Loja.vendeConsumivel persng item preco
    replacePersonOnFile new_person persng


encerramento :: [Personagem] -> IO ()
encerramento personagens = do
    putStrLn "Batalha Encerrada"
    let mortos = [p | p <- personagens, not (Batalha.taVivo p)]
    putStrLn "Os Personagens que morreram foram:\n"
    putStrLn $ Persona.listarPersonagens mortos
    let vivos = [p | p <- personagens, Batalha.taVivo p]
    putStrLn "\nOs Personagens que sobreviveram foram:\n"
    putStrLn $ Persona.listarPersonagens vivos
    putStrLn "\n\nQuais Personagens voce gostaria de resetar a vida para o maximo?"
    zumbis <- getMultipleLines
    putStrLn "Quais Personagens voce gostaria de apagar do sistema?"
    apagar <- getMultipleLines
    let pos_regeneracao = regenera personagens zumbis
    let personagens_finais = [ p | p <- pos_regeneracao, p `notElem` (getPersonagens apagar pos_regeneracao) ]
    -- (getPersonagens zumbis personagens)
    -- let personagens_finais = [p | p <- regenerados, p `notElem` (getPersonagens apagar regenerados)]
    writeFile "data/persngs.bd" (unlines(map show personagens_finais))
    putStrLn "\n\nAlteracoes Salvas\nRetornando ao Menu\n"
    menu

regenera :: [Personagem] -> [String] -> [Personagem]
regenera [] lista = []
regenera (p:ps) lista
  | Persona.nome_personagem p `elem` lista          = Persona.regeneraPersonagem p : regenera ps lista
  | otherwise                                       = p : regenera ps lista


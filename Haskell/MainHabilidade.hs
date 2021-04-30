module MainHabilidade where
import System.IO
import System.Directory
import System.FilePath.Posix
import System.Process
import System.Random
import Item as Item
import Personagem as Persona
import Habilidade as Habil
import Data.List
import Data.Maybe
import Util

menuHabilis :: IO ()
menuHabilis = do
    system "cls"
    let menuH = [ ("1", listarHabil)
            , ("2", criarHabil)
            , ("3", detalhesHabil)
            , ("4", excluirHabil)
            , ("5", encantaItem)
            , ("9", print "")
            ]
    putStrLn            "           ("
    putStrLn            "            )"
    putStrLn            "           (  ("
    putStrLn            "               )"
    putStrLn            "         (    (  ,,"
    putStrLn            "          ) /\\ (("
    putStrLn            "        (  // | (`'"
    putStrLn            "      _ -.;_/\\ \\--._"
    putStrLn            "     (_;-// | \\ \\-'.\\"
    putStrLn            "     ( `.__ _  ___,')"
    putStrLn            "jrei  `'(_ )_)(_)_)"
    putStrLn            "1 - Listar Habilidades\n2 - Criar Habilidade\n3 - Detalhes de Habilidade\n4 - Excluir Habilidade\n5 - Encatar um Item\n6 - Desencanta um Item\n9 - Voltar Menu\n"
    opcao <- getLine
    let action = lookup opcao (menuH)
    verificaEntradaMenu action



desencantaItem :: IO ()
desencantaItem = do
    system "cls"
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
    system "cls"
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
    system "cls"
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
    system "cls"
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
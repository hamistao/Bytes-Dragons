module Personagem where
-- import System.Random
import Item

data Habilidade = Habilidade {
    nome_habilidade :: String,
    impacto_vida :: Int,
    impacto_dano :: Int,
    impacto_velocidade :: Int,
    atributo_relacionado :: String,
    pontosParaAcerto :: Int,
    tipoDeDano :: String
} deriving(Show, Eq)

data Personagem = Personagem {
    alcunha :: String
    ,raca :: String
    ,classe :: String
    ,vida :: Int
    ,vidaMaxima :: Int
    ,forca :: Int
    ,inteligencia :: Int
    ,sabedoria :: Int
    ,destreza :: Int
    ,constituicao :: Int
    ,carisma :: Int
    ,dano :: Int
    ,velocidade :: Int
    ,ouro :: Int
    ,equipaveis :: [Equipavel]
    ,consumiveis :: [Consumivel]
    ,habilidades :: [Habilidade]
} deriving(Show)

cadastraPersonagem :: String -> String -> String -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Personagem
cadastraPersonagem alcunha classe raca vidaMaxima forca inteligencia sabedoria destreza constituicao carisma = (Personagem {
                                                                                                                    alcunha = alcunha
                                                                                                                    ,classe = classe
                                                                                                                    ,raca = raca
                                                                                                                    ,vida = vidaMaxima
                                                                                                                    ,vidaMaxima = vidaMaxima
                                                                                                                    ,forca = forca
                                                                                                                    ,inteligencia = inteligencia
                                                                                                                    ,sabedoria = sabedoria
                                                                                                                    ,destreza = destreza
                                                                                                                    ,constituicao = constituicao
                                                                                                                    ,carisma = carisma
                                                                                                                    ,dano = forca
                                                                                                                    ,velocidade = destreza
                                                                                                                    ,ouro = 0
                                                                                                                    ,equipaveis = []
                                                                                                                    ,consumiveis = []
                                                                                                                    ,habilidades = []
                                                                                                                })


cadastraHabilidade :: String -> Int -> Int -> Int -> String -> Int -> String -> Habilidade
cadastraHabilidade nome impacto_vida impacto_dano impacto_velocidade atributo_relacionado pontosParaAcerto tipoDeDano = (Habilidade {
                                                                                                                            nome_habilidade = nome
                                                                                                                            ,impacto_vida = impacto_vida
                                                                                                                            ,impacto_dano = impacto_dano
                                                                                                                            ,impacto_velocidade = impacto_velocidade
                                                                                                                            ,atributo_relacionado = atributo_relacionado
                                                                                                                            ,pontosParaAcerto = pontosParaAcerto
                                                                                                                            ,tipoDeDano = tipoDeDano
                                                                                                                        })

listarPersonagens :: [Personagem] -> String
listarPersonagens [] = ""
listarPersonagens (s:xs) = "---------------------------\n"
                           ++ "Nome: " ++ show(alcunha s) ++ "\n"
                           ++ "Raca: " ++ show(raca s) ++ "\n"
                           ++ "Classe: " ++ show(classe s) ++ "\n"
                           ++ listarPersonagens xs

exibePersonagem :: [Personagem] -> String -> String
exibePersonagem [] nome = "Personagem inexistente"
exibePersonagem (s:xs) nome
    | nome == (alcunha s) = "Nome: " ++ show(alcunha s) ++ "\n"
                        ++ "Raca: " ++ show(raca s) ++ "\n"
                        ++ "Classe: " ++ show(classe s) ++ "\n"
                        ++ "Vida: " ++ show(vida s) ++ "/" ++ show(vidaMaxima s) ++ "\n"
                        ++ "Forca: " ++ show(forca s) ++ "\n"
                        ++ "Inteligencia: " ++ show(inteligencia s) ++ "\n"
                        ++ "Sabedoria: " ++ show(sabedoria s) ++ "\n"
                        ++ "Destreza: " ++ show(destreza s) ++ "\n"
                        ++ "Constituicao: " ++ show(constituicao s) ++ "\n"
                        ++ "Carisma: " ++ show(carisma s) ++ "\n"
                        ++ "Dano: " ++ show(dano s) ++ "\n"
                        ++ "Velocidade: " ++ show(velocidade s) ++ "\n"
                        ++ "Ouro: " ++ show(ouro s) ++ "\n"
                        ++ "Itens:\n"
                        ++ "Equipaveis:\n"
                        ++ (unlines (listarEquipaveis (equipaveis s)))
                        ++ "Consumiveis:\n"
                        ++ (unlines (listarConsumiveis (consumiveis s)))
                        ++ "Habilidades:\n"
                        ++ (unlines (listarHabilidades (habilidades s)))
    | otherwise = exibePersonagem xs nome

listarHabilidade :: Habilidade -> String
listarHabilidade habilidade = "---------------------------\n"
                           ++ "Nome: " ++ show(nome_habilidade habilidade) ++ "\n"
                           ++ if (impacto_vida habilidade /= 0) then "Causa " ++ show(impacto_dano habilidade) ++ " de dano do tipo " ++ show(tipoDeDano habilidade) ++ "\n" else ""
                           ++ if (impacto_dano habilidade /= 0) then "Causa " ++ show(impacto_dano habilidade) ++ " de dano no dano\n" else ""
                           ++ if (impacto_velocidade habilidade /= 0) then "Causa " ++ show(impacto_velocidade habilidade) ++ " de dano na velocidade\n" else ""
                           ++ "Pontos para acerto: " ++ show(pontosParaAcerto habilidade) ++ "%\n"

listarHabilidades :: [Habilidade] -> [String]
listarHabilidades [] = [""]
listarHabilidades (s:xs) = ("Nome: " ++ show(nome_habilidade s) ++ "\n"): listarHabilidades xs

selecionaAtributoRelacionado :: String -> Personagem -> Int
selecionaAtributoRelacionado atributo personagem
    | atributo == "forca" = forca personagem
    | atributo == "inteligencia" = inteligencia personagem
    | atributo == "sabedoria" = sabedoria personagem
    | atributo == "destreza" = destreza personagem
    | atributo == "constituicao" = constituicao personagem
    | atributo == "casrisma" = carisma personagem
    | otherwise = 0

usaHabilidade :: Habilidade -> Personagem -> Personagem
usaHabilidade habilidade personagem =
    Personagem{alcunha = alcunha personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem + impacto_vida habilidade
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,dano = dano personagem + impacto_dano habilidade
        ,velocidade = velocidade personagem + impacto_velocidade habilidade
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem
        ,habilidades = habilidades personagem
    }

isEquipavel :: [Equipavel] -> TipoEquipavel -> Maybe(Equipavel)
isEquipavel (x:xs) tipoEquipavel = if(x == []) then Nothing
                                   else if(x.tipo == tipoEquipavel) then (Just x) 
                                   else isEquipavel xs

usarItemEquipavel :: Equipavel -> Personagem -> Personagem
usarItemEquipavel equipavel personagem = equiparItem equipavel (desequiparItem equipavel personagem)


desequiparItem :: Equipavel -> Personagem -> Personagem
desequiparItem equipavel personagem = if (isNothing (isEquipavel personagem.equipaveis equipavel.tipo)) then personagem
                                      else  Personagem{ alcunha = alcunha personagem
                                                        ,raca = raca personagem
                                                        ,classe = classe personagem
                                                        ,vida = vida personagem
                                                        ,vidaMaxima = vidaMaxima personagem
                                                        ,forca = forca personagem
                                                        ,inteligencia = inteligencia personagem
                                                        ,sabedoria = sabedoria personagem
                                                        ,destreza = destreza personagem
                                                        ,constituicao = constituicao personagem
                                                        ,carisma = carisma personagem
                                                        ,dano = dano personagem
                                                        ,velocidade = velocidade personagem + alteracao_velocidade equipavel
                                                        ,ouro = ouro personagem
                                                        ,equipaveis = removerEquipavel equipaveis equipavel
                                                        ,consumiveis = consumiveis personagem
                                                        ,habilidades = habilidades personagem
                                                    } 

equiparItem :: Equipavel -> Personagem -> Personagem
equiparItem equipavel personagem = 
    
    Personagem{alcunha = alcunha personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,dano = dano personagem
        ,velocidade = velocidade personagem + alteracao_velocidade equipavel
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem ++ [equipavel]
        ,consumiveis = consumiveis personagem
        ,habilidades = habilidades personagem
    }

removerEquipavel :: [Equipavel] -> Equipavel -> [Equipavel]
removerEquipavel equipaveis equipavel = [x | x <- equipaveis, tipo equipavel /= tipo x]

guardarConsumivel :: Consumivel -> Personagem -> Personagem
guardarConsumivel item personagem =
    Personagem{alcunha = alcunha personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,dano = dano personagem
        ,velocidade = velocidade personagem
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem ++ [item]
        ,habilidades = habilidades personagem
    }

removeConsumivel :: Consumivel -> Personagem -> [Consumivel]
removeConsumivel consumivel personagem
    | duracao consumivel /= 0 = [item | item <- consumiveis personagem, nomeConsumivel item /= nomeConsumivel consumivel] ++ [consumivel]
    | otherwise = [item | item <- consumiveis personagem, nomeConsumivel item /= nomeConsumivel consumivel]

usarItemConsumivel :: Consumivel -> Personagem -> Personagem
usarItemConsumivel consumivel personagem =
    Personagem{alcunha = alcunha personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem + alteracaoVida consumivel
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,dano = dano personagem + alteracaoDano consumivel
        ,velocidade = velocidade personagem
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = removeItem consumivel personagem
        ,habilidades = habilidades personagem
    }

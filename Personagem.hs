module Personagem where
import System.Random
import Item

data Habilidade = Habilidade {
    nome_habilidade :: String,
    intensidade :: Int,
    atributoAfetado :: String,
    chanceDeAcerto :: Int,
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
    ,resistencia :: Int
    ,dano :: Int
    ,velocidade :: Int
    ,ouro :: Int
    ,equipaveis :: [Equipavel]
    ,consumiveis :: [Consumivel]
    ,habilidades :: [Habilidade]
} deriving(Show, Eq)

cadastraPersonagem :: String -> String -> String -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Personagem
cadastraPersonagem alcunha classe raca vidaMaxima forca inteligencia sabedoria destreza constituicao carisma = (Personagem {
                                                                                                                    alcunha = alcunha
                                                                                                                    ,vida = vidaMaxima
                                                                                                                    ,classe = classe
                                                                                                                    ,raca = raca
                                                                                                                    ,vidaMaxima = vidaMaxima
                                                                                                                    ,forca = forca
                                                                                                                    ,inteligencia = inteligencia
                                                                                                                    ,sabedoria = sabedoria
                                                                                                                    ,destreza = destreza
                                                                                                                    ,constituicao = constituicao
                                                                                                                    ,carisma = carisma
                                                                                                                    ,resistencia = constituicao
                                                                                                                    ,dano = forca
                                                                                                                    ,velocidade = destreza
                                                                                                                    ,ouro = 0
                                                                                                                    ,equipaveis = []
                                                                                                                    ,consumiveis = []
                                                                                                                    ,habilidades = []
                                                                                                                })

cadastraHabilidade :: String -> Int -> String -> Int -> String -> Habilidade
cadastraHabilidade nome intensidade atributoAfetado chanceDeAcerto tipoDeDano = (Habilidade {
                                                                                    nome_habilidade = nome
                                                                                    ,intensidade = intensidade
                                                                                    ,atributoAfetado = atributoAfetado
                                                                                    ,chanceDeAcerto = chanceDeAcerto
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
                        ++ "Resistencia: " ++ show(resistencia s) ++ "\n"
                        ++ "Dano: " ++ show(dano s) ++ "\n"
                        ++ "Velocidade: " ++ show(velocidade s) ++ "\n"
                        ++ "Ouro: " ++ show(ouro s) ++ "\n"
                        ++ "Itens:\n"
                        ++ "Equipaveis:\n"
                        ++ listarEquipaveis (equipaveis s)
                        ++ "Consumiveis:\n"
                        ++ listarConsumiveis (consumiveis s)
                        ++ "Habilidades:\n"
                        ++ listarHabilidades (habilidades s)
    | otherwise = exibePersonagem xs nome

listarHabilidades :: [Habilidade] -> String
listarHabilidades [] = ""
listarHabilidades (s:xs) = "---------------------------\n"
                           ++ "Nome: " ++ show(nome_habilidade s) ++ "\n"
                           ++ "Causa " ++ show(intensidade s) ++ " do tipo " ++ show(tipoDeDano s) ++ " no atributo " ++ show(atributoAfetado s) ++ "\n"
                           ++ "Chance de acerto: " ++ show(chanceDeAcerto s) ++ "%\n"
                           ++ listarHabilidades xs

turno :: Habilidade -> Personagem -> Personagem
turno habilidade personagem =
    Personagem{alcunha = alcunha personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem + intensidade habilidade
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,resistencia = resistencia personagem
        ,dano = dano personagem
        ,velocidade = velocidade personagem
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem
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
        ,resistencia = resistencia personagem + alteracao_resistencia_equipavel equipavel
        ,dano = dano personagem
        ,velocidade = velocidade personagem + alteracao_velocidade equipavel
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem ++ [equipavel]
        ,consumiveis = consumiveis personagem
        ,habilidades = habilidades personagem
    }

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
        ,resistencia = resistencia personagem
        ,dano = dano personagem
        ,velocidade = velocidade personagem
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem ++ [item]
        ,habilidades = habilidades personagem
    }

removeItem :: Consumivel -> Personagem -> [Consumivel]
removeItem consumivel personagem
    | duracao consumivel /= 0 = [item | item <- consumiveis personagem, nome item /= nome consumivel] ++ [consumivel]
    | otherwise = [item | item <- consumiveis personagem, nome item /= nome consumivel]

usarItem :: Consumivel -> Personagem -> Personagem
usarItem consumivel personagem =
    Personagem{alcunha = alcunha personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem + alteracao_vida consumivel
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,resistencia = resistencia personagem + alteracao_resistencia consumivel
        ,dano = dano personagem + alteracao_dano equipavel
        ,velocidade = velocidade personagem
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = removeItem consumivel personagem
        ,habilidades = habilidades personagem
    }

module Persongem where
import System.Random
import Item


data Habilidade = Habilidade {
    nome :: String,
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
                                                                                                                    ,resistencia = resistencia
                                                                                                                    ,dano = dano
                                                                                                                    ,velocidade = velocidade
                                                                                                                    ,ouro = 0
                                                                                                                    ,equipaveis = []
                                                                                                                    ,consumiveis = []
                                                                                                                    ,habilidades = []
                                                                                                                })

cadastraHabilidade :: String -> Int -> String -> Int -> String -> Habilidade
cadastraHabilidade nome intensidade atributoAfetado chanceDeAcerto tipoDeDano = (Habilidade {
                                                                                    nome = nome
                                                                                    ,intensidade = intensidade
                                                                                    ,atributoAfetado = atributoAfetado
                                                                                    ,chanceDeAcerto = chanceDeAcerto
                                                                                    ,tipoDeDano = tipoDeDano
                                                                                })

listarPersonagens :: [Personagem] -> String
listarPersonagens [] = ""
listarPersonagens (s:xs) = "---------------------------\n"
                           ++ "Alcunha: " ++ show(alcunha s) ++ "\n"
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
                           ++ listarEquipaveis equipaveis
                           ++ "Consumiveis:\n"
                           ++ listarConsumiveis consumiveis
                           ++ "Habilidades:\n"
                           ++ listarHabilidades habilidades
                           ++ listarPersonagens xs

listarHabilidades :: [Habilidade] -> String
listarHabilidades [] = ""
listarHabilidades (s:xs) = "---------------------------\n"
                           ++ "Nome: " ++ show(nome s) ++ "\n"
                           ++ "Causa " ++ show(intensidade s) ++ " do tipo " ++ show(tipoDeDano) ++ " no atributo " ++ show(atributoAfetado s) ++ "\n"
                           ++ "Chance de acerto: " ++ show(chanceDeAcerto s) ++ "%" ++ "\n"
                           ++ listarHabilidades xs

bate :: Habilidade -> Personagem -> Personagem
bate habilidade personagem =
    Personagem{alcunha = personagem.alcunha
        ,raca = personagem.raca
        ,classe = personagem.classe
        ,vida = personagem.vida + habilidade.intensidade
        ,vidaMaxima = personagem.vidaMaxima
        ,forca = personagem.forca
        ,inteligencia = personagem.inteligencia
        ,sabedoria = personagem.sabedoria
        ,destreza = personagem.destreza
        ,constituicao = personagem.constituicao
        ,carisma = personagem.carisma
        ,resistencia = personagem.resistencia
        ,dano = personagem.dano
        ,velocidade = personagem.velocidade
        ,ouro = personagem.ouro
        ,equipaveis = personagem.equipaveis
        ,consumiveis = personagem.consumiveis
        ,habilidades = personagem.habilidades
    }
equiparItem :: Equipavel -> Personagem -> Personagem
equiparItem equipavel personagem = 
    Personagem{alcunha = personagem.alcunha
        ,raca = personagem.raca
        ,classe = personagem.classe
        ,vida = personagem.vida
        ,vidaMaxima = personagem.vidaMaxima
        ,forca = personagem.forca
        ,inteligencia = personagem.inteligencia
        ,sabedoria = personagem.sabedoria
        ,destreza = personagem.destreza
        ,constituicao = personagem.constituicao
        ,carisma = personagem.carisma
        ,resistencia = personagem.resistencia + equipavel.alteracao_resistencia_equipavel
        ,dano = personagem.dano
        ,velocidade = personagem.velocidade + equipavel.alteracao_velocidade
        ,ouro = personagem.ouro
        ,equipaveis = personagem.equipaveis ++ equipavel
        ,consumiveis = personagem.consumiveis
        ,habilidades = personagem.habilidades
    }

usarItem :: Consumivel -> Personagem -> Personagem
usarItem consumivel personagem =
    Personagem{alcunha = personagem.alcunha
        ,raca = personagem.raca
        ,classe = personagem.classe
        ,vida = personagem.vida + consumivel.alteracao_vida
        ,vidaMaxima = personagem.vidaMaxima
        ,forca = personagem.forca
        ,inteligencia = personagem.inteligencia
        ,sabedoria = personagem.sabedoria
        ,destreza = personagem.destreza
        ,constituicao = personagem.constituicao
        ,carisma = personagem.carisma
        ,resistencia = personagem.resistencia + consumivel.alteracao_resistencia
        ,dano = personagem.dano + equipavel.alteracao_dano
        ,velocidade = personagem.velocidade
        ,ouro = personagem.ouro
        ,equipaveis = personagem.equipaveis
        ,consumiveis = personagem.consumiveis
        ,habilidades = personagem.habilidades
    }
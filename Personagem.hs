module Persongem where
import System.Random


data Habilidade = Habilidade {
    nome :: String,
    intensidade :: Int,
    atributoAfetado :: String,
    chanceDeAcerto :: Int,
    tipoDeDano :: String
} deriving(Show)

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
} deriving(Show)

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

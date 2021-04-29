module Habilidade where

data Habilidade = Habilidade {
    nome_habilidade :: String,
    impacto_vida :: Int,
    impacto_dano :: Int,
    impacto_velocidade :: Int,
    atributo_relacionado :: Atributo,
    pontosParaAcerto :: Int,
    tipoDeDano :: TipoDano
} deriving(Show, Eq, Read)


data Atributo = Forca | Inteligencia | Sabedoria | Destreza | Constituicao | Carisma deriving(Show, Read, Eq)
data TipoDano = Cortante | Magico | Venenoso | Fogo | Gelo | Fisico  deriving (Show, Read, Eq)

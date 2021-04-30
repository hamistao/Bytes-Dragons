module Habilidade where

data Habilidade = Habilidade {
    nome_habilidade :: String,
    impacto_vida :: Int,
    impacto_velocidade :: Int,
    atributo_relacionado :: Atributo,
    pontosParaAcerto :: Int,
    tipoDeDano :: TipoDano
} deriving(Show, Eq, Read)


data Atributo = Forca | Inteligencia | Sabedoria | Destreza | Constituicao | Carisma deriving(Show, Read, Eq)
data TipoDano = Cortante | Magico | Venenoso | Fogo | Gelo | Fisico  deriving (Show, Read, Eq)

listarHabilidade :: Habilidade -> String
listarHabilidade habilidade = "---------------------------\n"
                           ++ "Nome: " ++ show(nome_habilidade habilidade) ++ "\n"
                           ++ "Tipo da habilidade: " ++ show(tipoDeDano habilidade) ++ "\n"
                           ++ "Atributo relacionado: " ++ show(atributo_relacionado habilidade) ++ "\n"
                           ++ "Modifica a vida do alvo em " ++ show(impacto_vida habilidade) ++ "\n"
                           ++ "Modifica a velocidade do alvo em " ++ show(impacto_velocidade habilidade) ++ "\n"
                           ++ "Pontos para acerto: " ++ show(pontosParaAcerto habilidade) ++ "\n"

listarHabilidades :: [Habilidade] -> [String]
listarHabilidades [] = []
listarHabilidades (s:xs) = ("Nome: " ++ show(nome_habilidade s) ++ "\n"): listarHabilidades xs

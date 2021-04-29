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

listarHabilidade :: Habilidade -> String
listarHabilidade habilidade = "---------------------------\n"
                           ++ "Nome: " ++ show(nome_habilidade habilidade) ++ "\n"
                           ++ if (impacto_vida habilidade /= 0) then "Causa " ++ show(impacto_dano habilidade) ++ " de dano do tipo " ++ show(tipoDeDano habilidade) ++ "\n" else ""
                           ++ if (impacto_dano habilidade /= 0) then "Modifica o dano do alvo em " ++ show(impacto_dano habilidade) ++ "\n" else ""
                           ++ if (impacto_velocidade habilidade /= 0) then "Modifica a velocidade do alvo em " ++ show(impacto_velocidade habilidade) ++ "\n" else ""
                           ++ "Pontos para acerto: " ++ show(pontosParaAcerto habilidade) ++ "%\n"

listarHabilidades :: [Habilidade] -> [String]
listarHabilidades [] = []
listarHabilidades (s:xs) = ("Nome: " ++ show(nome_habilidade s) ++ "\n"): listarHabilidades xs

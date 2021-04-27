module Item where

data Consumivel = Consumivel {
  nome_consumivel :: String
  , alteracao_vida :: Int
  , alteracao_dano :: Int
  , alteracao_velocidade_consumivel :: Int
  , duracao :: Int
  } deriving (Show, Eq, Read)

data Equipavel = Equipavel {
  nome_equipavel :: String
  , alteracao_vida_maxima :: Int
  , alteracao_forca :: Int
  , alteracao_inteligencia :: Int
  , alteracao_sabedoria :: Int
  , alteracao_destreza :: Int
  , alteracao_constituicao :: Int
  , alteracao_carisma :: Int
  , alteracao_velocidade_equipavel :: Int
  , tipo_equipavel :: TipoEquipavel
  } deriving (Show, Read, Eq)

data TipoEquipavel = Cabeca | Torso | Pernas | Maos deriving(Show, Read, Eq)
--'elem'

criaConsumivel :: String -> Int -> Int -> Int -> Int -> Consumivel
criaConsumivel nome_consumivel alteracao_vida alteracao_dano alteracao_velocidade_consumivel duracao = (Consumivel {
                                                                                               nome_consumivel = nome_consumivel
                                                                                               , alteracao_vida = alteracao_vida
                                                                                               , alteracao_dano = alteracao_dano
                                                                                               , alteracao_velocidade_consumivel = alteracao_velocidade_consumivel 
                                                                                               , duracao = duracao
                                                                                               })

criaEquipavel :: String -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> TipoEquipavel -> Equipavel
criaEquipavel nome_equipavel alteracao_vida_maxima alteracao_forca alteracao_inteligencia alteracao_sabedoria alteracao_destreza alteracao_constituicao alteracao_carisma alteracao_velocidade_equipavel tipo_equipavel = (Equipavel {
                                                                                               nome_equipavel = nome_equipavel
                                                                                               , alteracao_vida_maxima = alteracao_vida_maxima
                                                                                               , alteracao_forca = alteracao_forca
                                                                                               , alteracao_inteligencia = alteracao_inteligencia
                                                                                               , alteracao_sabedoria = alteracao_sabedoria
                                                                                               , alteracao_destreza = alteracao_destreza
                                                                                               , alteracao_constituicao = alteracao_constituicao
                                                                                               , alteracao_carisma = alteracao_carisma
                                                                                               , alteracao_velocidade_equipavel = alteracao_velocidade_equipavel
                                                                                               , tipo_equipavel = tipo_equipavel
                                                                                               })

listarConsumiveis :: [Consumivel] -> [String]
listarConsumiveis [] = [""]
listarConsumiveis (s:xs) = (show(nome_consumivel s) ++ "\n") : listarConsumiveis xs

exibirConsumivel :: Consumivel -> String
exibirConsumivel consumivel = "Nome: " ++ show(nome_consumivel consumivel) ++ "\n"
                              ++ "Alteração à vida: " ++ show(alteracao_vida consumivel) ++ "\n"
                              ++ "Alteração ao dano: " ++ show(alteracao_dano consumivel) ++ "\n"
                              ++ "Alteração à velocidade: " ++ show(alteracao_velocidade_consumivel consumivel) ++ "\n"
                              ++ "Duração: " ++ show(duracao consumivel)

listarEquipaveis :: [Equipavel] -> [String]
listarEquipaveis [] = [""]
listarEquipaveis (s:xs) =  (show(nome_equipavel s) ++ "\n") : listarEquipaveis xs
                          
exibirEquipavel :: Equipavel -> String
exibirEquipavel equipavel = "Nome: " ++ show(nome_equipavel equipavel) ++ "\n"
                           ++ "Alteração à vida máxima: " ++ show(alteracao_vida_maxima equipavel) ++ "\n"
                           ++ "Alteração à força: " ++ show(alteracao_forca equipavel) ++ "\n"
                           ++ "Alteração à inteligência: " ++ show(alteracao_inteligencia equipavel) ++ "\n"
                           ++ "Alteração à sabedoria: " ++ show(alteracao_sabedoria equipavel) ++ "\n"
                           ++ "Alteração à destreza: " ++ show(alteracao_destreza equipavel) ++ "\n"
                           ++ "Alteração à constituição: " ++ show(alteracao_constituicao equipavel) ++ "\n"
                           ++ "Alteração ao carisma: " ++ show(alteracao_carisma equipavel) ++ "\n"
                           ++ "Alteração à velocidade: " ++ show(alteracao_velocidade_equipavel equipavel) ++ "\n"
                           ++ "Equipavel em: " ++ show(tipo_equipavel equipavel)


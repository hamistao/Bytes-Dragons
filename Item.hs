module Item where

data Consumivel = Consumivel {
  nomeConsumivel :: String
  , alteracao_vida :: Int
  , alteracao_dano :: Int
  , alteracao_velocidade :: Int
  , duracao :: Int
  } deriving (Show, Eq, Read)

data Equipavel = Equipavel {
  nome_equipavel :: String
  , alteracao_vidaMaxima :: Int
  , alteracao_forca :: Int
  , alteracao_inteligencia :: Int
  , alteracao_sabedoria :: Int
  , alteracao_destreza :: Int
  , alteracao_constituicao :: Int
  , alteracao_carisma :: Int
  , alteracao_velocidade :: Int
  , tipoEquipavel :: TipoEquipavel
  } deriving (Show, Read, Eq)

data TipoEquipavel = Cabeca | Torso | Pernas | Maos deriving(Show, Read, Eq)
--'elem'

criaConsumivel :: String -> Int -> Int -> Int -> Int -> Consumivel
criaConsumivel nomeConsumivel alteracao_vida alteracao_resistencia alteracao_dano alteracao_velocidade duracao = (Consumivel {
                                                                                                                     nomeConsumivel = nomeConsumivel
                                                                                                                     , alteracao_vida = alteracao_vida
                                                                                                                     , alteracao_dano = alteracao_dano
                                                                                                                     , alteracao_velocidade = alteracao_velocidade 
                                                                                                                     , duracao = duracao
                                                                                                                     })

criaEquipavel :: String -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> TipoEquipavel -> Equipavel
criaEquipavel nome_equipavel alteracao_resistencia_equipavel alteracao_velocidade tipoEquipavel = (Equipavel {
                                                                                                      nome_equipavel = nome_equipavel
                                                                                                      , alteracao_vidaMaxima = alteracao_vidaMaxima
                                                                                                      , alteracao_forca = alteracao_forca
                                                                                                      , alteracao_inteligencia = alteracao_inteligencia
                                                                                                      , alteracao_sabedoria = alteracao_sabedoria
                                                                                                      , alteracao_destreza = alteracao_destreza
                                                                                                      , alteracao_constituicao = alteracao_constituicao
                                                                                                      , alteracao_carisma = alteracao_carisma
                                                                                                      , alteracao_velocidade = alteracao_velocidade
                                                                                                      , tipoEquipavel = tipoEquipavel
                                                                                                      })

listarConsumiveis :: [Consumivel] -> [String]
listarConsumiveis [] = [""]
listarConsumiveis (s:xs) = (show(nomeConsumivel s) ++ "\n") : listarConsumiveis xs

exibirConsumivel :: Consumivel -> String
exibirConsumivel consumivel = "Nome: " ++ show(nomeConsumivel consumivel) ++ "\n"
                              ++ "Alteração à vida: " ++ show(alteracao_vida consumivel) ++ "\n"
                              ++ "Alteração ao dano: " ++ show(alteracao_dano consumivel) ++ "\n"
                              ++ "Alteração à velocidade: " ++ show(alteracao_velocidade consumivel) ++ "\n"
                              ++ "Duração: " ++ show(duracao consumivel)

listarEquipaveis :: [Equipavel] -> [String]
listarEquipaveis [] = [""]
listarEquipaveis (s:xs) =  (show(nome_equipavel s) ++ "\n") : listarEquipaveis xs
                          
exibirEquipavel :: Equipavel -> String
exibirEquipavel equipavel = "Nome: " ++ show(nome_equipavel equipavel) ++ "\n"
                           ++ "Alteração à vida máxima: " ++ show(alteracao_resistencia_equipavel equipavel) ++ "\n"
                           ++ "Alteração à força: " ++ show(alteracao_resistencia_equipavel equipavel) ++ "\n"
                           ++ "Alteração à inteligência: " ++ show(alteracao_resistencia_equipavel equipavel) ++ "\n"
                           ++ "Alteração à sabedoria: " ++ show(alteracao_resistencia_equipavel equipavel) ++ "\n"
                           ++ "Alteração à destreza: " ++ show(alteracao_resistencia_equipavel equipavel) ++ "\n"
                           ++ "Alteração à constituição: " ++ show(alteracao_resistencia_equipavel equipavel) ++ "\n"
                           ++ "Alteração à carisma: " ++ show(alteracao_resistencia_equipavel equipavel) ++ "\n"
                           ++ "Alteração à velocidade: " ++ show(alteracao_velocidade equipavel) ++ "\n"
                           ++ "Equipavel em: " ++ show(tipoEquipavel equipavel)


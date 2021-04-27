module Item where

data Consumivel = Consumivel {
  nomeConsumivel :: String
  , alteracaoVida :: Int
  , alteracaoDano :: Int
  , alteracaoVelocidadeConsumivel :: Int
  , duracao :: Int
  } deriving (Show, Eq, Read)

data Equipavel = Equipavel {
  nomeEquipavel :: String
  , alteracaoVidaMaxima :: Int
  , alteracaoForca :: Int
  , alteracaoInteligencia :: Int
  , alteracaoSabedoria :: Int
  , alteracaoDestreza :: Int
  , alteracaoConstituicao :: Int
  , alteracaoCarisma :: Int
  , alteracaoVelocidadeEquipavel :: Int
  , tipoEquipavel :: TipoEquipavel
  } deriving (Show, Read, Eq)

data TipoEquipavel = Cabeca | Torso | Pernas | Maos deriving(Show, Read, Eq)
--'elem'

criaConsumivel :: String -> Int -> Int -> Int -> Int -> Consumivel
criaConsumivel nomeConsumivel alteracaoVida alteracaoDano alteracaoVelocidadeConsumivel duracao = (Consumivel {
                                                                                               nomeConsumivel = nomeConsumivel
                                                                                               , alteracaoVida = alteracaoVida
                                                                                               , alteracaoDano = alteracaoDano
                                                                                               , alteracaoVelocidadeConsumivel = alteracaoVelocidadeConsumivel 
                                                                                               , duracao = duracao
                                                                                               })

criaEquipavel :: String -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> TipoEquipavel -> Equipavel
criaEquipavel nomeEquipavel alteracaoVidaMaxima alteracaoForca alteracaoInteligencia alteracaoSabedoria alteracaoDestreza alteracaoConstituicao alteracaoCarisma alteracaoVelocidadeEquipavel tipoEquipavel = (Equipavel {
                                                                                               nomeEquipavel = nomeEquipavel
                                                                                               , alteracaoVidaMaxima = alteracaoVidaMaxima
                                                                                               , alteracaoForca = alteracaoForca
                                                                                               , alteracaoInteligencia = alteracaoInteligencia
                                                                                               , alteracaoSabedoria = alteracaoSabedoria
                                                                                               , alteracaoDestreza = alteracaoDestreza
                                                                                               , alteracaoConstituicao = alteracaoConstituicao
                                                                                               , alteracaoCarisma = alteracaoCarisma
                                                                                               , alteracaoVelocidadeEquipavel = alteracaoVelocidadeEquipavel
                                                                                               , tipoEquipavel = tipoEquipavel
                                                                                               })

listarConsumiveis :: [Consumivel] -> [String]
listarConsumiveis [] = [""]
listarConsumiveis (s:xs) = (show(nomeConsumivel s) ++ "\n") : listarConsumiveis xs

exibirConsumivel :: Consumivel -> String
exibirConsumivel consumivel = "Nome: " ++ show(nomeConsumivel consumivel) ++ "\n"
                              ++ "Alteração à vida: " ++ show(alteracaoVida consumivel) ++ "\n"
                              ++ "Alteração ao dano: " ++ show(alteracaoDano consumivel) ++ "\n"
                              ++ "Alteração à velocidade: " ++ show(alteracaoVelocidadeConsumivel consumivel) ++ "\n"
                              ++ "Duração: " ++ show(duracao consumivel)

listarEquipaveis :: [Equipavel] -> [String]
listarEquipaveis [] = [""]
listarEquipaveis (s:xs) =  (show(nomeEquipavel s) ++ "\n") : listarEquipaveis xs
                          
exibirEquipavel :: Equipavel -> String
exibirEquipavel equipavel = "Nome: " ++ show(nomeEquipavel equipavel) ++ "\n"
                           ++ "Alteração à vida máxima: " ++ show(alteracaoVidaMaxima equipavel) ++ "\n"
                           ++ "Alteração à força: " ++ show(alteracaoForca equipavel) ++ "\n"
                           ++ "Alteração à inteligência: " ++ show(alteracaoInteligencia equipavel) ++ "\n"
                           ++ "Alteração à sabedoria: " ++ show(alteracaoSabedoria equipavel) ++ "\n"
                           ++ "Alteração à destreza: " ++ show(alteracaoDestreza equipavel) ++ "\n"
                           ++ "Alteração à constituição: " ++ show(alteracaoConstituicao equipavel) ++ "\n"
                           ++ "Alteração ao carisma: " ++ show(alteracaoCarisma equipavel) ++ "\n"
                           ++ "Alteração à velocidade: " ++ show(alteracaoVelocidadeEquipavel equipavel) ++ "\n"
                           ++ "Equipavel em: " ++ show(tipoEquipavel equipavel)


module Item where

import Habilidade

data Consumivel = Consumivel {
  nomeConsumivel :: String
  , alteracaoVida :: Int
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
  , habilidades :: [Habilidade]
  } deriving (Show, Read, Eq)

data TipoEquipavel = Cabeca | Torso | Pernas | Maos | Arma deriving(Show, Read, Eq)
--'elem'

criaConsumivel :: String -> Int -> Int -> Int -> Consumivel
criaConsumivel nomeConsumivel alteracaoVida alteracaoVelocidadeConsumivel duracao = (Consumivel {
                                                                                               nomeConsumivel = nomeConsumivel
                                                                                               , alteracaoVida = alteracaoVida
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
                                                                                               , habilidades = []
                                                                                               })

  
atribuiHabilidadeEquipavel :: Equipavel -> Habilidade -> Equipavel
atribuiHabilidadeEquipavel equipavel habilidade = Equipavel {
  nomeEquipavel = nomeEquipavel equipavel
  , alteracaoVidaMaxima = alteracaoVidaMaxima equipavel
  , alteracaoForca = alteracaoForca equipavel
  , alteracaoInteligencia = alteracaoInteligencia equipavel
  , alteracaoSabedoria = alteracaoSabedoria equipavel
  , alteracaoDestreza = alteracaoDestreza equipavel
  , alteracaoConstituicao = alteracaoConstituicao equipavel
  , alteracaoCarisma = alteracaoCarisma equipavel
  , alteracaoVelocidadeEquipavel = alteracaoVelocidadeEquipavel equipavel
  , tipoEquipavel = tipoEquipavel equipavel
  , habilidades = habilidade : habilidades equipavel
  }


removeHabilidadeEquipavel :: Equipavel -> Habilidade -> Equipavel
removeHabilidadeEquipavel equipavel habilidade = Equipavel {
  nomeEquipavel = nomeEquipavel equipavel
  , alteracaoVidaMaxima = alteracaoVidaMaxima equipavel
  , alteracaoForca = alteracaoForca equipavel
  , alteracaoInteligencia = alteracaoInteligencia equipavel
  , alteracaoSabedoria = alteracaoSabedoria equipavel
  , alteracaoDestreza = alteracaoDestreza equipavel
  , alteracaoConstituicao = alteracaoConstituicao equipavel
  , alteracaoCarisma = alteracaoCarisma equipavel
  , alteracaoVelocidadeEquipavel = alteracaoVelocidadeEquipavel equipavel
  , tipoEquipavel = tipoEquipavel equipavel
  , habilidades = [ hab | hab <- habilidades equipavel, hab /= habilidade ]
  }


listarConsumiveis :: [Consumivel] -> [String]
listarConsumiveis [] = []
listarConsumiveis (s:xs) = (show(nomeConsumivel s) ++ "\n" ++ "Duracao: " ++ show(duracao s)) : listarConsumiveis xs

exibirConsumivel :: Consumivel -> String
exibirConsumivel consumivel = "Nome: " ++ show(nomeConsumivel consumivel) ++ "\n"
                              ++ "Alteracao a vida: " ++ show(alteracaoVida consumivel) ++ "\n"
                              ++ "Alteracao a velocidade: " ++ show(alteracaoVelocidadeConsumivel consumivel) ++ "\n"
                              ++ "Duracao: " ++ show(duracao consumivel)

listarEquipaveis :: [Equipavel] -> [String]
listarEquipaveis [] = []
listarEquipaveis (s:xs) =  (show(nomeEquipavel s) ++ "\n") : listarEquipaveis xs
                          
exibirEquipavel :: Equipavel -> String
exibirEquipavel equipavel = "Nome: " ++ show(nomeEquipavel equipavel) ++ "\n"
                           ++ "Alteracao a vida maxima: " ++ show(alteracaoVidaMaxima equipavel) ++ "\n"
                           ++ "Alteracao a forca: " ++ show(alteracaoForca equipavel) ++ "\n"
                           ++ "Alteracao a inteligencia: " ++ show(alteracaoInteligencia equipavel) ++ "\n"
                           ++ "Alteracao a sabedoria: " ++ show(alteracaoSabedoria equipavel) ++ "\n"
                           ++ "Alteracao a destreza: " ++ show(alteracaoDestreza equipavel) ++ "\n"
                           ++ "Alteracao a constituicão: " ++ show(alteracaoConstituicao equipavel) ++ "\n"
                           ++ "Alteracao ao carisma: " ++ show(alteracaoCarisma equipavel) ++ "\n"
                           ++ "Alteracao a velocidade: " ++ show(alteracaoVelocidadeEquipavel equipavel) ++ "\n"
                           ++ "Equipavel em: " ++ show(tipoEquipavel equipavel) ++ "\n"
                           ++ "Habilidades: " ++ unlines (listarHabilidades (habilidades equipavel))


module Item where

data Consumivel = Consumivel {
  nomeConsumivel :: String
  , ganho_vida :: Int
  , ganho_resistencia :: Int
  , ganho_dano :: Int
  , ganho_velocidade :: Int
  , duracao :: Int
  } deriving (Show, Eq, Read)

data Equipavel = Equipavel {
  nome_equipavel :: String
  , alteracao_resistencia_equipavel :: Int
  ,alteracao_vidaMaxima :: Int
  ,alteracao_forca :: Int
  ,alteracao_inteligencia :: Int
  ,alteracao_sabedoria :: Int
  ,alteracao_destreza :: Int
  ,alteracao_constituicao :: Int
  ,alteracao_carisma :: Int
  ,alteracao_resistencia :: Int
  , alteracao_velocidade :: Int
  , tipoEquipavel :: TipoEquipavel
  } deriving (Show, Read, Eq)

data TipoEquipavel = Cabeca | Torso | Pernas | Maos deriving(Show, Read, Eq)
--'elem'

criaConsumivel :: String -> Int -> Int -> Int -> Int -> Int -> Consumivel
criaConsumivel nomeConsumivel alteracao_vida alteracao_resistencia alteracao_dano alteracao_velocidade duracao = (Consumivel {
                                                                                              nomeConsumivel = nomeConsumivel                                                                                           
                                                                                            , ganho_vida = alteracao_vida
                                                                                            , ganho_resistencia = alteracao_resistencia 
                                                                                            , ganho_dano = alteracao_dano
                                                                                            , ganho_velocidade = alteracao_velocidade 
                                                                                            , duracao = duracao
                                                                                            })

criaEquipavel :: String -> Int -> Int -> TipoEquipavel -> Equipavel
criaEquipavel nome_equipavel alteracao_resistencia_equipavel alteracao_velocidade tipoEquipavel = (Equipavel {
                                                                                             nome_equipavel = nome_equipavel
                                                                                             , alteracao_resistencia_equipavel = alteracao_resistencia_equipavel 
                                                                                             , alteracao_velocidade = alteracao_velocidade
                                                                                             , tipoEquipavel = tipoEquipavel
                                                                                             })

listarConsumiveis :: [Consumivel] -> [String]
listarConsumiveis [] = [""]
listarConsumiveis (s:xs) = ("Nome: " ++ show(nomeConsumivel s) ++ "\n") : listarConsumiveis xs

listarConsumivel :: Consumivel -> String
listarConsumivel consumivel = "Nome: " ++ show(nomeConsumivel consumivel) ++ "\n"
                              ++ "Alteração à vida: " ++ show(ganho_vida consumivel) ++ "\n"
                              ++ "Alteração à resistência: " ++ show(ganho_resistencia consumivel) ++ "\n"
                              ++ "Alteração ao dano: " ++ show(ganho_dano consumivel) ++ "\n"
                              ++ "Duração: " ++ show(duracao consumivel)

listarEquipaveis :: [Equipavel] -> [String]
listarEquipaveis [] = [""]
listarEquipaveis (s:xs) =  ("Nome: " ++ show(nome_equipavel s) ++ "\n"): listarEquipaveis xs
                          
listarEquipavel :: Equipavel -> String
listarEquipavel equipavel = "Nome: " ++ show(nome_equipavel equipavel) ++ "\n"
                           ++ "Alteração à resistência: " ++ show(alteracao_resistencia_equipavel equipavel) ++ "\n"
                           ++ "Alteração à velocidade: " ++ show(alteracao_velocidade equipavel) ++ "\n"
                           ++ "Equipavel em: " ++ show(tipoEquipavel equipavel)


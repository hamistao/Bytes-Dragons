module Item where

data Consumivel = Consumivel {
  nomeConsumivel :: String
  , alteracao_vida :: Int
  , alteracao_resistencia :: Int
  , alteracao_dano :: Int
  , duracao :: Int
  } deriving (Show, Eq, Read)

data Equipavel = Equipavel {
  nome_equipavel :: String
  , alteracao_resistencia_equipavel :: Int
  , alteracao_velocidade :: Int
  , tipoEquipavel :: TipoEquipavel
  } deriving (Show, Read, Eq)

data TipoEquipavel = Cabeca | Torso | Pernas | Maos deriving(Show, Read, Eq)

criarConsumivel :: String -> Int -> Int -> Int -> Int -> Consumivel
criarConsumivel nomeConsumivel alteracao_vida alteracao_resistencia alteracao_dano duracao = (Consumivel {
                                                                                              nomeConsumivel = nomeConsumivel                                                                                           
                                                                                            , alteracao_vida = alteracao_vida
                                                                                            , alteracao_resistencia = alteracao_resistencia 
                                                                                            , alteracao_dano = alteracao_dano
                                                                                            , duracao = duracao
                                                                                            })

criarEquipavel :: String -> Int -> Int -> TipoEquipavel -> Equipavel
criarEquipavel nome_equipavel alteracao_resistencia_equipavel alteracao_velocidade tipoEquipavel = (Equipavel {
                                                                                             nome_equipavel = nome_equipavel
                                                                                             , alteracao_resistencia_equipavel = alteracao_resistencia_equipavel 
                                                                                             , alteracao_velocidade = alteracao_velocidade
                                                                                             , tipoEquipavel = tipoEquipavel
                                                                                             })

listarConsumiveis :: [Consumivel] -> String
listarConsumiveis [] = ""
listarConsumiveis (s:xs) = "---------------------------\n"
                           ++ "Nome: " ++ show(nomeConsumivel s) ++ "\n"
                           ++ listarConsumiveis xs

listarConsumivel :: Consumivel -> String
listarConsumivel consumivel = "Nome: " ++ show(nomeConsumivel consumivel) ++ "\n"
                              ++ "Alteração à vida: " ++ show(alteracao_vida consumivel) ++ "\n"
                              ++ "Alteração à resistência: " ++ show(alteracao_resistencia consumivel) ++ "\n"
                              ++ "Alteração ao dano: " ++ show(alteracao_dano consumivel) ++ "\n"
                              ++ "Duração: " ++ show(duracao consumivel)
listarEquipaveis :: [Equipavel] -> String
listarEquipaveis [] = ""
listarEquipaveis (s:xs) = "---------------------------\n"
                           ++ "Nome: " ++ show(nome_equipavel s) ++ "\n"
                           ++ listarEquipaveis xs

listarEquipavel :: Equipavel -> String
listarEquipavel equipavel = "Nome: " ++ show(nome_equipavel equipavel) ++ "\n"
                           ++ "Alteração à resistência: " ++ show(alteracao_resistencia_equipavel equipavel) ++ "\n"
                           ++ "Alteração à velocidade: " ++ show(alteracao_velocidade equipavel) ++ "\n"
                           ++ "Equipavel em: " ++ show(tipoEquipavel equipavel)

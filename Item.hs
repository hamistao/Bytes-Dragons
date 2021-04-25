module Item where

data Consumivel = Consumivel {
  nome :: String
  , alteracao_vida :: Int
  , alteracao_resistencia :: Float
  , alteracao_dano :: Float
  , duracao :: Int
  } deriving (Show, Eq)

data Equipavel = Equipavel {
  nome_equipavel :: String
  , alteracao_resistencia_equipavel :: Int
  , alteracao_velocidade :: Float
  } deriving (Show, Eq)


cadastrarConsumivel :: String -> Int -> Float -> Float -> Int -> Consumivel
cadastrarConsumivel nome alteracao_vida alteracao_resistencia alteracao_dano duracao = (Consumivel {
                                                                                           nome = nome
                                                                                           , alteracao_vida = alteracao_vida
                                                                                           , alteracao_resistencia = alteracao_resistencia 
                                                                                           , alteracao_dano = alteracao_dano
                                                                                           , duracao = duracao
                                                                                           })

cadastrarEquipavel :: String -> Int -> Float -> Equipavel
cadastrarEquipavel nome_equipavel alteracao_resistencia_equipavel alteracao_velocidade = (Equipavel {
                                                                                             nome_equipavel = nome_equipavel
                                                                                             , alteracao_resistencia_equipavel = alteracao_resistencia_equipavel 
                                                                                             , alteracao_velocidade = alteracao_velocidade
                                                                                             })

listarConsumiveis :: [Consumivel] -> String
listarConsumiveis [] = ""
listarConsumiveis (s:xs) = "---------------------------\n"
                           ++ "Nome: " ++ show(nome s) ++ "\n"
                           ++ "Alteração à vida: " ++ show(alteracao_vida s) ++ "\n"
                           ++ "Alteração à resistência: " ++ show(alteracao_resistencia s) ++ "\n"
                           ++ "Alteração ao dano: " ++ show(alteracao_dano s) ++ "\n"
                           ++ listarConsumiveis xs

listarEquipaveis :: [Equipavel] -> String
listarEquipaveis [] = ""
listarEquipaveis (s:xs) = "---------------------------\n"
                           ++ "Nome: " ++ show(nome_equipavel s) ++ "\n"
                           ++ "Alteração à resistência: " ++ show(alteracao_resistencia_equipavel s) ++ "\n"
                           ++ "Alteração à velocidade: " ++ show(alteracao_velocidade s) ++ "\n"
                           ++ listarEquipaveis xs

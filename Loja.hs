module Loja where
import Item
import Personagem
import Data.Tuple

data Loja = Loja {
    nomeLoja :: String,
    lojaEquipaveis :: [(Equipavel, Int)],
    lojaConsumiveis :: [(Consumivel, Int)]
} deriving (Show, Read, Eq)

cadastraLoja :: String -> Loja
cadastraLoja nome = Loja{nomeLoja = nome
                        ,lojaEquipaveis = []
                        ,lojaConsumiveis = []
                    }

listaLojas :: [Loja] -> String
listaLojas [] = ""
listaLojas (s:xs) = "---------------------------\n"
                           ++ "Nome: " ++ nomeLoja s ++ "\n"
                           ++ listaLojas xs

exibeLoja :: [Loja] -> String -> String
exibeLoja [] _ = "Loja inexistente"
exibeLoja (s:xs) nome
    |nome == nomeLoja s = "Nome: " ++ nomeLoja s ++ "\n"
                        ++ "Itens a venda:\n"
                        ++ "Equipáveis:\n"
                        ++ catalogoEquipavel (lojaEquipaveis s)
                        ++ "Consumíveis:\n"
                        ++ catalogoConsumivel (lojaConsumiveis s)
    | otherwise = exibeLoja xs nome

catalogoEquipavel :: [(Equipavel, Int)] -> String
catalogoEquipavel [] = ""
catalogoEquipavel (s:xs) = "Nome: " ++ nomeEquipavel (fst(s)) ++ "\n"
                        ++ "Preco: " ++ show(snd(s)) ++ "\n"
                        ++ "-------------------------------\n"
                        ++ catalogoEquipavel xs

catalogoConsumivel :: [(Consumivel, Int)] -> String
catalogoConsumivel [] = ""
catalogoConsumivel (s:xs) = "Nome: " ++ nomeConsumivel (fst(s)) ++ "\n"
                        ++ "Preco: " ++ show(snd(s)) ++ "\n"
                        ++ "-------------------------------\n"
                        ++ catalogoConsumivel xs

exibeEquipavelLoja :: [(Equipavel, Int)] -> String -> String
exibeEquipavelLoja [] _ = "não vende esse item nessa loja"
exibeEquipavelLoja (s:xs) nome
    |nome == nomeEquipavel (fst(s)) = (exibirEquipavel (fst(s))) ++ "\n"
                                    ++ "Preço: " ++ (show(snd(s)))
    |otherwise = exibeEquipavelLoja xs nome

exibeConsumivelLoja :: [(Consumivel, Int)] -> String -> String
exibeConsumivelLoja [] _ = "não vende esse item nessa loja"
exibeConsumivelLoja (s:xs) nome
    |nome == nomeConsumivel (fst(s)) = (exibirConsumivel (fst(s))) ++ "\n"
                                    ++ "Preço: " ++ (show(snd(s)))
    |otherwise = exibeConsumivelLoja xs nome

adicionaEquipavel :: Equipavel -> Loja -> Int -> Loja
adicionaEquipavel equipavel loja preco = Loja{nomeLoja = nomeLoja loja
                                            ,lojaEquipaveis = lojaEquipaveis loja ++ [(equipavel, preco)]
                                            ,lojaConsumiveis = lojaConsumiveis loja
                                        }

adicionarConsmivel :: Consumivel -> Loja -> Int -> Loja
adicionarConsmivel consumivel loja preco = Loja{nomeLoja = nomeLoja loja
                                            ,lojaEquipaveis = lojaEquipaveis loja
                                            ,lojaConsumiveis = lojaConsumiveis loja ++ [(consumivel, preco)]
                                        }

compraEquipavel :: Personagem -> Equipavel -> Int -> Loja -> (Personagem, Loja)
compraEquipavel personagem equipavel preco loja = 
    (Personagem{nome_personagem = nome_personagem personagemEquipado
        ,raca = raca personagemEquipado
        ,classe = classe personagemEquipado
        ,vida = vida personagemEquipado
        ,vidaMaxima = vidaMaxima personagemEquipado
        ,forca = forca personagemEquipado
        ,inteligencia = inteligencia personagemEquipado
        ,sabedoria = sabedoria personagemEquipado
        ,destreza = destreza personagemEquipado
        ,constituicao = constituicao personagemEquipado
        ,carisma = carisma personagemEquipado
        ,velocidade = velocidade personagemEquipado
        ,ouro = ouro personagemEquipado - preco
        ,xp = xp personagemEquipado
        ,xpUp = xpUp personagemEquipado
        ,nivel = nivel personagemEquipado
        ,equipaveis = equipaveis personagemEquipado
        ,consumiveis = consumiveis personagemEquipado
        ,habilidades_personagem = habilidades_personagem personagemEquipado
        ,imunidades = imunidades personagemEquipado
        },
        Loja{nomeLoja = nomeLoja loja
        ,lojaEquipaveis = [x | x <- lojaEquipaveis loja, equipavel /= fst(x)]
        ,lojaConsumiveis = lojaConsumiveis loja
        })
    where personagemEquipado = equiparItem equipavel personagem

getPrecoEquipavel :: [(Equipavel, Int)] -> Equipavel -> Maybe(Int)
temEquipavel [] equipavel = Nothing
temEquipavel (s:xs) equipavel = if(nomeEquipavel equipavel == nomeEquipavel fst(s)) then snd(s)
                                    else temEquipavel xs equipavel

compraConsumivel :: Personagem -> Consumivel -> Int -> Loja -> (Personagem, Loja)
compraConsumivel personagem consumivel preco loja = (Personagem{nome_personagem = nome_personagem personagem
                                                            ,raca = raca personagem
                                                            ,classe = classe personagem
                                                            ,vida = vida personagem
                                                            ,vidaMaxima = vidaMaxima personagem
                                                            ,forca = forca personagem
                                                            ,inteligencia = inteligencia personagem
                                                            ,sabedoria = sabedoria personagem
                                                            ,destreza = destreza personagem
                                                            ,constituicao = constituicao personagem
                                                            ,carisma = carisma personagem
                                                            ,velocidade = velocidade personagem
                                                            ,ouro = ouro personagem - preco
                                                            ,xp = xp personagem
                                                            ,xpUp = xpUp personagem
                                                            ,nivel = nivel personagem
                                                            ,equipaveis = equipaveis personagem
                                                            ,consumiveis = consumiveis personagem ++ [consumivel]
                                                            ,habilidades_personagem = habilidades_personagem personagem
                                                            ,imunidades = imunidades personagem
                                                        },
                                                    Loja{nomeLoja = nomeLoja loja
                                                        ,lojaEquipaveis = lojaEquipaveis loja
                                                        ,lojaConsumiveis = [x | x <- lojaConsumiveis loja, consumivel /= fst(x)]
                                                    })

getPrecoConsumivel :: [Consumivel, Int] -> Consumivel -> Maybe(Consumivel)
getPrecoConsumivel [] consumivel = Nothing
getPrecoConsumivel (s:xs) consumivel = if(nomeConsumivel consumivel == nomeConsumivel fst(s)) then snd(s)
                                    else temConsumivel xs consumivel


vendeEquipavel :: Personagem -> Equipavel -> Int -> Personagem
vendeEquipavel personagem equipavel preco = 
    (Personagem{nome_personagem = nome_personagem personagemDesequipado
        ,raca = raca personagemDesequipado
        ,classe = classe personagemDesequipado
        ,vida = vida personagemDesequipado
        ,vidaMaxima = vidaMaxima personagemDesequipado
        ,forca = forca personagemDesequipado
        ,inteligencia = inteligencia personagemDesequipado
        ,sabedoria = sabedoria personagemDesequipado
        ,destreza = destreza personagemDesequipado
        ,constituicao = constituicao personagemDesequipado
        ,carisma = carisma personagemDesequipado
        ,velocidade = velocidade personagemDesequipado
        ,ouro = ouro personagemDesequipado + preco
        ,xp = xp personagemDesequipado
        ,xpUp = xpUp personagemDesequipado
        ,nivel = nivel personagemDesequipado
        ,equipaveis = equipaveis personagemDesequipado
        ,consumiveis = consumiveis personagemDesequipado
        ,habilidades_personagem = habilidades_personagem personagemDesequipado
        ,imunidades = imunidades personagemDesequipado
    })
    where personagemDesequipado = desequiparItem equipavel personagem

vendeConsumivel :: Personagem -> Consumivel -> Int -> Personagem
vendeConsumivel personagem consumivel preco = Personagem{nome_personagem = nome_personagem personagem
                                                        ,raca = raca personagem
                                                        ,classe = classe personagem
                                                        ,vida = vida personagem
                                                        ,vidaMaxima = vidaMaxima personagem
                                                        ,forca = forca personagem
                                                        ,inteligencia = inteligencia personagem
                                                        ,sabedoria = sabedoria personagem
                                                        ,destreza = destreza personagem
                                                        ,constituicao = constituicao personagem
                                                        ,carisma = carisma personagem
                                                        ,velocidade = velocidade personagem
                                                        ,ouro = ouro personagem + preco
                                                        ,xp = xp personagem
                                                        ,xpUp = xpUp personagem
                                                        ,nivel = nivel personagem
                                                        ,equipaveis = equipaveis personagem
                                                        ,consumiveis = [x | x <- consumiveis personagem, x /= consumivel]
                                                        ,habilidades_personagem = habilidades_personagem personagem
                                                        ,imunidades = imunidades personagem
                                                    }
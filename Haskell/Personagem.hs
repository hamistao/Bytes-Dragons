module Personagem where
-- import System.Random
import Classe
import Raca
import Item
import Habilidade as Habil
import Data.Maybe

data Personagem = Personagem {
    nome_personagem :: String
    ,raca :: Raca
    ,classe :: Classe
    ,vida :: Int
    ,vidaMaxima :: Int
    ,forca :: Int
    ,inteligencia :: Int
    ,sabedoria :: Int
    ,destreza :: Int
    ,constituicao :: Int
    ,carisma :: Int
    ,velocidade :: Int
    ,ouro :: Int
    ,xp :: Int
    ,xpUp :: Int
    ,nivel :: Int
    ,equipaveis :: [Equipavel]
    ,consumiveis :: [Consumivel]
    ,habilidades_personagem :: [Habilidade]
    ,imunidades :: [TipoDano]
} deriving(Show, Eq, Read)

cadastraPersonagem :: String -> Classe -> Raca -> Personagem
cadastraPersonagem nome_personagem classe raca = (Personagem {
                                                            nome_personagem = nome_personagem
                                                            ,raca = raca
                                                            ,classe = classe
                                                            ,vidaMaxima = vidaMaxima_classe classe + mod_vidaMaxima raca
                                                            ,vida = vidaMaxima_classe classe + mod_vidaMaxima raca
                                                            ,forca = forca_classe classe + mod_forca raca
                                                            ,inteligencia = inteligencia_classe classe + mod_inteligencia raca
                                                            ,sabedoria = sabedoria_classe classe + mod_sabedoria raca
                                                            ,destreza = destreza_classe classe+ mod_destreza raca
                                                            ,constituicao = constituicao_classe classe + mod_constituicao raca
                                                            ,carisma = carisma_classe classe + mod_carisma raca
                                                            ,velocidade = destreza_classe classe + mod_destreza raca - (constituicao_classe classe + mod_constituicao raca)
                                                            ,ouro = 0
                                                            ,xp = 0
                                                            ,xpUp = 1000
                                                            ,nivel = 1
                                                            ,equipaveis = []
                                                            ,consumiveis = []
                                                            ,habilidades_personagem = []
                                                            ,imunidades = []
                                                })


cadastraHabilidade :: String -> Int -> Int -> Atributo -> Int -> TipoDano -> Habilidade
cadastraHabilidade nome impacto_vida impacto_velocidade atributo_relacionado pontosParaAcerto tipoDeDano = (Habilidade {
                                                                                                                            nome_habilidade = nome
                                                                                                                            ,impacto_vida = impacto_vida
                                                                                                                            ,impacto_velocidade = impacto_velocidade
                                                                                                                            ,atributo_relacionado = atributo_relacionado
                                                                                                                            ,pontosParaAcerto = pontosParaAcerto
                                                                                                                            ,tipoDeDano = tipoDeDano
                                                                                                                        })

temHabilidade :: Personagem -> Habilidade -> Bool
temHabilidade personagem habilidade = (personagemTemHabilidade personagem habilidade) || (itemTemHabilidade (equipaveis personagem) habilidade) 

personagemTemHabilidade :: Personagem -> Habilidade -> Bool
personagemTemHabilidade personagem habilidade = habilidade `elem` (habilidades_personagem personagem)

itemTemHabilidade :: [Equipavel] -> Habilidade -> Bool
itemTemHabilidade [] _ = False
itemTemHabilidade (x:xs) habilidade = if(habilidade `elem` (habilidades x)) then True
                                      else itemTemHabilidade xs habilidade  


listarPersonagens :: [Personagem] -> String
listarPersonagens [] = ""
listarPersonagens (s:xs) = "---------------------------\n"
                           ++ "Nome: " ++ show(nome_personagem s) ++ "\n"
                           ++ "Raca: " ++ show(raca s) ++ "\n"
                           ++ "Classe: " ++ show(classe s) ++ "\n"
                           ++ listarPersonagens xs


exibePersonagem :: [Personagem] -> String -> String
exibePersonagem [] nome = "Personagem inexistente"
exibePersonagem (s:xs) nome
    | nome == (nome_personagem s) = "Nome: " ++ show(nome_personagem s) ++ "\n"
                        ++ "Raca: " ++ show(raca s) ++ "\n"
                        ++ "Classe: " ++ show(classe s) ++ "\n"
                        ++ "Vida: " ++ show(vida s) ++ "/" ++ show(vidaMaxima s) ++ "\n"
                        ++ "Forca: " ++ show(forca s) ++ "\n"
                        ++ "Inteligencia: " ++ show(inteligencia s) ++ "\n"
                        ++ "Sabedoria: " ++ show(sabedoria s) ++ "\n"
                        ++ "Destreza: " ++ show(destreza s) ++ "\n"
                        ++ "Constituicao: " ++ show(constituicao s) ++ "\n"
                        ++ "Carisma: " ++ show(carisma s) ++ "\n"
                        ++ "Velocidade: " ++ show(velocidade s) ++ "\n"
                        ++ "Ouro: " ++ show(ouro s) ++ "\n"
                        ++ "XP: " ++ show(xp s) ++ "/" ++ show(xpUp s) ++ "\n"
                        ++ "Nivel: " ++ show(nivel s) ++ "\n"
                        ++ "Itens:\n"
                        ++ "Equipaveis:\n"
                        ++ (unlines (listarEquipaveis (equipaveis s)))
                        ++ "Consumiveis:\n"
                        ++ (unlines (listarConsumiveis (consumiveis s)))
                        ++ "Habilidades:\n"
                        ++ (unlines (listarHabilidades (habilidades_personagem s)))
                        ++ "Resistencias:\n"
                        ++ (unlines (listarImunidades (imunidades s)))
    | otherwise = exibePersonagem xs nome


exibePersonagemString :: Personagem -> String
exibePersonagemString personagem = "Nome: " ++ show(nome_personagem personagem) ++ "\n"
                        ++ "Raca: " ++ show(raca personagem) ++ "\n"
                        ++ "Classe: " ++ show(classe personagem) ++ "\n"
                        ++ "Vida: " ++ show(vida personagem) ++ "/" ++ show(vidaMaxima personagem) ++ "\n"
                        ++ "Forca: " ++ show(forca personagem) ++ "\n"
                        ++ "Inteligencia: " ++ show(inteligencia personagem) ++ "\n"
                        ++ "Sabedoria: " ++ show(sabedoria personagem) ++ "\n"
                        ++ "Destreza: " ++ show(destreza personagem) ++ "\n"
                        ++ "Constituicao: " ++ show(constituicao personagem) ++ "\n"
                        ++ "Carisma: " ++ show(carisma personagem) ++ "\n"
                        ++ "Velocidade: " ++ show(velocidade personagem) ++ "\n"
                        ++ "Ouro: " ++ show(ouro personagem) ++ "\n"
                        ++ "XP: " ++ show(xp personagem) ++ "/" ++ show(xpUp personagem) ++ "\n"
                        ++ "Nível: " ++ show(nivel personagem) ++ "\n"
                        ++ "Itens:\n"
                        ++ "Equipaveis:\n"
                        ++ (unlines (listarEquipaveis (equipaveis personagem)))
                        ++ "Consumiveis:\n"
                        ++ (unlines (listarConsumiveis (consumiveis personagem)))
                        ++ "Habilidades:\n"
                        ++ (unlines (listarHabilidades (habilidades_personagem personagem)))
                        ++ "Resistencias:\n"
                        ++ (unlines (listarImunidades (imunidades personagem)))

usaHabilidade :: Habilidade -> Personagem -> Personagem
usaHabilidade habilidade personagem =
    Personagem{nome_personagem = nome_personagem personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = cura (vida personagem) (vidaMaxima personagem) (impacto_vida habilidade)
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,velocidade = velocidade personagem + impacto_velocidade habilidade
        ,ouro = ouro personagem
        ,xp = xp personagem
        ,xpUp = xpUp personagem
        ,nivel = nivel personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem
        ,habilidades_personagem = habilidades_personagem personagem
        ,imunidades = imunidades personagem
    }

equiparItem :: Equipavel -> Personagem -> Personagem
equiparItem equipavel personagem = if (isNothing (isEquipavel (equipaveis personagem) (tipoEquipavel equipavel))) then
                                        Personagem{nome_personagem = nome_personagem personagem
                                        ,raca = raca personagem
                                        ,classe = classe personagem
                                        ,vida = vida personagem
                                        ,vidaMaxima = vidaMaxima personagem + alteracaoVidaMaxima equipavel
                                        ,forca = forca personagem + alteracaoForca equipavel
                                        ,inteligencia = inteligencia personagem + alteracaoInteligencia equipavel
                                        ,sabedoria = sabedoria personagem + alteracaoSabedoria equipavel
                                        ,destreza = destreza personagem + alteracaoDestreza equipavel
                                        ,constituicao = constituicao personagem + alteracaoConstituicao equipavel
                                        ,carisma = carisma personagem + alteracaoCarisma equipavel
                                        ,velocidade = velocidade personagem + alteracaoVelocidadeEquipavel equipavel
                                        ,ouro = ouro personagem
                                        ,xp = xp personagem
                                        ,xpUp = xpUp personagem
                                        ,nivel = nivel personagem
                                        ,equipaveis = equipaveis personagem ++ [equipavel]
                                        ,consumiveis = consumiveis personagem
                                        ,habilidades_personagem = habilidades_personagem personagem ++ Item.habilidades equipavel
                                        ,imunidades = imunidades personagem
                                    }
                                    else equiparItem equipavel (desequiparItem equipavel personagem)

isEquipavel :: [Equipavel] -> TipoEquipavel -> Maybe(Equipavel)
isEquipavel [] _ = Nothing
isEquipavel (x:xs) tipo = if(tipoEquipavel x == tipo) then (Just x) 
                          else isEquipavel xs tipo

desequiparItem :: Equipavel -> Personagem -> Personagem
desequiparItem equipavel personagem = Personagem{ nome_personagem = nome_personagem personagem
                                                ,raca = raca personagem
                                                ,classe = classe personagem
                                                ,vida = vida personagem
                                                ,vidaMaxima = vidaMaxima personagem - alteracaoVidaMaxima equipavel
                                                ,forca = forca personagem - alteracaoForca equipavel
                                                ,inteligencia = inteligencia personagem - alteracaoInteligencia equipavel
                                                ,sabedoria = sabedoria personagem - alteracaoSabedoria equipavel
                                                ,destreza = destreza personagem - alteracaoDestreza equipavel
                                                ,constituicao = constituicao personagem - alteracaoConstituicao equipavel
                                                ,carisma = carisma personagem - alteracaoCarisma equipavel
                                                ,velocidade = velocidade personagem - alteracaoVelocidadeEquipavel equipavel
                                                ,ouro = ouro personagem
                                                ,xp = xp personagem
                                                ,xpUp = xpUp personagem
                                                ,nivel = nivel personagem
                                                ,equipaveis = [x | x <- equipaveis personagem, tipoEquipavel equipavel /= tipoEquipavel x]
                                                ,consumiveis = consumiveis personagem
                                                ,habilidades_personagem = [ x | x <- habilidades_personagem personagem, x `notElem` (Item.habilidades equipavel)]
                                                ,imunidades = imunidades personagem
                                            }

alocaHabilidade :: Habilidade -> Personagem -> Personagem
alocaHabilidade habilidade personagem = 
    
    Personagem{nome_personagem = nome_personagem personagem
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
        ,ouro = ouro personagem
        ,xp = xp personagem
        ,xpUp = xpUp personagem
        ,nivel = nivel personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem
        ,habilidades_personagem = habilidades_personagem personagem ++ [habilidade]
        ,imunidades = imunidades personagem
    }

desalocaHabilidade :: Habilidade -> Personagem -> Personagem
desalocaHabilidade habilidade personagem =
    
    Personagem{nome_personagem = nome_personagem personagem
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
        ,ouro = ouro personagem
        ,xp = xp personagem
        ,xpUp = xpUp personagem
        ,nivel = nivel personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem
        ,habilidades_personagem = [hab | hab <- habilidades_personagem personagem, hab /= habilidade]
        ,imunidades = imunidades personagem
    }

guardarConsumivel :: Consumivel -> Personagem -> Personagem
guardarConsumivel item personagem =
    Personagem{nome_personagem = nome_personagem personagem
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
        ,ouro = ouro personagem
        ,xp = xp personagem
        ,xpUp = xpUp personagem
        ,nivel = nivel personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem ++ [item]
        ,habilidades_personagem = habilidades_personagem personagem
        ,imunidades = imunidades personagem
    }


removeConsumivel :: Consumivel -> Personagem -> [Consumivel]
removeConsumivel consumivel personagem
    | (duracao consumivel) - 1 /= 0 = [item | item <- consumiveis personagem, item /= consumivel] ++ [reduzDuracao consumivel]
    | otherwise = [item | item <- consumiveis personagem, item /= consumivel]


reduzDuracao :: Consumivel -> Consumivel
reduzDuracao consumivel =
    Consumivel {nomeConsumivel = nomeConsumivel consumivel
        , alteracaoVida = alteracaoVida consumivel
        , alteracaoVelocidadeConsumivel = alteracaoVelocidadeConsumivel consumivel
        , duracao = duracao consumivel - 1
    }


desequiparConsumivel :: Consumivel -> Personagem -> Personagem
desequiparConsumivel consumivel personagem = 
    Personagem{nome_personagem = nome_personagem personagem
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
        ,ouro = ouro personagem
        ,xp = xp personagem
        ,xpUp = xpUp personagem
        ,nivel = nivel personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = [item | item <- consumiveis personagem, item /= consumivel]
        ,habilidades_personagem = habilidades_personagem personagem
        ,imunidades = imunidades personagem
    }

aplicarItemConsumivel ::Consumivel -> Personagem -> Personagem
aplicarItemConsumivel consumivel personagem =  
    Personagem{nome_personagem = nome_personagem personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = cura (vida personagem) (vidaMaxima personagem) (alteracaoVida consumivel)
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,velocidade = velocidade personagem + alteracaoVelocidadeConsumivel consumivel
        ,ouro = ouro personagem
        ,xp = xp personagem
        ,xpUp = xpUp personagem
        ,nivel = nivel personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem
        ,habilidades_personagem = habilidades_personagem personagem
        ,imunidades = imunidades personagem
    }


usarItemConsumivel :: Consumivel -> Personagem -> Personagem
usarItemConsumivel consumivel personagem =
    Personagem{nome_personagem = nome_personagem personagem
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
        ,ouro = ouro personagem
        ,xp = xp personagem
        ,xpUp = xpUp personagem
        ,nivel = nivel personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = removeConsumivel consumivel personagem
        ,habilidades_personagem = habilidades_personagem personagem
        ,imunidades = imunidades personagem
    }

cura :: Int -> Int -> Int -> Int
cura atual maximo alteracao | atual + alteracao >= maximo = maximo
                            | otherwise = atual + alteracao

                            
listarImunidades :: [TipoDano] -> [String]
listarImunidades [] = []
listarImunidades (s:sx) = (show(s) ++ "\n"): listarImunidades sx

adicionarImunidade :: Personagem -> TipoDano -> Personagem
adicionarImunidade personagem imunidade = Personagem{nome_personagem = nome_personagem personagem
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
                                                    ,ouro = ouro personagem
                                                    ,xp = xp personagem
                                                    ,xpUp = xpUp personagem
                                                    ,nivel = nivel personagem
                                                    ,equipaveis = equipaveis personagem
                                                    ,consumiveis = consumiveis personagem
                                                    ,habilidades_personagem = habilidades_personagem personagem
                                                    ,imunidades = imunidades personagem ++ [imunidade] 
                                                    }   

removerImunidade :: Personagem -> TipoDano -> Personagem
removerImunidade personagem imunidade = Personagem{nome_personagem = nome_personagem personagem
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
                                                    ,ouro = ouro personagem
                                                    ,xp = xp personagem
                                                    ,xpUp = xpUp personagem
                                                    ,nivel = nivel personagem
                                                    ,equipaveis = equipaveis personagem
                                                    ,consumiveis = consumiveis personagem
                                                    ,habilidades_personagem = habilidades_personagem personagem
                                                    ,imunidades = [x | x <- (imunidades personagem), imunidade /= x]
                                                    }

alteraGold :: Personagem -> Int -> Personagem
alteraGold personagem valor = Personagem{nome_personagem = nome_personagem personagem
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
                                        ,ouro = (ouro personagem) + valor 
                                        ,xp = xp personagem
                                        ,xpUp = xpUp personagem
                                        ,nivel = nivel personagem
                                        ,equipaveis = equipaveis personagem
                                        ,consumiveis = consumiveis personagem
                                        ,habilidades_personagem = habilidades_personagem personagem
                                        ,imunidades = imunidades personagem
                                        }


atualizaPersonagem :: [Personagem] -> Personagem -> [Personagem]
atualizaPersonagem lista personagem = [personagem] ++ [ x | x <- lista, nome_personagem x /= nome_personagem personagem]
       

temConsumivel :: Personagem -> Consumivel -> Bool
temConsumivel personagem consumivel
  | consumivel `elem` consumiveis personagem = True
  | otherwise                                = False


alteraVida :: Personagem -> Int -> Personagem
alteraVida personagem valor = Personagem{nome_personagem = nome_personagem personagem
                                        ,raca = raca personagem
                                        ,classe = classe personagem
                                        ,vida = vida personagem + valor
                                        ,vidaMaxima = vidaMaxima personagem
                                        ,forca = forca personagem
                                        ,inteligencia = inteligencia personagem
                                        ,sabedoria = sabedoria personagem
                                        ,destreza = destreza personagem
                                        ,constituicao = constituicao personagem
                                        ,carisma = carisma personagem
                                        ,velocidade = velocidade personagem
                                        ,ouro = ouro personagem
                                        ,xp = xp personagem
                                        ,xpUp = xpUp personagem
                                        ,nivel = nivel personagem
                                        ,equipaveis = equipaveis personagem
                                        ,consumiveis = consumiveis personagem
                                        ,habilidades_personagem = habilidades_personagem personagem
                                        ,imunidades = imunidades personagem
                                        }


regeneraPersonagem :: Personagem -> Personagem
regeneraPersonagem personagem = Personagem{nome_personagem = nome_personagem personagem
                                        ,raca = raca personagem
                                        ,classe = classe personagem
                                        ,vida = vidaMaxima personagem
                                        ,vidaMaxima = vidaMaxima personagem
                                        ,forca = forca personagem
                                        ,inteligencia = inteligencia personagem
                                        ,sabedoria = sabedoria personagem
                                        ,destreza = destreza personagem
                                        ,constituicao = constituicao personagem
                                        ,carisma = carisma personagem
                                        ,velocidade = velocidade personagem
                                        ,ouro = ouro personagem
                                        ,xp = xp personagem
                                        ,xpUp = xpUp personagem
                                        ,nivel = nivel personagem
                                        ,equipaveis = equipaveis personagem
                                        ,consumiveis = consumiveis personagem
                                        ,habilidades_personagem = habilidades_personagem personagem
                                        ,imunidades = imunidades personagem
                                        }

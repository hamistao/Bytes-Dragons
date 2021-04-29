module Personagem where
-- import System.Random
import Classe
import Raca
import Item
import Habilidade
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
    ,habilidades :: [Habilidade]
    ,imunidade :: [TipoDano]
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
                                                            ,habilidades = []
                                                            ,imunidades = []
                                                })


cadastraHabilidade :: String -> Int -> Int -> Int -> Atributo -> Int -> String -> Habilidade
cadastraHabilidade nome impacto_vida impacto_dano impacto_velocidade atributo_relacionado pontosParaAcerto tipoDeDano = (Habilidade {
                                                                                                                            nome_habilidade = nome
                                                                                                                            ,impacto_vida = impacto_vida
                                                                                                                            ,impacto_dano = impacto_dano
                                                                                                                            ,impacto_velocidade = impacto_velocidade
                                                                                                                            ,atributo_relacionado = atributo_relacionado
                                                                                                                            ,pontosParaAcerto = pontosParaAcerto
                                                                                                                            ,tipoDeDano = tipoDeDano
                                                                                                                        })

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
                        ++ "Nível: " ++ show(nivel s) ++ "\n"
                        ++ "Itens:\n"
                        ++ "Equipaveis:\n"
                        ++ (unlines (listarEquipaveis (equipaveis s)))
                        ++ "Consumiveis:\n"
                        ++ (unlines (listarConsumiveis (consumiveis s)))
                        ++ "Habilidades:\n"
                        ++ (unlines (listarHabilidades (habilidades s)))
                        ++ "Imunidade:\n"
                        ++ (unlines (listarImunidades (imunidades s)))
                        
    | otherwise = exibePersonagem xs nome


selecionaAtributoRelacionado :: String -> Personagem -> Int
selecionaAtributoRelacionado atributo personagem
    | atributo == "forca" = forca personagem
    | atributo == "inteligencia" = inteligencia personagem
    | atributo == "sabedoria" = sabedoria personagem
    | atributo == "destreza" = destreza personagem
    | atributo == "constituicao" = constituicao personagem
    | atributo == "carisma" = carisma personagem
    | otherwise = 0

usaHabilidade :: Habilidade -> Personagem -> Personagem
usaHabilidade habilidade personagem =
    Personagem{nome_personagem = nome_personagem personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem + impacto_vida habilidade
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
        ,habilidades = habilidades personagem
        ,imunidades = imunidades personagem
    }

isEquipavel :: [Equipavel] -> TipoEquipavel -> Maybe(Equipavel)
isEquipavel [] _ = Nothing
isEquipavel (x:xs) tipo = if(tipoEquipavel x == tipo) then (Just x) 
                          else isEquipavel xs tipo

usarItemEquipavel :: Equipavel -> Personagem -> Personagem
usarItemEquipavel equipavel personagem = equiparItem equipavel (desequiparItem equipavel personagem)

desequiparItem :: Equipavel -> Personagem -> Personagem
desequiparItem equipavel personagem = if (isNothing (isEquipavel (equipaveis personagem) (tipoEquipavel equipavel))) then personagem
                                      else  Personagem{ nome_personagem = nome_personagem personagem
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
                                                        ,equipaveis = removerEquipavel (equipaveis personagem) equipavel
                                                        ,consumiveis = consumiveis personagem
                                                        ,habilidades = [ x | x <- habilidades personagem, x `notElem` (habilidades equipavel)]
                                                        ,imunidades = imunidades personagem
                                                    }

removerEquipavel :: [Equipavel] -> Equipavel -> [Equipavel]
removerEquipavel equipaveis equipavel = [x | x <- equipaveis, tipoEquipavel equipavel /= tipoEquipavel x]

equiparItem :: Equipavel -> Personagem -> Personagem
equiparItem equipavel personagem = 
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
        ,consumiveis = consumiveis personagem ++ habilidades equipavel
        ,habilidades = habilidades personagem
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
        ,habilidades = habilidades personagem ++ [habilidade]
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
        ,habilidades = [hab | hab <- habilidades personagem, hab /= habilidade]
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
        ,habilidades = habilidades personagem
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
        , alteracaoDano = alteracaoDano consumivel
        , alteracaoVelocidadeConsumivel = alteracaoVelocidadeConsumivel consumivel
        , duracao = duracao consumivel - 1
    }

usarItemConsumivel :: Consumivel -> Personagem -> Personagem
usarItemConsumivel consumivel personagem =
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
        ,consumiveis = removeConsumivel consumivel personagem
        ,habilidades = habilidades personagem
        ,imunidades = imunidades personagem
    }

cura :: Int -> Int -> Int -> Int
cura atual maximo alteracao | atual + alteracao >= maximo = maximo
                            | otherwise = atual + alteracao
listarImunidades :: [TipoDano] -> [String]
listarImunidades [] = []
listarImunidades (s:sx) = (show(s) ++ "\n"): listarImunidades xs  

adicionarImunidade :: Personagem -> TipoDano -> Personagem
adicionarImunidade personagem imunidade = Personagem{alcunha = alcunha personagem
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
                                                    ,dano = dano personagem
                                                    ,velocidade = velocidade personagem
                                                    ,ouro = ouro personagem
                                                    ,xp = xp personagem
                                                    ,xpUp = xpUp personagem
                                                    ,nivel = nivel personagem
                                                    ,equipaveis = equipaveis personagem
                                                    ,consumiveis = consumiveis personagem
                                                    ,habilidades = habilidades personagem
                                                    ,imunidades = imunidades personagem ++ [imunidade] 
                                                    }   

removerImunidade :: Personagem -> TipoDano -> Personagem
removerImunidade personagem imunidade = [x | x <- (imunidades personagem), imunidade /= x]            


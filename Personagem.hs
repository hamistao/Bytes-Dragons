module Personagem where
import System.Random
import Item

data Raca = Raca {
    nome_raca :: String
    ,mod_forca :: Int
    ,mod_inteligencia :: Int
    ,mod_sabedoria :: Int
    ,mod_destreza :: Int
    ,mod_constituicao :: Int
    ,mod_carisma :: Int
}

data Classe = Classe {
    nome_classe :: String
}

data Habilidade = Habilidade {
    nome_habilidade :: String,
    impacto_vida :: Int,
    impacto_resistencia :: Int,
    impacto_dano :: Int,
    impacto_velocidade :: Int,
    atributo_relacionado :: String,
    pontosParaAcerto :: Int,
    tipoDeDano :: String
} deriving(Show, Eq)

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
    ,resistencia :: Int
    ,dano :: Int
    ,velocidade :: Int
    ,ouro :: Int
    ,equipaveis :: [Equipavel]
    ,consumiveis :: [Consumivel]
    ,habilidades :: [Habilidade]
} deriving(Show)

cadastraPersonagem :: String -> Classe -> Raca -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Personagem
cadastraPersonagem nome_personagem classe raca vidaMaxima forca inteligencia sabedoria destreza constituicao carisma = (Personagem {
                                                                                                                    nome_personagem = nome_personagem
                                                                                                                    ,vida = vidaMaxima
                                                                                                                    ,classe = classe
                                                                                                                    ,raca = raca
                                                                                                                    ,vidaMaxima = vidaMaxima
                                                                                                                    ,forca = forca + mod_forca raca
                                                                                                                    ,inteligencia = inteligencia + mod_inteligencia raca
                                                                                                                    ,sabedoria = sabedoria + mod_sabedoria raca
                                                                                                                    ,destreza = destreza + mod_destreza raca
                                                                                                                    ,constituicao = constituicao + mod_constituicao raca
                                                                                                                    ,carisma = carisma + mod_carisma raca
                                                                                                                    ,dano = forca
                                                                                                                    ,velocidade = destreza
                                                                                                                    ,ouro = 0
                                                                                                                    ,equipaveis = []
                                                                                                                    ,consumiveis = []
                                                                                                                    ,habilidades = []
                                                                                                                })

cadastraHabilidade :: String -> Int -> Int -> Int -> Int -> String -> Int -> String -> Habilidade
cadastraHabilidade nome impacto_vida impacto_resistencia impacto_dano impacto_velocidade atributo_relacionado pontosParaAcerto tipoDeDano = (Habilidade {
                                                                                                                            nome_habilidade = nome
                                                                                                                            ,impacto_vida = impacto_vida
                                                                                                                            ,impacto_resistencia = impacto_resistencia
                                                                                                                            ,impacto_dano = impacto_dano
                                                                                                                            ,impacto_velocidade = impacto_velocidade
                                                                                                                            ,atributo_relacionado = atributo_relacionado
                                                                                                                            ,pontosParaAcerto = pontosParaAcerto
                                                                                                                            ,tipoDeDano = tipoDeDano
                                                                                                                        })

listarPersonagens :: [Personagem] -> String
listarPersonagens [] = ""
listarPersonagens (s:xs) = "---------------------------\n"
                           ++ "Nome: " ++ show(alcunha s) ++ "\n"
                           ++ "Raca: " ++ show(raca s) ++ "\n"
                           ++ "Classe: " ++ show(classe s) ++ "\n"
                           ++ listarPersonagens xs

exibePersonagem :: [Personagem] -> String -> String
exibePersonagem [] nome = "Personagem inexistente"
exibePersonagem (s:xs) nome
    | nome == (alcunha s) = "Nome: " ++ show(alcunha s) ++ "\n"
                        ++ "Raca: " ++ show(raca s) ++ "\n"
                        ++ "Classe: " ++ show(classe s) ++ "\n"
                        ++ "Vida: " ++ show(vida s) ++ "/" ++ show(vidaMaxima s) ++ "\n"
                        ++ "Forca: " ++ show(forca s) ++ "\n"
                        ++ "Inteligencia: " ++ show(inteligencia s) ++ "\n"
                        ++ "Sabedoria: " ++ show(sabedoria s) ++ "\n"
                        ++ "Destreza: " ++ show(destreza s) ++ "\n"
                        ++ "Constituicao: " ++ show(constituicao s) ++ "\n"
                        ++ "Carisma: " ++ show(carisma s) ++ "\n"
                        ++ "Resistencia: " ++ show(resistencia s) ++ "\n"
                        ++ "Dano: " ++ show(dano s) ++ "\n"
                        ++ "Velocidade: " ++ show(velocidade s) ++ "\n"
                        ++ "Ouro: " ++ show(ouro s) ++ "\n"
                        ++ "Itens:\n"
                        ++ "Equipaveis:\n"
                        ++ listarEquipaveis (equipaveis s)
                        ++ "Consumiveis:\n"
                        ++ listarConsumiveis (consumiveis s)
                        ++ "Habilidades:\n"
                        ++ listarHabilidades (habilidades s)
    | otherwise = exibePersonagem xs nome

exbibeHabilidade :: Habilidade -> String
exbibeHabilidade habilidade = "---------------------------\n"
                           ++ "Nome: " ++ show(nome_habilidade habilidade) ++ "\n"
                           ++ if (impacto_vida habilidade /= 0) then "Causa " ++ show(impacto_dano habilidade) ++ " de dano do tipo " ++ show(tipoDeDano habilidade) ++ "\n" else ""
                           ++ if (impacto_resistencia habilidade /= 0) then "Causa " ++ show(impacto_resistencia habilidade) ++ " de dano na resistencia\n" else ""
                           ++ if (impacto_dano habilidade /= 0) then "Causa " ++ show(impacto_resistencia habilidade) ++ " de dano no dano\n" else ""
                           ++ if (impacto_dano habilidade /= 0) then "Causa " ++ show(impacto_velocidade habilidade) ++ " de dano na velocidade\n" else ""
                           ++ "Pontos para acerto: " ++ show(pontosParaAcerto habilidade) ++ "%\n"

listarHabilidades :: [Habilidade] -> String
listarHabilidades [] = ""
listarHabilidades (s:xs) = exbibeHabilidade s ++ listarHabilidades xs

selecionaAtributoRelacionado :: String -> Personagem -> Int
selecionaAtributoRelacionado atributo personagem
    | atributo == "forca" = forca personagem
    | atributo == "inteligencia" = inteligencia personagem
    | atributo == "sabedoria" = sabedoria personagem
    | atributo == "destreza" = destreza personagem
    | atributo == "constituicao" = constituicao personagem
    | atributo == "casrisma" = carisma personagem
    | otherwise = 0

usaHabilidade :: Habilidade -> Personagem -> Personagem
usaHabilidade habilidade personagem =
    Personagem{alcunha = alcunha personagem
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
        ,resistencia = resistencia personagem + impacto_resistencia habilidade
        ,dano = dano personagem + impacto_dano habilidade
        ,velocidade = velocidade personagem + impacto_velocidade habilidade
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem
        ,habilidades = habilidades personagem
    }

equiparItem :: Equipavel -> Personagem -> Personagem
equiparItem equipavel personagem = 
    Personagem{alcunha = alcunha personagem
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
        ,resistencia = resistencia personagem + alteracao_resistencia_equipavel equipavel
        ,dano = dano personagem
        ,velocidade = velocidade personagem + alteracao_velocidade equipavel
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem ++ [equipavel]
        ,consumiveis = consumiveis personagem
        ,habilidades = habilidades personagem
    }

guardarConsumivel :: Consumivel -> Personagem -> Personagem
guardarConsumivel item personagem =
    Personagem{alcunha = alcunha personagem
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
        ,resistencia = resistencia personagem
        ,dano = dano personagem
        ,velocidade = velocidade personagem
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem ++ [item]
        ,habilidades = habilidades personagem
    }

removeItem :: Consumivel -> Personagem -> [Consumivel]
removeItem consumivel personagem
    | duracao consumivel /= 0 = [item | item <- consumiveis personagem, nomeConsumivel item /= nomeConsumivel consumivel] ++ [consumivel]
    | otherwise = [item | item <- consumiveis personagem, nomeConsumivel item /= nomeConsumivel consumivel]

usarItem :: Consumivel -> Personagem -> Personagem
usarItem consumivel personagem =
    Personagem{alcunha = alcunha personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem + ganho_vida consumivel
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,resistencia = resistencia personagem + ganho_resistencia consumivel
        ,dano = dano personagem + ganho_dano consumivel
        ,velocidade = velocidade personagem
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = removeItem consumivel personagem
        ,habilidades = habilidades personagem
    }

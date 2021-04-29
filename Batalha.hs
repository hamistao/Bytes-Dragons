module Batalha where
import Personagem
import Habilidade
import Item
selecionaAtributoRelacionado :: Atributo -> Personagem -> Int
selecionaAtributoRelacionado Forca personagem = forca personagem
selecionaAtributoRelacionado Inteligencia personagem = inteligencia personagem
selecionaAtributoRelacionado Sabedoria personagem = sabedoria personagem
selecionaAtributoRelacionado Destreza personagem = destreza personagem
selecionaAtributoRelacionado Constituicao personagem = constituicao personagem
selecionaAtributoRelacionado Carisma personagem = carisma personagem

    
turnoConsumivel :: Personagem -> Personagem -> Consumivel -> Personagem 
turnoConsumivel personagemEmissor personagemReceptor consumivel = usarItemConsumivel consumivel personagemReceptor 
turnoHabilidade :: Personagem -> Personagem -> Habilidade -> Int -> Int-> Personagem
turnoHabilidade personagemEmissor personagemReceptor habilidade numeroDado1 numeroDado2 = if (isImune personagemReceptor (tipoDeDano habilidade) && (selecionaAtributoRelacionado (atributo_relacionado habilidade) personagemEmissor) + (min numeroDado1 numeroDado2) >= (pontosParaAcerto (habilidade))) then usaHabilidade habilidade personagemReceptor
                                                                                else if (selecionaAtributoRelacionado (atributo_relacionado habilidade) personagemEmissor + (numeroDado1 + numeroDado2) >= pontosParaAcerto habilidade) then usaHabilidade habilidade personagemReceptor
                                                                                else personagemReceptor    

                                                                                
isImune :: Personagem -> TipoDano -> Bool
isImune personagem habilidade = habilidade `elem` (imunidades personagem)

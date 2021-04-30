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
turnoConsumivel personagemEmissor personagemReceptor consumivel
  | temConsumivel personagemEmissor consumivel = usarItemConsumivel consumivel personagemReceptor 
  | otherwise                                  = personagemReceptor 

turnoHabilidade :: Personagem -> Personagem -> Habilidade -> Int -> Int-> Personagem
turnoHabilidade personagemEmissor personagemReceptor habilidade numeroDado1 numeroDado2 =
  if acertou personagemEmissor personagemReceptor habilidade numeroDado1 numeroDado2 then usaHabilidade habilidade personagemReceptor
  else personagemReceptor


acertou :: Personagem -> Personagem -> Habilidade -> Int -> Int -> Bool
acertou personagemEmissor personagemReceptor habilidade numeroDado1 numeroDado2 =
  if temImunidade personagemReceptor (tipoDeDano habilidade) &&
     selecionaAtributoRelacionado (atributo_relacionado habilidade) personagemEmissor + (min numeroDado1 numeroDado2) >= pontosParaAcerto habilidade
  then True

  else if not (temImunidade personagemReceptor (tipoDeDano habilidade)) &&
          selecionaAtributoRelacionado (atributo_relacionado habilidade) personagemEmissor + (max numeroDado1 numeroDado2) >= pontosParaAcerto habilidade
  then True

  else False

                                                                                
taVivo :: Personagem -> Bool
taVivo personagem = (vida personagem) > 0

temImunidade :: Personagem -> TipoDano -> Bool
temImunidade personagem habilidade = habilidade `elem` (imunidades personagem)


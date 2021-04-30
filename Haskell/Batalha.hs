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

    
turnoConsumivel :: Personagem -> Personagem -> Consumivel -> [Personagem] 
turnoConsumivel personagemEmissor personagemReceptor consumivel
  | temConsumivel personagemEmissor consumivel = [usarItemConsumivel consumivel personagemEmissor, aplicarItemConsumivel consumivel personagemReceptor] 
  | otherwise                                  = [personagemEmissor, personagemReceptor]

turnoHabilidade :: Personagem -> Personagem -> Habilidade -> Int -> Int -> Int -> Personagem
turnoHabilidade personagemEmissor personagemReceptor habilidade numeroDado1 numeroDado2 num3 =
  if acertou personagemEmissor personagemReceptor habilidade numeroDado1 numeroDado2 num3 then usaHabilidade habilidade personagemReceptor
  else personagemReceptor


acertou :: Personagem -> Personagem -> Habilidade -> Int -> Int -> Int -> Bool
acertou personagemEmissor personagemReceptor habilidade numeroDado1 numeroDado2 numeroDado3 =
  if temImunidade personagemReceptor (tipoDeDano habilidade) &&
     selecionaAtributoRelacionado (atributo_relacionado habilidade) personagemEmissor + (min numeroDado1 numeroDado2) >= pontosParaAcerto habilidade
      if(((velocidade personagemReceptor) - (min numeroDado1 numeroDado2) > 0) && (velocidade personagemReceptor) - (min numeroDado1 numeroDado2) > numeroDado3) 
      then True
      else False

  else if not (temImunidade personagemReceptor (tipoDeDano habilidade)) &&
          selecionaAtributoRelacionado (atributo_relacionado habilidade) personagemEmissor + (max numeroDado1 numeroDado2) >= pontosParaAcerto habilidade
          if(((velocidade personagemReceptor) - (max numeroDado1 numeroDado2) > 0) && (velocidade personagemReceptor) - (max numeroDado1 numeroDado2) > numeroDado3) 
          then True
          else False
  
  else False

                                                                                
taVivo :: Personagem -> Bool
taVivo personagem = (vida personagem) > 0

temImunidade :: Personagem -> TipoDano -> Bool
temImunidade personagem habilidade = habilidade `elem` (imunidades personagem)


module Level where
import Personagem
import Habilidade

aumentaXP :: Personagem -> Int -> Personagem
aumentaXP personagem quantidadeXP
  | xp personagem + quantidadeXP == xpUp personagem = upa personagem
  | xp personagem + quantidadeXP > xpUp personagem = aumentaXP (upa personagem) (xp personagem + quantidadeXP - xpUp personagem)
  | otherwise = Personagem {
      nome_personagem = nome_personagem personagem
      , raca = raca personagem
      , classe = classe personagem
      , vida = vida personagem
      , vidaMaxima = vidaMaxima personagem
      , forca = forca personagem
      , inteligencia = inteligencia personagem
      , sabedoria = sabedoria personagem
      , destreza = destreza personagem
      , constituicao = constituicao personagem
      , carisma = carisma personagem
      , velocidade = velocidade personagem
      , ouro = ouro personagem
      , xp = xp personagem + quantidadeXP
      , xpUp = xpUp personagem
      , nivel = nivel personagem
      , equipaveis = equipaveis personagem
      , consumiveis = consumiveis personagem
      , habilidades_personagem = habilidades_personagem personagem
      , imunidades = imunidades personagem
      }


upa :: Personagem -> Personagem
upa personagem = Personagem {
  nome_personagem = nome_personagem personagem
  , raca = raca personagem
  , classe = classe personagem
  , vida = vidaMaxima personagem + 20
  , vidaMaxima = vidaMaxima personagem + 20
  , forca = forca personagem + 1
  , inteligencia = inteligencia personagem + 1
  , sabedoria = sabedoria personagem + 1
  , destreza = destreza personagem + 1
  , constituicao = constituicao personagem + 1
  , carisma = carisma personagem + 1
  , velocidade = velocidade personagem + 1
  , ouro = ouro personagem
  , xp = 0
  , xpUp = xpUp personagem + 500
  , nivel = nivel personagem + 1
  , equipaveis = equipaveis personagem
  , consumiveis = consumiveis personagem
  , habilidades_personagem = habilidades_personagem personagem
  , imunidades = imunidades personagem
  }


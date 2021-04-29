import Personagem
import Habilidade

selecionaAtributoRelacionado :: Atributo -> Personagem -> Int
selecionaAtributoRelacionado Forca personagem = forca personagem
selecionaAtributoRelacionado Inteligencia personagem = inteligencia personagem
selecionaAtributoRelacionado Sabedoria personagem = sabedoria personagem
selecionaAtributoRelacionado Destreza personagem = destreza personagem
selecionaAtributoRelacionado Constituicao personagem = constituicao personagem
selecionaAtributoRelacionado Carisma personagem = carisma personagem


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
    }
    
turnoConsumivel :: Personagem -> Personagem -> Consumivel -> Personagem 
turnoConsumivel personagemEmissor personagemReceptor consumivel = usarItemConsumivel consumivel personagemReceptor 
turnoHabilidade :: Personagem -> Personagem -> Habilidade -> Int -> Personagem
turnoHabilidade personagemEmissor personagemReceptor habilidade numeroDados = if (selecionaAtributoRelacionado ((atributo_relacionado habilidade) personagem) + numeroDados ) >= pontosParaAcerto habilidade then usaHabilidade habilidade personagemReceptor
                                                                              else personagemReceptor   

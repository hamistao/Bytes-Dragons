import Personagem

selecionaAtributoRelacionado :: Atributo -> Personagem -> Int
selecionaAtributoRelacionado atributo personagem
    | atributo == Forca = forca personagem
    | atributo == Inteligencia = inteligencia personagem
    | atributo == Sabedoria = sabedoria personagem
    | atributo == Destreza = destreza personagem
    | atributo == Constituicao = constituicao personagem
    | atributo == Carisma = carisma personagem
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
    }
    
turnoConsumivel :: Personagem -> Personagem -> Consumivel -> Personagem 
turnoConsumivel personagemEmissor personagemReceptor consumivel = usarItemConsumivel consumivel personagemReceptor 
turnoHabilidade :: Personagem -> Personagem -> Habilidade -> Int -> Personagem
turnoHabilidade personagemEmissor personagemReceptor habilidade numeroDados = if (selecionaAtributoRelacionado (atributo_relacionado habilidade) + numeroDados ) >= pontosParaAcerto habilidade then usaHabilidade habilidade personagemReceptor
                                                                              else personagem2   

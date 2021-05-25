:- persistent equipavel(nome:any, alteracaoVidaMaxima:any, alteracaoForca:any, alteracaoInteligencia:any, alteracaoSabedoria:any, alteracaoDestreza:any, alteracaoConstituicao:any, alteracaoCarisma:any, alteracaoVelocidade:any, tipo:any).

selecionaAtributoRelacionado("Forca", Personagem(Forca, Inteligencia, Sabedoria, Destreza, Constituicao, Carisma), Valor) :-
    Valor is Forca.
selecionaAtributoRelacionado("Inteligencia", Personagem(Forca, Inteligencia, Sabedoria, Destreza, Constituicao, Carisma), Valor) :-
    Valor is Inteligencia.
selecionaAtributoRelacionado("Sabedoria", Personagem(Forca, Inteligencia, Sabedoria, Destreza, Constituicao, Carisma), Valor) :-
    Valor is Sabedoria.
selecionaAtributoRelacionado("Destreza", Personagem(Forca, Inteligencia, Sabedoria, Destreza, Constituicao, Carisma), Valor) :-
    Valor is Destreza.
selecionaAtributoRelacionado("Constituicao", Personagem(Forca, Inteligencia, Sabedoria, Destreza, Constituicao, Carisma), Valor) :-
    Valor is Constituicao.
selecionaAtributoRelacionado("Carisma", Personagem(Forca, Inteligencia, Sabedoria, Destreza, Constituicao, Carisma), Valor) :-
    Valor is Carisma.


usarConsumivel(NomePersonagem, NomeConsumivel) :-
    retract_personagemTemConsumivel(NomePersonagem, NomeConsumivel).
    
aplicarConsumivel(NomePersonagem, NomeConsumivel)
    consumivel(NomeConsumivel, AlteracaoVida, AlteracaoVelocidade, Duracao),
    personagem(NomePersonagem, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
    Carisma, Velocidade, Ouro, Xp, XpUp, Nivel),
    NewVida is (Vida + AlteracaoVida), 
    NewVelocidade is (Velocidade + AlteracaoVelocidade), 
    retract_personagem(NomePersonagem, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    assert_personagem(NomePersonagem, Raca, Classe, VidaMaxima, NewVida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
        Carisma, NewVelocidade, Ouro, Xp, XpUp, Nivel).




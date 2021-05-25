:- persistent participaDaBatalha(nomePersonagem:any).

usarConsumivel(NomePersonagem, NomeConsumivel) :-
    personagemTemConsumivel(NomePersonagem, NomeConsumivel, Duracao),
    NewDuracao is Duracao - 1,
    retractall_personagemTemConsumivel(NomePersonagem, NomeConsumivel, Duracao),
    assert_personagemTemConsumivel(NomePersonagem, NomeConsumivel, NewDuracao).
    
aplicarConsumivel(NomePersonagem, NomeConsumivel):-
    consumivel(NomeConsumivel, AlteracaoVida, AlteracaoVelocidade, Duracao),
    personagem(NomePersonagem, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
    Carisma, Velocidade, Ouro, Xp, XpUp, Nivel),
    NewVida is (Vida + AlteracaoVida), 
    NewVelocidade is (Velocidade + AlteracaoVelocidade), 
    retractall_personagem(NomePersonagem, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    assert_personagem(NomePersonagem, Raca, Classe, VidaMaxima, NewVida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
        Carisma, NewVelocidade, Ouro, Xp, XpUp, Nivel).

aplicarHabilidade(Nome, Habilidade) :-
    habilidade(Habilidade, ImpactoVida, ImpactoVelocidade, _, _, _),
    personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
    Carisma, Velocidade, Ouro, Xp, XpUp, Nivel),
    mudaVida(Vida, ImpactoVida, VidaMaxima, NewVida),
    NewVelocidade is (Velocidade + ImpactoVelocidade),
    retractall_personagem(NomePersonagem, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    assert_personagem(NomePersonagem, Raca, Classe, VidaMaxima, NewVida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
        Carisma, NewVelocidade, Ouro, Xp, XpUp, Nivel).

mudaVida(Vida, ImpactoVidaStr, VidaMaxima, NewVida) :-
	atom_number(ImpactoVidaStr, ImpactoVida),
    \+ Vida + ImpactoVida >  VidaMaxima,
    NewVida is (Vida + ImpactoVida).
mudaVida(_, _, NewVida, NewVida).

exibeHabilidadesPersonagem(Nome) :-
    listarHabilidadesPersonagem(Nome),
    foreach(personagemTemEquipavel(Nome, Equipavel), listarHabilidadesEquipavel(Equipavel)).

personagemTemHabilidadeEquipavel(Nome, Habilidade) :-
    personagemTemHabilidade(Nome, Habilidade).
personagemTemHabilidadeEquipavel(Nome, Habilidade) :-
    personagemTemEquipavel(Nome, Equipavel),
    equipavelTemHabilidade(Equipavel, Habilidade).

acertouHabilidade(Emissor, Habilidade, Alvo, D1, D2, D3) :-
    habilidade(Habilidade, _, _, Atributo, AcertoStr, Tipo),
    personagemTemResistencia(Alvo, Tipo),!,
    atributoPersonagem(Emissor, Atributo, Valor),
    menorDado(D1, D2, Dmenor),
    atom_number(AcertoStr, Acerto),
    Valor + Dmenor >= Acerto,!,
    \+consegueEsquivar(Emissor, Alvo, D3).

acertouHabilidade(Emissor, Habilidade, Alvo, D1, D2, D3) :-
    habilidade(Habilidade, _, _, Atributo, AcertoStr, Tipo),
    \+personagemTemResistencia(Alvo, Tipo),!,
    atributoPersonagem(Emissor, Atributo, Valor),
    maiorDado(D1, D2, Dmaior),
    atom_number(AcertoStr, Acerto),
    Valor + Dmaior >= Acerto,!,
    \+consegueEsquivar(Emissor, Alvo, D3).

consegueEsquivar(Emissor, Alvo, D) :-
    diferencaVelocidade(Emissor, Alvo, Valor),
    D < Valor.

diferencaVelocidade(Emissor, Alvo, Valor) :-
    personagem(Emissor, _, _, _, _, _, _, _, _, _, _, V1, _, _, _, _),
    personagem(Alvo, _, _, _, _, _, _, _, _, _, _, V2, _, _, _, _),
    Valor is V2 - V1.

menorDado(D1, D2, D1) :-
    D1 < D2.
menorDado(_, D2, D2).

maiorDado(D1, D2, D1) :-
    D1 > D2.
maiorDado(_, D2, D2).


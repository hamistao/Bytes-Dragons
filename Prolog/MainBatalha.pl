:- include('Batalha.pl').

menuBatalha :-
    nl, writeln('Quais os personagens que irao batalhar?'),
    readEntrada(P),
    verificaPersonagens(P),
    
    menuBatalha(0).

menuBatalha(0) :-
    writeln("Qual sera a proxima acao?\n1 - Personagem Usar Habilidade\n2 - Personagem Usar Consumivel\n3 - Checar Personagens\n9 - Encerrar a Batalha\n"),
    readEntrada(Entrada),
    menuBatalha(Entrada).

menuBatalha("1") :-
    writeln('Qual Personagem usara a Habilidade?'),
    readEntrada(Nome),
    participaDaBatalha(Nome),
    writeln('\nA(s) Habilidade(s) disponivel(is) sao:'),
    exibeHabilidadesPersonagem(Nome),
    writeln('\nQual Habilidade sera usado?'),
    readEntrada(Habilidade),
    personagemTemHabilidadeEquipavel(Nome, Habilidade),
    writeln('Em quem sera usado a Habilidade?'),
    readEntrada(Alvo),
    writeResultadosDaHabilidade(Nome, Habilidade, Alvo),
    readEntrada(_),
    menuBatalha(0).

menuBatalha("2") :-
    writeln('Qual Personagem usara o Consumivel?'),
    readEntrada(Nome),
    participaDaBatalha(Nome),
    writeln('Qual Consumivel sera usado?'),
    readEntrada(Consumivel),
    personagemTemConsumivel(Nome, Consumivel),
    writeln('Em quem sera usado o consumivel?'),
    readEntrada(Alvo),
    personagemTemConsumivel(Nome, Consumivel),
    aplicarConsumivel(Alvo, Consumivel),
    writeln('Consumivel usado com sucesso'),
    readEntrada(_),
    menuBatalha(0).

menuBatalha("3") :-
    writeln('Qual Personagem deseja checar?'),
    readEntrada(Nome),
    participaDaBatalha(Nome),
    exibePersonagem(Nome),
    readEntrada(_),
    menuBatalha(0).

menuBatalha("9") :-
    writeln('Batalha Encerrada.'),
    writeln('Os Personagens que morreram foram:'),
    exibePersonagensMortos,
    writeln('Os Personagens que sobreviveram foram:'),
    exibePersonagensVivos,
    writeln('Quais Personagens voce gostaria de recuperar para vida maxima?'),
    recuperaVidaPersonagens,
    writeln('\nQuais Personagens voce gostaria que ganhassem XP?'),
    vaoGanharXP,
    writeln('Quanto de XP ganharao?'),
    readEntrada(Xp),
    writeln('\nQuais Personagens voce gostaria que ganhassem Ouro?'),
    vaoGanharOuro,
    writeln('Quanto de Ouro ganharao?'),
    readEntrada(Ouro),
    colocaXP(Xp),
    colocaOuro(Ouro),
    writeln('Quais Personagens voce gostaria de apagar do sistema?'),
    apagaPersonagens,
    encerraBatalha,
    readEntrada(_).

menuBatalha(_):-
    writeln('\nEntrada Invalida.'),
    readEntrada(_),
    menuBatalha(0).


exibePersonagensMortos :-
    foreach(participaDaBatalha(Nome), (\+isVivo(Nome), exibePersonagem(Nome))).

exibePersonagensVivos :-
    foreach(participaDaBatalha(Nome), (isVivo(Nome), exibePersonagem(Nome))).

isVivo(Nome) :-
    personagem(Nome, _, _, _, Vida, _, _, _, _, _, _, _, _, _, _, _),
    Vida > 0.


recuperaVidaPersonagens :-
    readEntrada(P),
    recuperaVidaPersonagens(P).
recuperaVidaPersonagens("").
recuperaVidaPersonagens(Nome) :-
    participaDaBatalha(Nome),
    retractall_personagem(Nome, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O),
    assert_personagem(Nome, A, B, C, C, E, F, G, H, I, J, K, L, M, N, O),
    readEntrada(P),
    recuperaVidaPersonagens(P).
recuperaVidaPersonagens(NomeErrado) :-
    write('\nPersonagem '), write(NomeErrado), writeln(' nao participa da Batalha.\n'),
    readEntrada(P),
    recuperaVidaPersonagens(P).


vaoGanharXP :-
    readEntrada(P),
    vaoGanharXP(P).
vaoGanharXP("").
vaoGanharXP(Nome) :-
    participaDaBatalha(Nome),
    assert_vaiGanharXp(Nome, A, B, C, C, E, F, G, H, I, J, K, L, M, N, O),
    readEntrada(P),
    vaoGanharXP(P).
vaoGanharXP(NomeErrado) :-
    write('Personagem '), write(NomeErrado), writeln(' nao participa da Batalha.'),
    readEntrada(P),
    vaoGanharXP(P).


vaoGanharOuro :-
    readEntrada(P),
    vaoGanharOuro(P).
vaoGanharOuro("").
vaoGanharOuro(Nome) :-
    participaDaBatalha(Nome),
    assert_vaiGanharOuro(Nome, A, B, C, C, E, F, G, H, I, J, K, L, M, N, O),
    readEntrada(P),
    vaoGanharOuro(P).
vaoGanharOuro(NomeErrado) :-
    write('Personagem '), write(NomeErrado), writeln(' nao participa da Batalha.'),
    readEntrada(P),
    vaoGanharOuro(P).


colocaXP(Xp) :-
    foreach(vaiGanharXp(Nome), aumentaXp(Nome, Xp)).

colocaOuro(Ouro) :-
    foreach(vaiGanharOuro(Nome), aumentaOuro(Nome, Ouro)).


apagaPersonagens :-
    readEntrada(P),
    apagaPersonagens(P).
apagaPersonagens("").
apagaPersonagens(Nome) :-
    participaDaBatalha(Nome),
    retractall_personagem(Nome, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O),
    retractall_participaDaBatalha(Nome),
    readEntrada(P),
    apagaPersonagens(P).
apagaPersonagens(NomeErrado) :-
    write('Personagem '), write(NomeErrado), writeln(' nao participa da Batalha.'),
    readEntrada(P),
    apagaPersonagens(P).


encerraBatalha :-
    foreach(participaDaBatalha(Nome), retractall_participaDaBatalha(Nome)).


verificaPersonagens("").
verificaPersonagens(Nome) :-
    personagemExiste(Nome),
    assert_participaDaBatalha(Nome),
    readEntrada(P),
    verificaPersonagens(P).
verificaPersonagens(NomeErrado) :-
    write('Personagem '), write(NomeErrado), writeln(' nao existe'),
    readEntrada(P),
    verificaPersonagens(P).

consumivelExiste(Nome) :-
    consumivel(Nome, _, _, _).


writeResultadosDaHabilidade(Emissor, Habilidade, Alvo) :-
    random(1,21, R1),
    random(1,21, R2),
    random(1,31, R3),
    writeln('Os dados tirados foram:'),
    write('Para acerto: '), write(R1), write(' e '), writeln(R2),
    chanceDeEsquiva(Emissor, Alvo, C),
    write('A chance de esquiva eh: '), write(C), writeln('%.'),
    write('A Habilidade Usada foi: '), writeln(Habilidade),
    habilidade(Habilidade, _, _, _, Acerto, _),
    write('E requer '), write(Acerto), writeln(' no dado para acertar.'),
    vericiaHabilidade(Emissor, Alvo, Habilidade),
    usaHabilidade(Emissor, Habilidade, Alvo, R1, R2, R3).

usaHabilidade(Emissor, Habilidade, Alvo, D1, D2, D3) :-
    acertouHabilidade(Emissor, Habilidade, Alvo, D1, D2, D3),
    aplicarHabilidade(Alvo, Habilidade),
    writeln('Acertou').
usaHabilidade(_, _, _, _, _, _):-
    writeln('Errou').
    
    
vericiaHabilidade(Emissor, Alvo, Habilidade) :-
    resistenciaDoAlvo(Alvo, Habilidade),
    atributoDoEmissor(Emissor, Habilidade).

resistenciaDoAlvo(Alvo, Habilidade) :-
    habilidade(Habilidade, _, _, _, _, Tipo),
    personagemTemResistencia(Alvo, Tipo),
    writeln('O receptor tem resistencia ao tipo da habilidade. O dado de menor numero sera usado.').
resistenciaDoAlvo(_,_) :-
    writeln('O receptor nao tem resistencia ao tipo da habilidade. O dado de maior numero sera usado.').

atributoDoEmissor(Emissor, Habilidade) :-
    habilidade(Habilidade, _, _, Atributo, _, _),
    atributoPersonagem(Emissor, Atributo, Valor),
    write('O Emissor tem '), write(Valor), writeln(' pontos do atributo relacionado a habilidade. Estes serao somados ao numero do dado para o acerto.').


chanceDeEsquiva(Emissor, Alvo, C) :-
    diferencaVelocidade(Emissor, Alvo, Diferenca),
    C is (Diferenca * 3.3).

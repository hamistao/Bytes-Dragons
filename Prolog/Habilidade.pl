construtorHabilidade(Nome, ImpactoVida, ImpactoVelocidade, AtributoRelacionado, PontosParaAcerto, TipoDeDano, R):-
    string_concat('habilidade("', Nome, S1),
    string_concat(S1, '",', S2),
    string_concat(S2, ImpactoVida, S3),
    string_concat(S3, ',', S4),
    string_concat(S4, ImpactoVelocidade, S5),
    string_concat(S5, ', "', S6),
    string_concat(S6, AtributoRelacionado, S7),
    string_concat(S7, '",', S8),
    string_concat(S8, PontosParaAcerto, S9),
    string_concat(S9, ',"', S10),
    string_concat(S10, TipoDeDano, S11),
    string_concat(S11, '")', R).
:- discontiguous construtorHabilidade/7.
    
exibir(habilidade(Nome, ImpactoVida, ImpactoVelocidade, AtributoRelacionado, PontosParaAcerto, TipoDeDano), R) :-
    string_concat("\nNome: ", Nome, S1),
    string_concat(S1, "\nTipo da habilidade: ", S2),
    string_concat(S2, TipoDeDano, S3),
    string_concat(S3, "\nAtributo relacionado: ", S4),
    string_concat(S4, AtributoRelacionado, S5),
    string_concat(S5, "\nModifica a vida do alvo em ", S6),
    string_concat(S6, ImpactoVida, S7),
    string_concat(S7, "\nModifica a velocidade do alvo em ", S8),
    string_concat(S8, ImpactoVelocidade, S9),
    string_concat(S9, "\nPontos para acerto: ", S10),
    string_concat(S10, PontosParaAcerto, R).
:- discontiguous exibir/2.

listaHabilidades([], []).
listaHabilidades([Habilidade|L], R) :-
    listaHabilidades(L, R1),
    nomeHabilidade(Habilidade, Nome),
    string_concat("Nome: ", Nome, S),
    append([S], R1, R).
:- discontiguous listaHabilidades/2.

nomeHabilidade(habilidade(Nome, _, _, _, _, _), Nome).
:- discontiguous nomeHabilidade/2.

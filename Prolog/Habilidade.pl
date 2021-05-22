construtorHabilidade(Nome, ImpactoVida, ImpactoVelocidade, AtributoRelacionado, PontosParaAcerto, TipoDeDano, habilidade(Nome, ImpactoVida, ImpactoVelocidade, AtributoRelacionado, PontosParaAcerto, TipoDeDano)).

exibeHabilidade(habilidade(Nome, ImpactoVida, ImpactoVelocidade, AtributoRelacionado, PontosParaAcerto, TipoDeDano), R) :-
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

listaHabilidades([], _).

listaHabilidades([Habilidade|L], R) :-
    listaHabilidades(L, R1),
    getNome(Habilidade, Nome),
    string_concat("\nNome: ", Nome, S),
    string_concat(S, R1, R).

getNome(habilidade(Nome, _, _, _, _, _), Nome).

isTipoDano("Cortante").
isTipoDano("Magico").
isTipoDano("Venenoso").
isTipoDano("Fogo").
isTipoDano("Gelo").
isTipoDano("Fisico").
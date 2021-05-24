construtorLoja(Nome, R) :-
    string_concat('loja("', Nome, S1),
    string_concat(S1, '",', S2),
    string_concat(S2, '[[]]', S3),
    string_concat(S3, ',', S4),
    string_concat(S4, '[[]]', S5),
    string_concat(S5, ')', R).

exibir(loja(Nome, [])) :-
    string_concat("\nNome: ", Nome, S1),
    string_concat("\nItens a venda:\nEquipaveis:\n"),

catalogo([], []).
catalogo([[Item, Preco] | L], R) :-
    catalogo(L, R1),
    nomeItem(Item, Nome),
    string_concat("\nNome: ", Nome, S1),
    string_concat(S1, "\nPreco: ", S2),
    string_concat(S2, Preco, S3),
    string_concat(S3, "\n", S4).


listarLojas([], []).
listarLojas([Loja|L], R) :-
    listarLojas(L, R1),
    nomeLoja(Loja, Nome),
    string_concat("Nome: ", Nome, S),
    append([S], R1, R).

nomeLoja(loja(Nome, _, _), Nome).
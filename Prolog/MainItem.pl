:- include('Item.pl').

opcaoDeItem :-
    writeln('1 - Equipavel \nou \n2 -Consumivel?').

menuItem(0) :-
    
    writeln(   '                          ( (('),
    writeln(   '                           ) ))'),
    writeln(   '  .::.                    / /('),
    writeln(   ' \'M .-;-.-.-.-.-.-.-.-.-/| ((::::::::::::::::::::::::::::::::::::::::::::::.._'),
    writeln(   '(J ( ( ( ( ( ( ( ( ( ( ( |  ))   -====================================-      _.>'),
    writeln(   ' `P `-;-`-`-`-`-`-`-`-`-\\| ((::::::::::::::::::::::::::::::::::::::::::::::'''),
    writeln(   '  `::\'                    \\ \\('),
    writeln(   '                           ) ))'),
    writeln(   '                          (_(('),
    writeln(   '1 - Listar Itens\n2 - Cadastrar Item\n3 - Excluir Item\n4 - Detalhes de Item\n9 - Retorna Menu\n'),
    readEntrada(Entrada),
    menuItem(Entrada).

menuItem("1") :-
    structsFromFile('data/equip.info', EquipaveisStr),
    structsFromFile('data/consmvl.info', Consumiveis),
    listarEquipaveis(EquipaveisStr, ListaEquip),
    writeln('Melkaco prego'),
    nl, writeln('Itens Equipaveis:'),
    writeComId(ListaEquip, 1),
    writeln('Itens Consumiveis:'),
    writeComId(Consumiveis, 1),
    readEntrada(_),
    menuItem(0).

menuItem("2") :-
    nl, opcaoDeItem,
    readEntrada(Tipo),
    cadastraItem(Tipo),
    writeln('Item cadastrado com sucesso.\nEnter para continuar'),
    readEntrada(_),
    menuItem(0).

menuItem("3").

menuItem("4") :-
    nl, opcaoDeItem,
    readEntrada(Tipo),
    detalheItem(Tipo),
    writeln('\nEnter para continuar'),
    readEntrada(_),
    menuItem(0).


detalheItem("1") :-
    writeln('Qual o ID do Equipavel?'),
    readEntrada(Id),
    atom_number(Id, Desejado),
    Desejado > 0,
    length(Equipaveis, L),
    Desejado =< L, %>
    structsFromFile('data/equip.info', Equipaveis),
    elemFromId(Equipaveis, Desejado, 0, Equipavel),
    exibirItem(Equipavel, S),
    writeln(S).

detalheItem("2") :-
    writeln('Qual o ID do Consumivel?'),
    readEntrada(Id),
    atom_number(Id, Desejado),
    structsFromFile('data/consmvl.info', Consumiveis),
    elemFromId(Consumiveis, Desejado, 0, Consumivel),
    Consumivel \= -1,
    exibirItem(Consumivel, S),
    writeln(S).

detalheItem(X) :-
    write('o id - '),
    write(X),
    writeln(' - Id Invalido bro').


cadastraItem("1") :-
    nl, writeln('Qual o nome do Equipavel?'),
    readEntrada(Nome),
    writeln('Qual a Alteracao de Vida Maxima?'),
    readEntrada(Vida_maxima),
    writeln('Qual a Alteracao de Forca?'),
    readEntrada(Forca),
    writeln('Qual a Alteracao de Inteligencia?'),
    readEntrada(Inteligencia),
    writeln('Qual a Alteracao de Sabedoria?'),
    readEntrada(Sabedoria),
    writeln('Qual a Alteracao de Destreza?'),
    readEntrada(Destreza),
    writeln('Qual a Alteracao de Constituicao?'),
    readEntrada(Constituicao),
    writeln('Qual a Alteracao de Carisma?'),
    readEntrada(Carisma),
    writeln('Qual a Alteracao de Velocidade?'),
    readEntrada(Velocd),
    writeln('Onde sera Equipavel (Cabeca | Torso | Pernas | Maos | Arma) ?'),
    readEntrada(Tipo),
    open('data/equip.info', append, Str),
    construtorItemEquipavel(Nome, Vida_maxima, Forca, Inteligencia, Sabedoria, Destreza, Constituicao, Carisma, Velocd, Tipo, Item),
    writeln(Item),
    append(Str, Item).

cadastraItem(_) :-
    writeln('isso eh balela ai brother').

menuItem(_).


equipaveisFromStr([], _).
equipaveisFromStr([Equipavel|L], Lista) :-
    equipaveisFromStr(L, PLista),
    writeln(Equipavel),
    equipavelFromStr(Equipavel, Item),
    append([Item], PLista, Lista).


equipavelFromStr(Str, Item) :-
    writeln('n sei bro'),
    nth0(0, Str, Nome),
    writeln('eu quero morrerrr aaaaaa'),
    nth0(1, Str, Vida),
    nth0(2, Str, Forca),
    nth0(3, Str, Inteligencia),
    nth0(4, Str, Sabedoria),
    nth0(5, Str, Destreza),
    nth0(6, Str, Constituicao),
    nth0(7, Str, Carisma),
    nth0(8, Str, Velocd),
    nth0(9, Str, Tipo),
    writeln('mais 3 as'),
    construtorItemEquipavel(Nome, Vida_maxima, Forca, Inteligencia, Sabedoria, Destreza, Constituicao, Carisma, Velocd, Tipo, Item).
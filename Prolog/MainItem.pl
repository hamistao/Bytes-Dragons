:- include('Item.pl').

opcaoDeItem :-
    writeln('1 - Equipavel \nou \n2 -Consumivel?').

menuItem(0) :-
    write('\e[H\e[2J'),
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
    linesFromFile('data/equip.info', Equipaveis),
    linesFromFile('data/consmvl.info', Consumiveis),
    listarEquipaveis(Equipaveis, ListaEquip),
    nl, writeln('Itens Equipaveis:'),
    writeComId(ListaEquip, 1),
    nl, writeln('Itens Consumiveis:'),
    writeComId(Consumiveis, 1),
    readEntrada(_).

menuItem("2") :-
    nl, opcaoDeItem,
    readEntrada(Tipo),
    cadastraItem(Tipo),
    writeln('Item cadastrado com sucesso.\nEnter para continuar'),
    readEntrada(_).

menuItem("3").

menuItem("4") :-
    nl, opcaoDeItem,
    readEntrada(Tipo),
    detalheItem(Tipo),
    writeln('\nEnter para continuar'),
    readEntrada(_).


detalheItem("1") :-
    writeln('Qual o ID do Equipavel?'),
    readEntrada(Id),
    linesFromFile('data/equip.info', Equipaveis),
    Desejado is Id-1,
    elemFromId(Equipaveis, Desejado, 0, Equipavel),
    Equipavel \= -1,
    exibeEquipavel(Equipavel, S),
    writeln(S).

detalheItem("2") :-
    writeln('Qual o ID do Consumivel?'),
    readEntrada(Id),
    linesFromFile('data/consmvl.info', Consumiveis),
    Desejado is Id-1,
    elemFromId(Consumiveis, Desejado, 0, Consumivel),
    Consumivel \= -1,
    exibeEquipavel(Consumivel, S),
    writeln(S).

detalheItem(_) :-
    writeln('Id Invalido bro').


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
    writeln(Str, Item).

cadastraItem(_) :-
    writeln('isso eh balela ai brother').

menuItem(_).

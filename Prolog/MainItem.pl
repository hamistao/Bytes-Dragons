:- include('Item.pl').

opcaoDeItem(Tipo) :-
    writeln('1 - Equipavel \nou \n2 -Consumivel?'),
    nl, readEntrada(Tipo).

menuItem :-
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
    writeln(   '1 - Listar Itens\n2 - Cadastrar Item\n3 - Excluir Item\n4 - Detalhes de Item\n5 - Encatar um Item\n6 - Desencanta um Item\n9 - Retorna Menu\n'),
    readEntrada(Entrada),
    menuItem(Entrada).

menuItem("1") :-
    structsFromFile('data/equip.info', EquipaveisStr),
    structsFromFile('data/consmvl.info', Consumiveis),
    listarItem(EquipaveisStr, ListaEquip),
    nl, writeln('Itens Equipaveis:'),
    writeComId(ListaEquip, 1),
    writeln('Itens Consumiveis:'),
    writeComId(Consumiveis, 1),
    readEntrada(_),
    menuItem.

menuItem("2") :-
    opcaoDeItem(Tipo),
    cadastraItem(Tipo),
    writeln('Item cadastrado com sucesso.\nEnter para continuar'),
    readEntrada(_),
    menuItem.

menuItem("3") :-
    opcaoDeItem(Tipo),
    excluiItem(Tipo),
    writeln('Item excluido com sucesso'),
    readEntrada(_),
    menuItem.

menuItem("4") :-
    opcaoDeItem(Tipo),
    detalheItem(Tipo),
    writeln('\nEnter para continuar'),
    readEntrada(_),
    menuItem.

menuItem("9").

menuItem(_) :-
    writeln('\nEntrada invalida.'),
    menuItem.

detalheItem("1") :-
    writeln('Qual o ID do Equipavel?'),
    exibeFromFile('data/equip.info').

detalheItem("2") :-
    writeln('Qual o ID do Consumivel?'),
    exibeFromFile('data/consmvl.info').

detalheItem(_) :-
    write('tipo de item so pode ser \'1\' ou \'2\''),
    menuItem("4").

excluiItem("1") :-
    writeln('Qual o ID do Equipavel?'),
    readEntrada(Id),
    atom_number(Id, Desejado),
    removeFromFile('data/equip.info', Desejado).

excluiItem("2") :-
    writeln('Qual o ID do Consumivel?'),
    readEntrada(Id),
    atom_number(Id, Desejado),
    removeFromFile('data/consmvl.info', Desejado).

excluiItem(_) :- 
    writeln('tais trolando brother?').


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
    construtorItemString(Nome, Vida_maxima, Forca, Inteligencia, Sabedoria, Destreza, Constituicao, Carisma, Velocd, Tipo, Item),
    writeln(Item),
    write(Str, Item), writeln(Str, ".").

cadastraItem("2") :-
    nl, writeln('Qual o nome do Consumivel?'),
    readEntrada(Nome),
    writeln('Qual a Alteracao de Vida?'),
    readEntrada(Vida),
    writeln('Qual a Alteracao de Velocidade?'),
    readEntrada(Velocidade),
    writeln('Qual a Durabilidade?'),
    readEntrada(Durac),
    open('data/consmvl.info', append, Str),
    construtorItemString(Nome, Vida, Velocidade, Durac, Item),
    writeln(Item),
    write(Str, Item), writeln(Str, ".").

cadastraItem(_) :-
    writeln('isso eh balela ai brother').


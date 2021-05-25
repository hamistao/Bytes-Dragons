:- include('Consumivel.pl').
:- include('Equipavel.pl').

opcaoDeItem(Tipo) :-
    writeln('1 - Equipavel \nou \n2 - Consumivel?'),
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
    nl, writeln('Itens Equipaveis:'),
	listarEquipaveis,
    nl, writeln('Itens Consumiveis:'),
	listarConsumiveis,
    readEntrada(_),
    menuItem.

menuItem("2") :-
    opcaoDeItem(Tipo),
    cadastraItem(Tipo),
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

menuItem("5") :-
    nl, writeln('Qual o nome do Equipavel?'),
    readEntrada(Equipavel),
	equipavel(Equipavel, _, _, _, _, _, _, _, _, _),

	writeln('Qual o nome da Habilidade?'),
	readEntrada(Habilidade),
	habilidade(Habilidade, _, _, _, _, _),

	assert_equipavelTemHabilidade(Equipavel, Habilidade),
    writeln('Item encantado com sucesso.\nEnter para continuar'),
    readEntrada(_),
    menuItem.

menuItem("9").

menuItem(_) :-
    writeln('\nEntrada invalida.'),
    menuItem.

detalheItem("1") :-
    writeln('Qual o nome do Equipavel?'),
	readEntrada(Nome),
	exibeEquipavel(Nome).

detalheItem("2") :-
    writeln('Qual o nome do Consumivel?'),
	readEntrada(Nome),
	exibeConsumivel(Nome).

detalheItem(_) :-
    write('tipo de item so pode ser \'1\' ou \'2\''),
    menuItem("4").

excluiItem("1") :-
    writeln('Qual o nome do Equipavel?'),
    readEntrada(Nome),
    retractall_equipavel(Nome, _, _, _, _, _, _, _, _, _),
    retractall_equipavelTemHabilidade(Nome, _),
    retractall_lojaTemEquipavel(_, Nome, _),
    retractall_personagemTemEquipavel(_, Nome).

excluiItem("2") :-
    writeln('Qual o nome do Consumivel?'),
    readEntrada(Nome),
    deletaConsumivel(Nome).

excluiItem(_) :- 
    writeln('tais trolando brother?').

deletaConsumivel(Nome) :-
    retractall_consumivel(Nome, _, _, _),
    retractall_personagemTemConsumivel(_, Nome, _),
    retractall_lojaTemConsumivel(_, Nome, _).

cadastraItem("1") :-
    nl, writeln('Qual o nome do Equipavel?'),
    readEntrada(Nome),
    writeln('Qual a Alteracao de Vida Maxima?'),
    readEntradaInt(Vida_maxima),
    writeln('Qual a Alteracao de Forca?'),
    readEntradaInt(Forca),
    writeln('Qual a Alteracao de Inteligencia?'),
    readEntradaInt(Inteligencia),
    writeln('Qual a Alteracao de Sabedoria?'),
    readEntradaInt(Sabedoria),
    writeln('Qual a Alteracao de Destreza?'),
    readEntradaInt(Destreza),
    writeln('Qual a Alteracao de Constituicao?'),
    readEntradaInt(Constituicao),
    writeln('Qual a Alteracao de Carisma?'),
    readEntradaInt(Carisma),
    writeln('Qual a Alteracao de Velocidade?'),
    readEntradaInt(Velocd),
    writeln('Onde sera Equipavel (Cabeca | Torso | Pernas | Maos | Arma) ?'),
    readEntrada(Tipo),
    tipoEquipavel(Tipo),
    tenta_tirar(Nome),
    assert_equipavel(Nome, Vida_maxima, Forca, Inteligencia, Sabedoria, Destreza, Constituicao, Carisma, Velocd, Tipo),
    writeln('Item cadastrado com sucesso.\nEnter para continuar').

tenta_tirar(Nome) :-
    retractall_equipavel(Nome, _, _, _, _, _, _, _, _, _).
tenta_tirar(_).

tenta_tirar_consmvl(Nome) :-
    retractall_consumivel(Nome, _, _, _).
tenta_tirar_consmvl(_).

cadastraItem("2") :-
    nl, writeln('Qual o nome do Consumivel?'),
    readEntrada(Nome),
    writeln('Qual a Alteracao de Vida?'),
    readEntradaInt(Vida),
    writeln('Qual a Alteracao de Velocidade?'),
    readEntradaInt(Velocidade),
    writeln('Qual a Durabilidade?'),
    readEntradaInt(Durac),
    tenta_tirar_consmvl(Nome),
	assert_consumivel(Nome, Vida, Velocidade, Durac),
    writeln('Item cadastrado com sucesso.\nEnter para continuar').

cadastraItem(_) :-
    writeln('\nEntrada invalida').


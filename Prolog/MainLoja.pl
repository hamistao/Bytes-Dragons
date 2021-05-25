menuLoja :-
    write('\e[H\e[2J'),
    writeln(  '  _______________'),
    writeln(  ' /     Loja     /'),
    writeln(  '/______________/'),
    writeln(  '| |  _[___]_   |'),
    writeln(  '| |__( o_o )___|'),
    writeln(  '| /    /|\\    |'),
    writeln(  '|/_____________|'),
    writeln(  '| |            |'),
    writeln(  '|              |'),
    writeln(  '1 - Listar Lojas\n2 - Criar Loja\n3 - Adiciona um item na Loja\n4 - Detalhes de Loja\n5 - Excluir Loja\n6 - Negociar com a Loja\n9 - Voltar Menu\n'),
    readEntrada(Entrada),
    menuLoja(Entrada).

menuLoja("1") :-
	writeln("Lojas disponiveis:")
	listarLojas,
	readEntrada(_),
	menuLoja.

menuLoja("2") :-
    writeln('Qual o nome da loja?'),
    readEntrada(Nome),
	tentaRemoverLoja(Nome),
	assert_loja(Nome),
    readEntrada(_),
	menuLoja.

menuLoja("3") :-
	opcaoDeItem(Tipo),
	adicionaItemLoja(Tipo),
    readEntrada(_),
	menuLoja.

menuLoja("4") :-
    writeln('Qual o nome da loja?'),
    readEntrada(Nome),
	exibeLoja(Nome),
    writeln('\nEnter para continuar'),
    readEntrada(_),
	menuLoja.

menuLoja("5") :-
    writeln('Qual o nome da loja?'),
    readEntrada(Nome),
	retract_loja(Nome),
    writeln('Loja excluida com sucesso.'),
    readEntrada(_),
	menuLoja.

menuLoja(_) :-
    writeln('\nEntrada invalida amigao.'),
    menuLoja.

excluiLoja(_) :-
	writeln('sem essa brother').

cadastraLoja :-
    nl, writeln('Qual o nome da loja?'),
    readEntrada(Nome),
    open('data/loja.bd', append, Str),
    construtorLojaString(Nome, Loja),
    writeln(Loja),
    write(Str, Loja), writeln(Str, ".").

detalheLoja :-
    writeln('Qual o ID da loja?'),
    exibeFromFile('data/loja.bd').

detalheLoja(X) :-
    write('o id - '),
    write(X),
    writeln(' - Id Invalido bro').

excluiLoja :-
	readEntrada(Id),
	atom_number(Id, Desejado),
	removeItemFromFile('data/loja.bd', Desejado).

tentaRemoverLoja(Nome) :-
	retract_loja(Nome).
tentaRemoverLoja(_).

opcaoDeItem(Tipo) :-
    writeln('1 - Equipavel \nou \n2 - Consumivel?'),
    nl, readEntrada(Tipo).

adicionaItemLoja("1") :-
    writeln('Qual o nome da loja?'),
    readEntrada(Loja),
    writeln('Qual o nome do Equipavel?'),
    readEntrada(Equipavel),
	assert_lojaTemEquipavel(Loja, Equipavel),
	writeln("Item adicionado a loja com sucesso\nEnter para continuar").

adicionaItemLoja("2") :-
    writeln('Qual o nome da loja?'),
    readEntrada(Loja),
    writeln('Qual o nome do Consumivel?'),
    readEntrada(Consumivel),
	assert_lojaTemConsumivel(Loja, Consumivel),
	writeln("Item adicionado a loja com sucesso\nEnter para continuar").

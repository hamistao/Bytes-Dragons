%:- include('Loja.pl').

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
    read(_).

menuLoja(_) :-
    writeln('\nEntrada invalida amigao.'),
    menuLoja.
    
menuLoja("1") :-
    structsFromFile('data/loja.info', LojasStr),
	listarLojas(LojasStr, ListaLojas),
	nl, writeln('Lojas disponiveis:'),
	writeComId(ListaLojas, 1),
	readEntrada(_),
	menuLoja.

menuLoja("2") :-
	cadastraLoja,
    writeln('Loja cadastrada com sucesso.\nEnter para continuar'),
    readEntrada(_),
	menuLoja.

menuLoja("4") :-
	detalheLoja,
    writeln('\nEnter para continuar'),
    readEntrada(_),
	menuLoja.

menuLoja("5") :-
	excluiLoja,
    writeln('Loja excluida com sucesso.'),
    readEntrada(_),
	menuLoja.

excluiLoja(_) :-
	writeln('sem essa brother').

cadastraLoja :-
    nl, writeln('Qual o nome da loja?'),
    readEntrada(Nome),
    open('data/loja.info', append, Str),
    construtorLojaString(Nome, Loja),
    writeln(Loja),
    write(Str, Loja), writeln(Str, ".").

detalheLoja :-
    writeln('Qual o ID da loja?'),
    exibeFromFile('data/loja.info').

detalheLoja(X) :-
    write('o id - '),
    write(X),
    writeln(' - Id Invalido bro').

excluiLoja :-
	readEntrada(Id),
	atom_number(Id, Desejado),
	removeItemFromFile('data/loja.info', Desejado).

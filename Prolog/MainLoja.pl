:- include('Loja.pl').
:- include('Personagem.pl').

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
	writeln("Lojas disponiveis:"),
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
	loja(Nome),
	exibeLoja(Nome),
    writeln('\nEnter para continuar'),
    readEntrada(_),
	menuLoja.

menuLoja("5") :-
    writeln('Qual o nome da loja?'),
    readEntrada(Nome),
	retractall_loja(Nome),
	retractall_lojaTemConsumivel(Nome, _, _),
	retractall_lojaTemEquipavel(Nome, _, _),
    writeln('Loja excluida com sucesso.'),
    readEntrada(_),
	menuLoja.

menuLoja("6") :-
    writeln('Qual o nome da loja?'),
    readEntrada(Loja),
	loja(Loja),
	writeln('Qual o nome do personagem?'),
	readEntrada(Personagem),
	personagem(Personagem, _, _, _, _, _, _, _, _, _, _, _, Ouro, _, _, _),
	opcaoDeNegociacao(TipoNegociacao),
	negociacao(TipoNegociacao, Loja, Personagem, Ouro),
    readEntrada(_),
	menuLoja.

menuLoja("9").

menuLoja(_) :-
    writeln('\nEntrada invalida amigao.'),
    menuLoja.

tentaRemoverLoja(Nome) :-
	retractall_loja(Nome).
tentaRemoverLoja(_).

opcaoDeItem(Tipo) :-
    writeln('1 - Equipavel \nou \n2 - Consumivel?'),
    nl, readEntrada(Tipo).

opcaoDeNegociacao(TipoNegociacao) :-
    writeln('1 - Comprar \nou \n2 - Vender?'),
    nl, readEntrada(TipoNegociacao).

negociacao("1", Loja, Personagem, Ouro) :-
	opcaoDeItem(Tipo),
	comprar(Tipo, Loja, Personagem, Ouro).

negociacao("2", Loja, Personagem, Ouro) :-
	opcaoDeItem(Tipo),
	vender(Tipo, Loja, Personagem, Ouro).

comprar("1", Loja, Personagem, Ouro) :-
	writeln("A loja tem estes equipaveis:"),
	listarEquipaveisLoja(Loja),
	nl, writeln("Qual o nome do equipavel que deseja comprar?"),
	readEntrada(Equipavel),
	equipavel(Equipavel, _, _, _, _, _, _, _, _, _),
	lojaTemEquipavel(Loja, Equipavel, Preco),
	atom_number(Preco, PrecoInt),
	Ouro >= PrecoInt,
	aumentaOuro(Personagem, (-1 * PrecoInt)),
	retractall_lojaTemEquipavel(Loja, Equipavel, _),
	assert_personagemTemEquipavel(Personagem, Equipavel),
	writeln('Item comprado com sucesso\nEnter para continuar').

comprar("2", Loja, Personagem, Ouro) :-
	writeln("A loja tem estes consumiveis:"),
	listarConsumiveisLoja(Loja),
	nl, writeln("Qual o nome do consumivel que deseja comprar?"),
	readEntrada(Consumivel),
	consumivel(Consumivel, _, _, Duracao),
	lojaTemConsumivel(Loja, Consumivel, Preco),
	atom_number(Preco, PrecoInt),
	Ouro >= PrecoInt,
	aumentaOuro(Personagem, (-1 * PrecoInt)),
	retractall_lojaTemConsumivel(Loja, Consumivel, _),
	assert_personagemTemConsumivel(Personagem, Consumivel, Duracao),
	writeln('Item comprado com sucesso\nEnter para continuar').

vender("1", _, Personagem, _) :-
	writeln("Qual o nome do equipavel que deseja vender?"),
	readEntrada(Equipavel),
	equipavel(Equipavel, _, _, _, _, _, _, _, _, _),
	personagemTemEquipavel(Personagem, Equipavel),
	writeln("Por qual preco deseja vender esse item?"),
	readEntrada(Preco),
	atom_number(Preco, PrecoInt),
	retractall_personagemTemEquipavel(Personagem, Equipavel),
	aumentaOuro(Personagem, PrecoInt),
	writeln('Item vendido com sucesso\nEnter para continuar').

vender("2", _, Personagem, _) :-
	writeln("Qual o nome do consumivel que deseja vender?"),
	readEntrada(Consumivel),
	consumivel(Consumivel, _, _, _),
	personagemTemConsumivel(Personagem, Consumivel, _),
	writeln("Por qual preco deseja vender esse item?"),
	readEntrada(Preco),
	atom_number(Preco, PrecoInt),
	retractall_personagemTemConsumivel(Personagem, Consumivel, _),
	aumentaOuro(Personagem, PrecoInt),
	writeln('Item vendido com sucesso\nEnter para continuar').

adicionaItemLoja("1") :-
    writeln('Qual o nome da loja?'),
    readEntrada(Loja),
	loja(Loja),
    writeln('Qual o nome do Equipavel?'),
    readEntrada(Equipavel),
	equipavel(Equipavel, _, _, _, _, _, _, _, _, _),
    writeln('Qual o preco?'),
    readEntrada(Preco),
	assert_lojaTemEquipavel(Loja, Equipavel, Preco),
	writeln("Item adicionado a loja com sucesso\nEnter para continuar").

adicionaItemLoja("2") :-
    writeln('Qual o nome da loja?'),
    readEntrada(Loja),
	loja(Loja),
    writeln('Qual o nome do Consumivel?'),
    readEntrada(Consumivel),
	consumivel(Consumivel, _, _, _),
    writeln('Qual o preco?'),
    readEntrada(Preco),
	assert_lojaTemConsumivel(Loja, Consumivel, Preco),
	writeln("Item adicionado a loja com sucesso\nEnter para continuar").

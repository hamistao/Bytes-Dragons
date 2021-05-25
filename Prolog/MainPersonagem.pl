:- include('Personagem.pl').
:- include('MainBatalha.pl').

menuPersg :-
    write('\e[H\e[2J'),
    writeln(  '  ,   A           {}'),
    writeln(  ' / \\, | ,        .--.'),
    writeln(  '|    =|= >      /.--.\\ '),
    writeln(  ' \\ /` | `       |====|'),
    writeln(  '  `   |         |`::`| ' ),
    writeln(  '      |     .-;`\\..../`;_.-^-._'),
    writeln(  '     /\\ \\/ /  |...::..|`   :   `|'),
    writeln(  '     |:\'\\ |   /\'\'\'::\'\'|   .:.   |'),
    writeln(  '      \\ /\\;-,/\\.  ::  |..:::::..|'),
    writeln(  '      |\\ <` >  >._::_.| \':::::\' |'),
    writeln(  '      | `""`  /   ^^  |   \':\'   |'),
    writeln(  '      |       |       \\    :    /'),
    writeln(  '      |       |        \\   :   /' ),
    writeln(  '      |       |___/\\___|`-.:.-`'),
    writeln(  '      |        \\_ || _/    `'),
    writeln(  '      |        <_ >< _>'),
    writeln(  '      |        |  ||  |'),
    writeln(  '      |        |  ||  |'),
    writeln(  '      |       _\\.:||:./_'),
    writeln(  '      | jgs  /____/\\____\\'),
    writeln(  '1 - Listar Personagens\n2 - Criar Personagem\n3 - Detalhes de Personagem\n4 - Excluir Personagem\n5 - Menu de Relacao Item/Habilidade com Personagem\n6 - Especificar Resistencias\n7 - Inicar Batalha entre Personagens\n9 - Voltar Menu\n'),
    readEntrada(Entrada),
    menuPersg(Entrada).


menuPersg("1") :-
    writeln('Personagens: '),
    listarPersonagens,
    readEntrada(_),
    menuPersg.

menuPersg("2") :-
    nl, writeln('Qual o Nome do Personagem?'),
    readEntrada(Nome),
    writeln('Qual a Classe do Personagem?'),
    readEntrada(Classe),
    checkClasse(Classe),
    writeln('Qual a Raca do Personagem?'),
    readEntrada(Raca),
    checkRaca(Raca),
    constroiPersonagem(Nome, Classe, Raca),
    write('Personagem criado <3'),
    readEntrada(_),
    menuPersg.    

menuPersg("3") :-
    writeln('Qual o Nome do Personagem desejado?'),
    readEntrada(Nome),
    exibePersonagem(Nome),
    readEntrada(_), menuPersg.

menuPersg("4") :-
    writeln('Qual o Nome do Personagem a ser deletado?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    deletaPersonagem(Nome),
    write('Personagem deletado'),
    readEntrada(_), menuPersg.

deletaPersonagem(Nome) :-
    retractall_personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    retractall_personagemTemConsumivel(Nome, _, _),
    retractall_personagemTemEquipavel(Nome, _),
    retractall_personagemTemHabilidade(Nome, _).


menuPersg("5") :-
    menuItemPersonagem,
    menuPersg.

menuPersg("6") :-
    writeln('Qual a Resistencia? (Cortante | Magico | Venenoso | Fogo | Gelo | Fisico)'),
    readEntrada(Tipo),
    writeln('Qual o Nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    assert_personagemTemResistencia(Nome, Tipo),
    write('Resistencia concedida'),
    readEntrada(_), menuPersg.


menuPersg("7") :-
    menuBatalha,
    menuPersg.


menuPersg("9").

menuPersg(_):-
    menuPersg.


constroiPersonagem(Nome, Classe, Raca) :-
    retractall_personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    criaPersonagem(Nome, Classe, Raca).
constroiPersonagem(Nome, Classe, Raca) :-
    criaPersonagem(Nome, Classe, Raca).



checkRaca(Raca):-
    isRaca(Raca).
checkRaca(R):-
    string_concat(R, ' nao eh uma raca valida', S),
    writeln(S),!,
    readEntrada(_),
    false.


checkClasse(Classe):-
    isClasse(Classe).
checkClasse(C) :-
    string_concat(C, ' nao eh uma classe valida', S),
    writeln(S),!,
    readEntrada(_),
    false.


menuItemPersonagem :-
    write('\e[H\e[2J'),
    writeln(  '  ,   A           {}'),
    writeln(  ' / \\, | ,        .--.'),
    writeln(  '|    =|= >      /.--.\\ '),
    writeln(  ' \\ /` | `       |====|'),
    writeln(  '  `   |         |`::`| ' ),
    writeln(  '      |     .-;`\\..../`;_.-^-._'),
    writeln(  '     /\\ \\/ /  |...::..|`   :   `|'),
    writeln(  '     |:\'\\ |   /\'\'\'::\'\'|   .:.   |'),
    writeln(  '      \\ /\\;-,/\\.  ::  |..:::::..|'),
    writeln(  '      |\\ <` >  >._::_.| \':::::\' |'),
    writeln(  '      | `""`  /   ^^  |   \':\'   |'),
    writeln(  '      |       |       \\    :    /'),
    writeln(  '      |       |        \\   :   /' ),
    writeln(  '      |       |___/\\___|`-.:.-`'),
    writeln(  '      |        \\_ || _/    `'),
    writeln(  '      |        <_ >< _>'),
    writeln(  '      |        |  ||  |'),
    writeln(  '      |        |  ||  |'),
    writeln(  '      |       _\\.:||:./_'),
    writeln(  '      | jgs  /____/\\____\\'),
    writeln(  '1 - Equipar Item\n2 - Equipar Consumivel\n3 - Alocar Habilidade\n4 - Desequipar Item\n5 - Desequipar Consumivel\n6 - Desalocar Habilidade\n9 - Voltar Menu\n'),
    readEntrada(Entrada),
    menuItemPersonagem(Entrada).

menuItemPersonagem("1"):-
    nl, writeln('Qual o nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    writeln('Qual o nome do Equipavel?'),
    readEntrada(Equipavel),
    equipavelExiste(Equipavel),
    \+tipoIndisponivel(Nome, Equipavel),
    colocaEquipavelPersonagem(Nome, Equipavel),
    writeln('Item equipado'),
    readEntrada(_),
    menuItemPersonagem.

menuItemPersonagem("2") :-
    nl, writeln('Qual o nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    writeln('Qual o nome do Consumivel?'),
    readEntrada(Consumivel),
    consumivel(Consumivel, _, _, Duracao),
    colocaConsumivelPersonagem(Nome, Consumivel, Duracao),
    writeln('Consumivel equipado'),
    readEntrada(_),
    menuItemPersonagem.

menuItemPersonagem("3") :-
    nl, writeln('Qual o nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    writeln('Qual o nome da Habilidade?'),
    readEntrada(Habilidade),
    habilidadeExiste(Habilidade),
    colocaHabilidadePersonagem(Nome, Habilidade),
    writeln('Habilidade alocada'),
    readEntrada(_),
    menuItemPersonagem.

menuItemPersonagem("4") :-
    nl, writeln('Qual o nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    writeln('Qual o nome da Equipavel?'),
    readEntrada(Equipavel),
    equipavelExiste(Equipavel),
    tiraEquipavelPersonagem(Nome, Equipavel),
    writeln('Item desequipado'),
    readEntrada(_),
    menuItemPersonagem.

menuItemPersonagem("5") :-
    nl, writeln('Qual o nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    writeln('Qual o nome da Consumivel?'),
    readEntrada(Consumivel),
    consumivelExiste(Consumivel),
    tiraConsumivelPersonagem(Nome, Consumivel),
    writeln('Consumivel desequipado'),
    readEntrada(_),
    menuItemPersonagem.

menuItemPersonagem("6") :-
    nl, writeln('Qual o nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    writeln('Qual o nome da Habilidade?'),
    readEntrada(Habilidade),
    habilidadeExiste(Habilidade),
    tiraHabilidadePersonagem(Nome, Habilidade),
    writeln('Habilidade Desalocada'),
    readEntrada(_),
    menuItemPersonagem.

menuItemPersonagem("9").

menuItemPersonagem(_):-
    writeln('\nEntrada invalida.'),
    readEntrada(_),
    menuItemPersonagem.


colocaHabilidadePersonagem(Nome, Habilidade) :-
	tentaTirarHabilidadePersonagem(Nome, Habilidade),
    assert_personagemTemHabilidade(Nome, Habilidade).

colocaConsumivelPersonagem(Nome, Consumivel, Duracao) :-
	tentaTirarConsumivelPersonagem(Nome, Consumivel),
    assert_personagemTemConsumivel(Nome, Consumivel, Duracao).

colocaEquipavelPersonagem(Nome, Equipavel) :-
	tentaTirarEquipavelPersonagem(Nome, Equipavel),
    assert_personagemTemEquipavel(Nome, Equipavel).

tipoIndisponivel(Nome, Equipavel) :-
    personagemTemEquipavel(Nome, Equipado),
    equipavel(Equipavel, _, _, _, _, _, _, _, _, Tipo),
    equipavel(Equipado, _, _, _, _, _, _, _, _, Tipo).

tiraEquipavelPersonagem(Nome, Equipavel).
    retractall_personagemTemEquipavel(Nome, Equipavel).
tiraEquipavelPersonagem(_, _).

tiraConsumivelPersonagem(Nome, Consumivel).
    retractall_personagemTemConsumivel(Nome, Consumivel, _).
tiraConsumivelPersonagem(_, _).

tiraHabilidadePersonagem(Nome, Habilidade).
    retractall_personagemTemHabilidade(Nome, Habilidade).
tiraHabilidadePersonagem(_, _).

personagemExiste(Nome) :-
    personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _).

consumivelExiste(Nome) :-
    consumivel(Nome, _, _, _).

habilidadeExiste(Nome) :-
    habilidade(Nome, _, _, _, _, _).

equipavelExiste(Nome) :-
    equipavel(Nome, _, _, _, _, _, _, _, _, _).

tentaTirarEquipavelPersonagem(Personagem, Equipavel) :-
	retractall_personagemTemEquipavel(Personagem, Equipavel).
tentaTirarEquipavelPersonagem(_).

tentaTirarConsumivelPersonagem(Personagem, Consumivel) :-
	retractall_personagemTemConsumivel(Personagem, Consumivel, _).
tentaTirarConsumivelPersonagem(_).

tentaTirarHabilidadePersonagem(Personagem, Habilidade) :-
	retractall_personagemTemHabilidade(Personagem, Habilidade).
tentaTirarHabilidadePersonagem(_).

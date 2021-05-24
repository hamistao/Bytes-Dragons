:- include('Personagem.pl').

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
    structsFromFile('data/persngs.bd', Personagens),
    listaPersonagens(Personagens, PersonagensNomes),
    writeln('Personagens: '),
    stringFromList(PersonagensNomes, PersonagensStr),
    writeln(PersonagensStr),
    readEntrada(_),!,
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
    open('data/persngs.bd', append, Str),
    construtorPersonagem(Nome, Raca, Classe, Personagem),
    writeln(Personagem),
    write(Str, Personagem), writeln(Str, "."),!,
    close(Str),
    menuPersg.

menuPersg("3") :-
    writeln('Qual o Nome do Personagem desejado?'),
    readEntrada(Nome),
    structsFromFile('data/persngs.bd', Personagens),
    exibeByName(Personagens, Nome),!,
    menuPersg.


menuPersg("4") :-
    writeln('Qual o Nome do Personagem a ser deletado?'),
    readEntrada(Nome),
    structsFromFile('data/persngs.bd', Personagens),
    deleteByName(Personagens, Nome, PersonagensFinais),
    open('data/persngs.bd', write, Str),
    writeLinesToFile(Str, PersonagensFinais), !,
    close(Str), menuPersg.


menuPersg("9").

menuPersg(_):-
    menuPersg.



checkRaca(Raca):-
    isRaca(Raca).
checkRaca(R):-
    string_concat(R, ' nao eh uma raca valida', S),
    writeln(S),!,
    false.


checkClasse(Classe):-
    isClasse(Classe).
checkClasse(C) :-
    string_concat(C, ' nao eh uma classe valida', S),
    writeln(S),!,
    false.
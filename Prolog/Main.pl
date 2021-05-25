:- use_module(library(persistency)).
:- initialization(init).

init :-
	absolute_file_name('./data/database.db', File, [access(write)]),
	db_attach(File, []).

:- include('MainHabilidade.pl').
:- include('MainItem.pl').
:- include('MainLoja.pl').
:- include('MainPersonagem.pl').

main :- 
    menu('start'),
    halt.


menu('start') :-
    foreach(participaDaBatalha(N), retract_participaDaBatalha(N)),
    criaArquivos,
    menu('go').

menu('go') :-
    write('\e[H\e[2J'),
    write('\e[H\e[2J'),
    writeln('                  ______________'),
    writeln('            ,===:\'.,            `-._'),
    writeln('                 `:.`---.__         `-._'),
    writeln('                   `:.     `--.         `.'),
    writeln('                     \\         `.         `.'),
    writeln('             (,,(,    \\          `.   ____,-`.,'),
    writeln('          (,\'     `/   \\    ,--.___`.\''),
    writeln('       ( ,\'   ,--.  `,  \\ ;\'         `'),
    writeln('      {,O {      \\   :   \\;'),
    writeln('        \\  ,,\'    /  /    //'),
    writeln('         |;;    /  ,\' ,-//.    ,---.      ,'),
    writeln('        \\;\'   /  ,\' /  _  \\   /  _  \\    ,\'/'),
    writeln('             \\    `\'  / \\   `\'  / \\   `.\' /'),
    writeln('                `.___,\'   `.__,\'   `.__,\'  VZ '),
    writeln('1 - Ler Campanha\n2 - Definir Lore da campanha\n3 - Menu de Personagem\n4 - Menu de Item\n5 - Menu de Habilidades\n6 - Loja\n9 - Sair\n'),
    readEntrada(Entrada),
    menu(Entrada).

menu("1") :-
    readLore('data/campanha.lore'),
    menu('go').

menu("2") :-
    writeLore('data/campanha.lore'),
    menu('go').

menu("3") :-
    menuPersg,
    menu('go').

menu("4") :-
    menuItem,
    menu('go').

menu("5") :-
    menuHabilis,
    menu('go').

menu("6") :-
    menuLoja,
    menu('go').

menu("9") :-
    writeln('Programa Encerrado').

menu(X) :-
    write('A entrada: '),
    write(X),
    writeln('. Nao eh valida.'),
    write('vlw flw. ps eu te amo').


criaArquivos :-
    createFile('data/campanha.lore').


createFile(Path) :-
    \+ exists_file(Path),
    open(Path, write, Out),
    write(Out, ''),
    close(Out).

createFile(_).


readLore(Path) :-
    linesFromFile(Path, Lines),
    printList(Lines),
    readEntrada(_).


printList([]).
printList([X|L]) :-
    writeln(X),
    printList(L).


linesFromFile(Path, Lines) :-
    open(Path, read, Str),
    read_file(Str, Lines),!,
    close(Str).


read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream, Codes),
    atom_chars(X, Codes),
    read_file(Stream, L).


writeLore(Path):-
    open(Path, write, Str),
    writeln('Digite "fim" para encerrar concluir a escrita da lore.'),
    readEntrada(Entrada),
    writeMultipleLines(Str, Entrada),
    close(Str).


writeMultipleLines(_, "fim").

writeMultipleLines(Str, Linha):-
    writeln(Str, Linha),
    readEntrada(ProximaLinha),
    writeMultipleLines(Str, ProximaLinha).
    

readEntrada(Entrada) :-
    read_line_to_codes(user_input, E),
    atom_string(E, Entrada).


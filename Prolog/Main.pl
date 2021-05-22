:- include('MainHabilidade.pl').
:- include('MainItem.pl').
:- include('MainLoja.pl').
:- include('MainPersonagem.pl').
:- include('Util.pl').

main :- 
    menu('start'),
    halt.


menu('start') :-
    criaArquivos,
    menu('go').

menu('go') :-
    cls,
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
    read(Entrada),
    menu(Entrada).

menu(3) :-
    menuPersg(),
    menu('go').

menu(4) :-
    menuItem(),
    menu('go').

menu(5) :-
    menuHabilis(),
    menu('go').

menu(6) :-
    menuLoja(),
    menu('go').

menu(9) :-
    writeln('Programa Encerrado').

menu(X) :-
    write('A entrada: '),
    write(X),
    writeln('. Nao eh valida.'),
    write('vlw flw. ps eu te amo').


criaArquivos :-
    createFile('data/persngs.bd'),
    createFile('data/consmvl.info'),
    createFile('data/equip.info'),
    createFile('data/habil.info'),
    createFile('data/loja.bd'),


createFile(Path) :-
    \+ exists_file(Path),
    open(Path, write, Out),
    write(Out, ''),
    close(Out).



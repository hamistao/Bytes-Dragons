main :- 
    menu('start'),
    halt.


menu('start') :-
    criaArquivos,
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

menu(X) :-
    write('A entrada: '),
    write(X),
    writeln('. Nao eh valida.'),
    write('vlw flw. ps eu te amo').


criaArquivos :-
    writeln('Falta implementar criacao de arquivos'),
    read(_).
    
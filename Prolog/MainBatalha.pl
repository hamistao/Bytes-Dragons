:- include('Batalha.pl').

menuBatalha :-
    ln, writeln('Quais os personagens que irao batalhar?'),
    readEntrada(NomePersonagem1),
    readEntrada(NomePersonagem2),
    writeln('Digita enter ai'),
    readEntrada(_),
    menuBatalha.


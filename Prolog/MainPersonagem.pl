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
    read(_).


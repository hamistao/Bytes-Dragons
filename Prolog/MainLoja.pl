:- include('Util.pl').

menuLoja :-
    cls,
    writeln(  '  _______________'),
    writeln(  ' /     Loja     /'),
    writeln(  '/______________/'),
    writeln(  '| |  _[___]_   |'),
    writeln(  '| |__( o_o )___|'),
    writeln(  '| /    /|\\     |'),
    writeln(  '|/_____________|'),
    writeln(  '| |            |'),
    writeln(  '|              |'),
    writeln(  '1 - Listar Lojas\n2 - Criar Loja\n3 - Adiciona um item na Loja\n4 - Detalhes de Loja\n5 - Excluir Loja\n6 - Negociar com a Loja\n9 - Voltar Menu\n'),
    read(_).
    
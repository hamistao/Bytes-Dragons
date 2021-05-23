:- include('Habilidade.pl').

menuHabilis :-
    write('\e[H\e[2J'),
    writeln( '           ('),
    writeln( '            )'),
    writeln( '           (  ('),
    writeln( '               )'),
    writeln( '         (    (  ,,'),
    writeln( '          ) /\\ (('),
    writeln( '        (  // | (`\''),
    writeln( '      _ -.;_/\\ \\--._'),
    writeln( '     (_;-// | \\ \\-\'.\\'),
    writeln( '     ( `.__ _  ___,\')'),
    writeln( 'jrei  `\'(_ )_)(_)_)\n'),
    writeln( '1 - Listar Habilidades\n2 - Criar Habilidade\n3 - Detalhes de Habilidade\n4 - Excluir Habilidade\n5 - Encatar um Item\n6 - Desencanta um Item\n9 - Voltar Menu\n'),
    readEntrada(Entrada),
    menuHabilis(Entrada).

menuHabilis("1"):-
    structsFromFile('data/habil.info', Habilidades),
    listaHabilidades(Habilidades, ListaHabilidades),
    nl, writeln('Habilidades:'),
    writeComId(ListaHabilidades, 1),
    readEntrada(_),
    menuHabilis.

menuHabilis("2"):-
    nl, writeln('Qual o nome da habilidade?'),
    readEntrada(Nome),
    writeln('Qual o impacto na vida?'),
    readEntrada(ImpactoVida),
    writeln('Qual o impacto na velocidade?'),
    readEntrada(ImpactoVelocidade),
    writeln('Qual o Atributo da Habilidade (Forca | Inteligencia | Sabedoria | Destreza | Constituicao | Carisma) ?'),
    readEntrada(AtributoRelacionado),
    writeln('Quantos pontos sao nececessarios para o acerto da habilidade?'),
    readEntrada(PontosParaAcerto),
    writeln('Qual o tipo de dano da habilidade (Cortante | Magico | Venenoso | Fogo | Gelo | Fisico) ?'),
    readEntrada(TipoDeDano),
    open('data/habil.info', append, Str),
    construtorHabilidade(Nome, ImpactoVida, ImpactoVelocidade, AtributoRelacionado, PontosParaAcerto, TipoDeDano, Habilidade),
    writeln(Habilidade),
    write(Str, Habilidade), writeln(Str, "."),
    writeln('Habilidade cadastrada com sucesso.\nEnter para continuar'),
    readEntrada(_),
    menuHabilis.

menuHabilis("3"):-
    writeln('Qual o id da Habilidade? '),
    exibeFromFile('data/habil.info'),
    readEntrada(_),
    menuHabilis.

menuHabilis("4"):-
    nl, writeln('Qual o ID da Habilidade?'),
    readEntrada(Id),
    atom_number(Id, Desejado),
    removeItemFromFile('data/habil.info', Desejado),
    write('Habilidade excluida com sucesso'),
    readEntrada(_),
    menuHabilis.
    
menuHabilis(_).

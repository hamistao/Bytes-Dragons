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
    writeln( '1 - Listar Habilidades\n2 - Criar Habilidade\n3 - Detalhes de Habilidade\n4 - Excluir Habilidade\n9 - Voltar Menu\n'),
    readEntrada(Entrada),
    menuHabilis(Entrada).

menuHabilis("1"):-
    nl, writeln('Habilidades:'),
    listarHabilidades,
    writeln('\nEnter para continuar'),
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
    assert_habilidade(Nome, ImpactoVida, ImpactoVelocidade, AtributoRelacionado, PontosParaAcerto, TipoDeDano),
    writeln('Habilidade cadastrada com sucesso.\nEnter para continuar'),
    writeln('\nEnter para continuar'),
    readEntrada(_),
    menuHabilis.

menuHabilis("3"):-
    writeln('Qual o nome da habilidade?'),
	readEntrada(Nome),
	exibeHabilidade(Nome).
    readEntrada(_),
    menuHabilis.

menuHabilis("4"):-
    nl, writeln('Qual o nome da Habilidade?'),
    readEntrada(Nome),
    retract_habilidade(Nome, _, _, _, _, _).
    writeln('Habilidade excluida com sucesso'),
    readEntrada(_),
    menuHabilis.
    
menuHabilis("9").

menuHabilis(_):-
    writeln('\nEntrada invalida.'),
    menuHabilis.

:- use_module(library(persistency)).

:- persistent consumivel(nome:any, raca:any, classe:any, vidaMaxima:any, vida:any, forca:any, inteligencia:any, sabedoria:any,
    destreza:any, constituicao:any, carisma:any, velocidade:any, ouro:any, xp:any, xpUp:any, nivel:any).
:- persistent personagemTemEquipavel(nomePersonagem:any, nomeEquipavel:any).
:- persistent personagemTemConsumivel(nomePersonagem:any, nomeConsumivel:any).
:- persistent personagemTemHabilidade(nomePersonagem:any, nomeHabilidade:any).
:- persistent personagemTemResistencia(nomePersonagem:any, nomeResistencia:any).

:- initialization(init).

init :-
	absolute_file_name('data/persngs.db', File, [access(write)]),
	db_attach(File, []).

exibePersonagem(Nome) :-
    personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
    Carisma, Velocidade, Ouro, Xp, XpUp, Nivel, Equipaveis, Consumiveis, Habilidades, Imunidades, Resistencias),
    nl, write("Nome: "),
	writeln(Nome),
	write("Raca: "),
	writeln(Raca),
    write("Classe: "),
    writeln(Classe),
    write("Vida: "),
    write(Vida),
    write("/"),
    writeln(VidaMaxima),
    write("Forca: "),
    writeln(Forca),
    write("Inteligencia: "),
    writeln(Inteligencia),
    write("Sabedoria: "),
    writeln(Sabedoria),
    write("Destreza: "),
    writeln(Destreza),
    write("Constituicao: "),
    writeln(Constituicao),
    write("Carisma: "),
    writeln(Carisma),
    write("Velocidade: "),
    writeln(Velocidade),
    write("Ouro: "),
    writeln(Ouro),
    write("Xp: "),
    write(Xp),
    write("/"),
    writeln(XpUp),
    write("Nivel: "),
    writeln(Nivel),
    writeln("Itens:"),
    writeln("Equipaveis:"),
    listarEquipaveisPersonagem(Nome),
    writeln("Consumiveis: "),
    listarConsumiveisPersonagem(Nome),
    writeln("Habilidades: "),
    listarHabilidadesPersonagem(Nome),
    writeln("Resistencias: "),
    listarResistenciasPersonagem(Nome).

listarPersonagens :-
    foreach(equipavel(Nome, _, _, _, _, _, _, _, _, _), writeln(Nome)).

listarEquipaveisPersonagem(Nome) :-
    foreach(personagemTemEquipavel(Nome, Habilidade), writeln(Habilidade)).

listarConsumiveisPersonagem(Nome) :-
    foreach(personagemTemConsumivel(Nome, Habilidade), writeln(Habilidade)).

listarHabilidadesPersonagem(Nome) :-
    foreach(personagemTemHabilidade(Nome, Habilidade), writeln(Habilidade)).

listarResistenciasPersonagem(Nome) :-
    foreach(personagemTemResistencia(Nome, Habilidade), writeln(Habilidade)).

atributo("Forca").
atributo("Inteligencia").
atributo("Sabedoria").
atributo("Destreza").
atributo("Constituicao").
atributo("Carisma").
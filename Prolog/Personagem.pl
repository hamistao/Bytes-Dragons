:- persistent personagem(nome:any, raca:any, classe:any, vidaMaxima:any, vida:any, forca:any, inteligencia:any, sabedoria:any,
    destreza:any, constituicao:any, carisma:any, velocidade:any, ouro:any, xp:any, xpUp:any, nivel:any).
:- persistent personagemTemEquipavel(nomePersonagem:any, nomeEquipavel:any).
:- persistent personagemTemConsumivel(nomePersonagem:any, nomeConsumivel:any).
:- persistent personagemTemHabilidade(nomePersonagem:any, nomeHabilidade:any).
:- persistent personagemTemResistencia(nomePersonagem:any, nomeResistencia:any).

:- include('Raca.pl').
:- include('Classe.pl').

criaPersonagem(Nome, Raca, Classe) :-
    vidaMaxima(Classe, VidaMaximaClasse),
	vidaMaxima(Raca, VidaMaximaRaca),
	VidaMaxima is VidaMaximaClasse + VidaMaximaRaca,

    forca(Classe, ForcaClasse),
    forca(Raca, ForcaRaca),
    Forca is ForcaClasse + ForcaRaca,

    inteligencia(Classe, InteligenciaClasse),
    inteligencia(Raca, InteligenciaRaca),
    Inteligencia is InteligenciaClasse + InteligenciaRaca,

    sabedoria(Classe, SabedoriaClasse),
    sabedoria(Raca, SabedoriaRaca),
    Sabedoria is SabedoriaClasse + SabedoriaRaca,

    destreza(Classe, DestrezaClasse),
    destreza(Raca, DestrezaRaca),
    Destreza is DestrezaClasse + DestrezaRaca,

    constituicao(Classe, ConstituicaoClasse),
    constituicao(Raca, ConstituicaoRaca),
    Constituicao is ConstituicaoClasse + ConstituicaoRaca,

    carisma(Classe, CarismaClasse),
    carisma(Raca, CarismaRaca),
    Carisma is CarismaClasse + CarismaRaca,

    Velocidade is DestrezaClasse + DestrezaRaca - (ConstituicaoClasse + ConstituicaoRaca),
    
    assert_personagem(Nome, Raca, Classe, VidaMaxima, VidaMaxima, Forca, Inteligencia, Sabedoria, Destreza, Constituicao, Carisma, Velocidade, 0, 0, 1000, 1).

exibePersonagem(Nome) :-
    personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
    Carisma, Velocidade, Ouro, Xp, XpUp, Nivel),
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
    foreach(personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _), writeln(Nome)).

listarEquipaveisPersonagem(Nome) :-
    foreach(personagemTemEquipavel(Nome, Habilidade), writeln(Habilidade)).

listarConsumiveisPersonagem(Nome) :-
    foreach(personagemTemConsumivel(Nome, Habilidade), writeln(Habilidade)).

listarHabilidadesPersonagem(Nome) :-
    foreach(personagemTemHabilidade(Nome, Habilidade), writeln(Habilidade)).

listarResistenciasPersonagem(Nome) :-
    foreach(personagemTemResistencia(Nome, Habilidade), writeln(Habilidade)).

aumentaXp(Nome, XpAdicional) :-
    personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
        Carisma, Velocidade, Ouro, Xp, XpUp, Nivel),
    NewXp is Xp + XpAdicional,
    NewXp < XpUp,
    retract_personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    assert_personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
        Carisma, Velocidade, Ouro, NewXp, XpUp, Nivel).

aumentaXp(Nome, XpAdicional) :-
    personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
        Carisma, Velocidade, Ouro, Xp, XpUp, Nivel),
    NewXp is (Xp + XpAdicional - XpUp),
    NewXpUp is XpUp + 500,
    NewNivel is Nivel + 1,
    retract_personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    assert_personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
        Carisma, Velocidade, Ouro, NewXp, NewXpUp, NewNivel).

atributo("Forca").
atributo("Inteligencia").
atributo("Sabedoria").
atributo("Destreza").
atributo("Constituicao").
atributo("Carisma").
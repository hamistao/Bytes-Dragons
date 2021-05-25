:- persistent personagem(nome:any, raca:any, classe:any, vidaMaxima:any, vida:any, forca:any, inteligencia:any, sabedoria:any,
    destreza:any, constituicao:any, carisma:any, velocidade:any, ouro:any, xp:any, xpUp:any, nivel:any).
:- persistent personagemTemEquipavel(nomePersonagem:any, nomeEquipavel:any).
:- persistent personagemTemConsumivel(nomePersonagem:any, nomeConsumivel:any, duracao:any).
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
    foreach(personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _), writeComMarcador(Nome)).

listarEquipaveisPersonagem(Nome) :-
    foreach(personagemTemEquipavel(Nome, Equipavel), writeComMarcador(Equipavel)).

listarConsumiveisPersonagem(Nome) :-
    foreach(personagemTemConsumivel(Nome, Consumivel, Duracao),
    (write("- Nome: "),
    writeln(Consumivel),
    write("  Duracao: "),
    writeln(Duracao))).

listarHabilidadesPersonagem(Nome) :-
    foreach(personagemTemHabilidade(Nome, Habilidade), writeComMarcador(Habilidade)).

listarResistenciasPersonagem(Nome) :-
    foreach(personagemTemResistencia(Nome, Resistencia), writeComMarcador(Resistencia)).

aumentaXp(Nome, XpAdicional) :-
    personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
        Carisma, Velocidade, Ouro, XpStr, XpUp, Nivel),
    atom_number(XpStr, Xp),
    NewXp is Xp + XpAdicional,
    NewXp < XpUp,
    retractall_personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    assert_personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
        Carisma, Velocidade, Ouro, NewXp, XpUp, Nivel).

aumentaXp(Nome, XpAdicional) :-
    personagem(Nome, Raca, Classe, VidaMaximaStr, VidaStr, ForcaStr, InteligenciaStr, SabedoriaStr, DestrezaStr, ConstituicaoStr,
        CarismaStr, VelocidadeStr, Ouro, XpStr, XpUpStr, NivelStr),
    NewVida is Vida + 20,
    NewVidaMaxima is VidaMaxima + 20,
    NewForca is Forca + 1,
    NewInteligencia is Inteligencia + 1,
    NewSabedoria is Sabedoria + 1,
    NewDestreza is Destreza + 1,
    NewConstituicao is Constituicao + 1,
    NewCarisma is Carisma + 1,
    NewVelocidade is Velocidade + 1,
    NewXp is (Xp + XpAdicional - XpUp),
    NewXpUp is XpUp + 500,
    NewNivel is Nivel + 1,
    retractall_personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    assert_personagem(Nome, Raca, Classe, NewVidaMaxima, NewVida, NewForca, NewInteligencia, NewSabedoria, NewDestreza, NewConstituicao,
        NewCarisma, NewVelocidade, Ouro, NewXp, NewXpUp, NewNivel).

aumentaOuro(Nome, OuroAdicional) :-
    personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
        Carisma, Velocidade, OuroStr, Xp, XpUp, Nivel),
    atom_number(OuroStr, Ouro),
    NewOuro is Ouro + OuroAdicional,
    retractall_personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    assert_personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
    Carisma, Velocidade, NewOuro, Xp, XpUp, Nivel).

atributoPersonagem(Emissor, "Forca", Valor) :-
    personagem(Emissor, _, _, _, _, Valor, _, _, _, _, _, _, _, _, _, _).

atributoPersonagem(Emissor, "Inteligencia", Valor).
    personagem(Emissor, _, _, _, _, _, Valor, _, _, _, _, _, _, _, _, _).

atributoPersonagem(Emissor, "Sabedoria", Valor).
    personagem(Emissor, _, _, _, _, _, _, Valor, _, _, _, _, _, _, _, _).

atributoPersonagem(Emissor, "Destreza", Valor).
    personagem(Emissor, _, _, _, _, _, _, _, Valor, _, _, _, _, _, _, _).

atributoPersonagem(Emissor, "Constituicao", Valor).
    personagem(Emissor, _, _, _, _, _, _, _, _, Valor, _, _, _, _, _, _).

atributoPersonagem(Emissor, "Carisma", Valor).
    personagem(Emissor, _, _, _, _, _, _, _, _, _, Valor, _, _, _, _, _).

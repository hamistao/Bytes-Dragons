:- include('Habilidade.pl').

construtorPersonagem(Nome, Raca, Classe, personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria,
    Destreza, Constituicao, Carisma, Velocidade, Ouro, Xp, XpUp, Nivel, Equipaveis, Consumiveis, Habilidades, Imunidades, Resistencias)) :-
        
        VidaMaxima is vidaMaxima(Classe) + vidaMaxima(Raca),
        Vida = VidaMaxima,

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

        Ouro = 0,
        Xp = 0,
        XpUp = 0,
        Nivel = 1,
        Equipaveis = [],
        Consumiveis = [],
        Habilidades = [],
        Imunidades = [],
        Resistencias = [].

exibePersonagem(personagem(Nome, Raca, Classe, VidaMaxima, Vida, Forca, Inteligencia, Sabedoria, Destreza, Constituicao,
    Carisma, Velocidade, Ouro, Xp, XpUp, Nivel, Equipaveis, Consumiveis, Habilidades, Imunidades, Resistencias), R) :-
        string_concat("\nNome: ", Nome, S1),
        string_concat(S1, "\nRaca: ", S2),
        string_concat(S2, Raca, S3),
        string_concat(S3, "\nClasse: ", S4),
        string_concat(S4, Classe, S5),
        string_concat(S5, "\nVida: ", S6),
        string_concat(S6, Vida, S7),
        string_concat(S7, "/", S8),
        string_concat(S8, VidaMaxima, S9),
        string_concat(S9, "\nForca: ", S10),
        string_concat(S10, Forca, S11),
        string_concat(S11, "\nInteligencia: ", S12),
        string_concat(S12, Inteligencia, S13),
        string_concat(S13, "\nSabedoria: ", S14),
        string_concat(S14, Sabedoria, S15),
        string_concat(S15, "\nDestreza: ", S16),
        string_concat(S16, Destreza, S17),
        string_concat(S17, "\nConstituicao: ", S18),
        string_concat(S18, Constituicao, S19),
        string_concat(S19, "\nCarisma: ", S20),
        string_concat(S20, Carisma, S21),
        string_concat(S21, "\nVelocidade: ", S22),
        string_concat(S22, Velocidade, S23),
        string_concat(S23, "\nOuro: ", S24),
        string_concat(S24, Ouro, S25),
        string_concat(S25, "\nXP: ", S26),
        string_concat(S26, Xp, S27),
        string_concat(S27, "/", S28),
        string_concat(S28, XpUp, S29),
        string_concat(S29, "\nNivel: ", S30),
        string_concat(S30, Nivel, S31),
        string_concat(S31, "\nItens:", S32),
        string_concat(S32, "\nEquipaveis:\n", S33),
        listarItem(Equipaveis, S34),
        stringFromList(S34, S35),
        string_concat(S33, S35, S36),
        string_concat(S36, "Consumiveis:\n", S37),
        listarItem(Consumiveis, S38),
        stringFromList(S38, S39),
        string_concat(S37, S39, S40),
        string_concat(S40, "Habilidades:\n", S41),
        listaHabilidades(Habilidades, S42)
        stringFromList(S42, S43),
        string_concat(S41, S43, S44),
        string_concat(S45, "Resistencias:\n", S46),
        stringFromList(Resistencias, S47),
        string_concat(S46, S47, R).

listaPersonagens([], []).
listaPersonagens([Personagem|L], R) :-
    listaPersonagens(L, R1),
    nomePersonagem(Personagem, Nome),
    string_concat("Nome: ", Nome, S),
    append([S], R1, R).

nomePersonagem(personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _), Nome).

isAtributo("Forca").
isAtributo("Inteligencia").
isAtributo("Sabedoria").
isAtributo("Destreza").
isAtributo("Constituicao").
isAtributo("Carisma").
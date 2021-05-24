construtorItemString(Nome, AlteracaoVida, AlteracaoVelocidadeConsumivel, Duracao, R):-
    string_concat('consumivel("', Nome, S1),
    string_concat(S1, '",', S2),
    string_concat(S2, AlteracaoVida, S3),
    string_concat(S3, ',', S4),
    string_concat(S4, AlteracaoVelocidadeConsumivel, S5),
    string_concat(S5, ',', S6),
    string_concat(S6, Duracao, R).

construtorItemString(NomeEquipavel, AlteracaoVidaMaxima, AlteracaoForca, AlteracaoInteligencia, AlteracaoSabedoria, AlteracaoDestreza, AlteracaoConstituicao, AlteracaoCarisma, AlteracaoVelocidadeEquipavel, TipoEquipavel, R):-
    string_concat('equipavel("', NomeEquipavel, S1),
    string_concat(S1, '",', S2),
    string_concat(S2, AlteracaoVidaMaxima, S3),
    string_concat(S3, ',', S4),
    string_concat(S4, AlteracaoForca, S5),
    string_concat(S5, ',', S6),
    string_concat(S6, AlteracaoInteligencia, S7),
    string_concat(S7, ',', S8),
    string_concat(S8, AlteracaoSabedoria, S9),
    string_concat(S9, ',', S10),
    string_concat(S10, AlteracaoDestreza, S11),
    string_concat(S11, ',', S12),
    string_concat(S12, AlteracaoConstituicao, S13),
    string_concat(S13, ',', S14),
    string_concat(S14, AlteracaoCarisma, S15),
    string_concat(S15, ',', S16),
    string_concat(S16, AlteracaoVelocidadeEquipavel, S17),
    string_concat(S17, ',"', S18),
    string_concat(S18, TipoEquipavel, S19),
    string_concat(S19, '",', S20),
    string_concat(S20, '[]', S21),
    string_concat(S21, ')', R).


isTipoEquipavel("Cabeca").
isTipoEquipavel("Torso").
isTipoEquipavel("Pernas").
isTipoEquipavel("Maos").
isTipoEquipavel("Arma").


listarItem([], []).
listarItem([Item|L], R) :-
    listarItem(L, R1),
    nomeItem(Item, Nome),
    string_concat("Nome: ", Nome, S),
    append([S], R1, R).
    

exibir(equipavel(NomeEquipavel, AlteracaoVida, AlteracaoForca, AlteracaoInteligencia, AlteracaoSabedoria, AlteracaoDestreza, AlteracaoConstituicao, AlteracaoCarisma, AlteracaoVelocidadeEquipavel, TipoEquipavel, Habilidades), R) :- 
    string_concat("\nNome: ", NomeEquipavel, S1),
    string_concat(S1, "\nAlteracao vida: ", S2),
    string_concat(S2, AlteracaoVida, S3),
    string_concat(S3, "\nAlteracao de forca: ", S4),
    string_concat(S4, AlteracaoForca, S5),
    string_concat(S5, "\nAlteracao de inteligencia: ", S6),
    string_concat(S6, AlteracaoInteligencia , S7),
    string_concat(S7, "\nAlteracao de sabedoria: ", S8),
    string_concat(S8, AlteracaoSabedoria, S9),
    string_concat(S9, "\nAlteracao de destreza: ", S10),
    string_concat(S10, AlteracaoDestreza, S11),
    string_concat(S11, "\nAlteracao de constituicao: ", S12),
    string_concat(S12, AlteracaoConstituicao, S13),
    string_concat(S13, "\nAlteracao de carisma: ", S14),
    string_concat(S14, AlteracaoCarisma, S15),
    string_concat(S15, "\nAlteracao de velocidade no equipavel: ", S16),
    string_concat(S16, AlteracaoVelocidadeEquipavel, S17),
    string_concat(S17, "\nTipo de equipavel: ", S18),
    string_concat(S18, TipoEquipavel, S19),
    string_concat(S19, "\nHabilidades:\n", S20),
    listaHabilidades(Habilidades, S21),
    stringFromList(S21, S22),
    string_concat(S20, S22, R).

exibir(X, Y) :-
    writeln(X),
    nomeEquipavel(X, Y).


exibir(consumivel(NomeConsumivel, AlteracaoVida, AlteracaoVelocidadeConsumivel, Duracao), R) :-
    string_concat("/nNome: ", NomeConsumivel, S1),
    string_concat(S1, "\nAlteracao de vida: ", S2),
    string_concat(S2, AlteracaoVida, S3),
    string_concat(S3, "\nAlteracao de velocidade: ", S4),
    string_concat(S4, AlteracaoVelocidadeConsumivel, S5),
    string_concat(S5, "\nduracao: ", S6),
    string_concat(S6, Duracao, R).
:- discontiguous exibir/2.
    


nomeItem(equipavel(NomeEquipavel, _, _, _, _, _, _, _, _, _, _), NomeEquipavel).   
nomeItem(consumivel(NomeConsumivel, _, _, _), NomeConsumivel).

encantaItem(equipavel(NomeEquipavel, AlteracaoVidaMaxima, AlteracaoForca, AlteracaoInteligencia, AlteracaoSabedoria, AlteracaoDestreza, AlteracaoConstituicao, AlteracaoCarisma, AlteracaoVelocidadeEquipavel, TipoEquipavel, Habilidades), Habilidade, R) :-
    string_concat('equipavel("', NomeEquipavel, S1),
    string_concat(S1, '",', S2),
    string_concat(S2, AlteracaoVidaMaxima, S3),
    string_concat(S3, ',', S4),
    string_concat(S4, AlteracaoForca, S5),
    string_concat(S5, ',', S6),
    string_concat(S6, AlteracaoInteligencia, S7),
    string_concat(S7, ',', S8),
    string_concat(S8, AlteracaoSabedoria, S9),
    string_concat(S9, ',', S10),
    string_concat(S10, AlteracaoDestreza, S11),
    string_concat(S11, ',', S12),
    string_concat(S12, AlteracaoConstituicao, S13),
    string_concat(S13, ',', S14),
    string_concat(S14, AlteracaoCarisma, S15),
    string_concat(S15, ',', S16),
    string_concat(S16, AlteracaoVelocidadeEquipavel, S17),
    string_concat(S17, ',"', S18),
    string_concat(S18, TipoEquipavel, S19),
    string_concat(S19, '",', S20),
    append(Habilidades, [Habilidade], NewHabilidades),
    string_concat(S20, NewHabilidades, S21),
    string_concat(S21, ')', R).

desencantaItem(equipavel(NomeEquipavel, AlteracaoVidaMaxima, AlteracaoForca, AlteracaoInteligencia, AlteracaoSabedoria, AlteracaoDestreza, AlteracaoConstituicao, AlteracaoCarisma, AlteracaoVelocidadeEquipavel, TipoEquipavel, Habilidades), Habilidade, R) :-
    string_concat('equipavel("', NomeEquipavel, S1),
    string_concat(S1, '",', S2),
    string_concat(S2, AlteracaoVidaMaxima, S3),
    string_concat(S3, ',', S4),
    string_concat(S4, AlteracaoForca, S5),
    string_concat(S5, ',', S6),
    string_concat(S6, AlteracaoInteligencia, S7),
    string_concat(S7, ',', S8),
    string_concat(S8, AlteracaoSabedoria, S9),
    string_concat(S9, ',', S10),
    string_concat(S10, AlteracaoDestreza, S11),
    string_concat(S11, ',', S12),
    string_concat(S12, AlteracaoConstituicao, S13),
    string_concat(S13, ',', S14),
    string_concat(S14, AlteracaoCarisma, S15),
    string_concat(S15, ',', S16),
    string_concat(S16, AlteracaoVelocidadeEquipavel, S17),
    string_concat(S17, ',"', S18),
    string_concat(S18, TipoEquipavel, S19),
    string_concat(S19, '",', S20),
    delete(Habilidades, Habilidade, NewHabilidades),
    string_concat(S20, NewHabilidades, S21),
    string_concat(S21, ')', R).
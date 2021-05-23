construtorItemConsumivel(Nome, AlteracaoVida, AlteracaoVelocidadeConsumivel, Duracao, consumivel(NomeConsumivel, AlteracaoVida, AlteracaoVelocidadeConsumivel, Duracao)).

construtorItemEquipavel(NomeEquipavel, AlteracaoVidaMaxima, AlteracaoForca, AlteracaoInteligencia, AlteracaoSabedoria, AlteracaoDestreza, AlteracaoConstituicao, AlteracaoCarisma, AlteracaoVelocidadeEquipavel, TipoEquipavel, equipavel(NomeEquipavel, AlteracaoVidaMaxima, AlteracaoForca, AlteracaoInteligencia, AlteracaoSabedoria, AlteracaoDestreza, AlteracaoConstituicao, AlteracaoCarisma, AlteracaoVelocidadeEquipavel, TipoEquipavel)).

isTipoEquipavel("Cabeca").
isTipoEquipavel("Torso").
isTipoEquipavel("Pernas").
isTipoEquipavel("Maos").
isTipoEquipavel("Arma").


listarEquipaveis([], []).
listarEquipaveis([Equipavel|L], R) :-
    listaEquipaveis(L, R1),
    nomeEquipavel(Equipavel, Nome),
    string_concat("Nome: ", Nome, S),
    string_concat(S, R1, R).
    

listarConsumiveis([], []).
listarConsumiveis([Consumivel | L], R):-
    listarConsumiveis(L, R1),
    nomeConsumivel(Consumivel, Nome),
    string_concat("Nome: ", Nome, S),
    string_concat(S, R1, R).
    

exibirEquipavel(equipavel(NomeEquipavel, AlteracaoVidaMaxima, AlteracaoForca, AlteracaoInteligencia, AlteracaoSabedoria, AlteracaoDestreza, AlteracaoConstituicao, AlteracaoCarisma, AlteracaoVelocidadeEquipavel, TipoEquipavel), R) :- 
    string_concat("/nNome: ", NomeEquipavel, S1),
    string_concat(S1, "\nAlteracao vida: ", S2),
    string_concat(S2, AlteracaoVida, S3),
    string_concat(S3, "\nAlteracao de forca", S4),
    string_concat(S4, AlteracaoForca, S5),
    string_concat(S5, "\nAlteracao de inteligencia: ", S6),
    string_concat(S6, AlteracaoInteligencia: , S7),
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
    string_concat(S18, TipoEquipavel, R).
    
exibirConsumivel(consumivel(NomeConsumivel, AlteracaoVida, AlteracaoVelocidadeConsumivel, Duracao), R) :-
    string_concat("/nNome: ", NomeConsumivel, S1),
    string_concat(S1, "\nAlteracao de vida: ", S2),
    string_concat(S2, AlteracaoVida, S3),
    string_concat(S3, "\nAlteracao de velocidade: ", S4),
    string_concat(S4, AlteracaoVelocidadeConsumivel, S5),
    string_concat(S5, "\nduracao: ", S6),
    string_concat(S6, Duracao, S7).
    
nomeEquipavel(equipavel(NomeEquipavel, _, _, _, _, _, _, _, _, _) NomeEquipavel).   
nomeConsumivel(consumivel(NomeConsumivel, _, _, _), NomeConsumivel).


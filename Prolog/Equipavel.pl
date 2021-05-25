:- persistent equipavel(nome:any, alteracaoVidaMaxima:any, alteracaoForca:any, alteracaoInteligencia:any, alteracaoSabedoria:any, alteracaoDestreza:any, alteracaoConstituicao:any, alteracaoCarisma:any, alteracaoVelocidade:any, tipo:any).
:- persistent equipavelTemHabilidade(nomeEquipavel:any, nomeHabilidade:any).

exibeEquipavel(Nome) :-
	equipavel(Nome, AlteracaoVidaMaxima, AlteracaoForca, AlteracaoInteligencia, AlteracaoSabedoria, AlteracaoDestreza, AlteracaoConstituicao, AlteracaoCarisma, AlteracaoVelocidade, TipoEquipavel),
	nl, write("Nome: "),
	writeln(Nome),
	write("Alteracao na vida maxima: "),
	writeln(AlteracaoVidaMaxima),
	write("Alteracao na Forca: "),
	writeln(AlteracaoForca),
	write("Alteracao na Inteligencia: "),
	writeln(AlteracaoInteligencia),
	write("Alteracao na Sabedoria: "),
	writeln(AlteracaoSabedoria),
	write("Alteracao na Destreza: "),
	writeln(AlteracaoDestreza),
	write("Alteracao na Constituicao: "),
	writeln(AlteracaoConstituicao),
	write("Alteracao no Carisma: "),
	writeln(AlteracaoCarisma),
	write("Alteracao na Velocidade: "),
	writeln(AlteracaoVelocidade),
	write("Tipo do equipavel: "),
	writeln(TipoEquipavel),
	writeln("Habilidades: "),
	listarHabilidadesEquipavel(Nome).

listarEquipaveis :-
	foreach(equipavel(Nome, _, _, _, _, _, _, _, _, _), writeComMarcador(Nome)).

listarHabilidadesEquipavel(Nome) :-
	foreach(equipavelTemHabilidade(Nome, Habilidade), writeComMarcador(Habilidade)).

tipoEquipavel("Cabeca").
tipoEquipavel("Torso").
tipoEquipavel("Pernas").
tipoEquipavel("Maos").
tipoEquipavel("Arma").

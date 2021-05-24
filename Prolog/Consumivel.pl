:- persistent consumivel(nome:any, alteracaoVida:any, alteracaoVelocidade:any, duracao:any).

exibeConsumivel(Nome) :-
	consumivel(Nome, AlteracaoVida, AlteracaoVelocidade, Duracao),
	nl, write("Nome: "),
	writeln(Nome),
	write("Alteracao na vida: "),
	writeln(AlteracaoVida),
	write("Alteracao na velocidade: "),
	writeln(AlteracaoVelocidade),
	write("Duracao: "),
	writeln(Duracao).

listarConsumiveis :-
	foreach(consumivel(Nome, _, _, _), writeln(Nome)).

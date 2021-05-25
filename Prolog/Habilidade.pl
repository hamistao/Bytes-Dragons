:- persistent habilidade(nome:any, impactoVida:any, impactoVelocidade:any, atributoRelacionado:any, pontosParaAcerto:any, tipoDeDano:any).

exibeHabilidade(Nome) :-
	habilidade(Nome, ImpactoVida, ImpactoVelocidade, AtributoRelacionado, PontosParaAcerto, TipoDeDano),
	nl, write("Nome: "),
	writeln(Nome),
	write("Impacto na vida: "),
	writeln(ImpactoVida),
	write("Impacto na velocidade: "),
	writeln(ImpactoVelocidade),
	write("Atributo relacionado: "),
	writeln(AtributoRelacionado),
	write("Pontos para o acerto: "),
	writeln(PontosParaAcerto),
	write("Tipo de dano: "),
	writeln(TipoDeDano).
	
listarHabilidades :-
	foreach(habilidade(Nome, _, _, _, _, _), writeComMarcador(Nome)).

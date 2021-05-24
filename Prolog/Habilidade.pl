:- use_module(library(persistency)).

:- persistent habilidade(nome:any, impactoVida:any, impactoVelocidade:any, atributoRelacionado:any, pontosParaAcerto:any, tipoDeDano:any).

:- initialization(init).

init :-
	absolute_file_name('/data/habil.db', File, [access(write)]),
	db_attach(File, []).

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
	write("Tipode de dano: "),
	writeln(TipoDeDano).
	
listarHabilidades :-
	foreach(habilidade(Nome, _, _, _, _, _), writeln(Nome)).

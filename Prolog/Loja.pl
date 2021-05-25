:- persistent loja(nome:any).
:- persistent lojaTemConsumivel(nomeLoja:any, nomeConsumivel:any, preco:any).
:- persistent lojaTemEquipavel(nomeLoja:any, nomeEquipavel:any, preco:any).

exibeLoja(Nome) :-
	write("Nome da loja: "),
	writeln(Nome),
	writeln("Equipaveis disponiveis: "),
	listarEquipaveisLoja(Nome),
	writeln("Consumiveis disponiveis: "),
	listarConsumiveisLoja(Nome).

listarLojas :-
	foreach(loja(Nome), writeComMarcador(Nome)).

listarEquipaveisLoja(Nome) :-
	foreach(lojaTemEquipavel(Nome, Equipavel, Preco), writeNomeComPreco(Equipavel, Preco)).

listarConsumiveisLoja(Nome) :-
	foreach(lojaTemConsumivel(Nome, Consumivel, Preco), writeNomeComPreco(Consumivel, Preco)).

writeNomeComPreco(Nome, Preco) :-
	write("- "),
	writeln(Nome),
	write("  Preco: "),
	writeln(Preco).

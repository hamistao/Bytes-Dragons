# Bytes-Dragons
Projeto em Haskell pra a disciplina de Paradigmas de linguagem de programação da UFCG.


#Proposta do projeto:
	“Bytes&Dragons” será uma plataforma, acessível pela linha de comando, de auxílio de sessões de RPG de mesa, especificamente de Dungeons and Dragons. O intuito do projeto é facilitar e automatizar parte do trabalho do “mestre” ao longo de campanhas realizadas à distância.


#Objetivos primários:
Na plataforma o usuário poderá:
Cadastrar fichas de personagem que contém pontos, itens e status do personagem. 
Cadastrar informações sobre a campanha, tais como inimigos, localizações, e a própria história.
Cadastrar no sistema os inimigos (nome, vida, dano, experiência dada quando derrotado) e os tesouros que poderão ser encontrados na dungeon
Usar  o sistema para gerar números aleatórios para simular a rolagem de dados
Usar o sistema para calcular automaticamente o dano causado pelos ataques, levando em conta os tipos de dano e as resistências deles, assim como o avanço dos personagens.
Atualizar e checar os dados de acordo com o progresso das sessões.
Salvar todo o progresso entre as sessões.

#Objetivo secundários:
	Se possível, e o decorrer do projeto ocorrer sem problemas, poderá ser adicionado ao projeto mais funcionalidades como:
Criação de salas.
Criação de um bot que auxiliará no uso da ferramenta.


#Exemplos de uso:
Como RPG de mesa é um jogo baseado no diálogo entre jogadores, rolagem de dados, manutenção de dados de personagem e cálculos baseados nesses dados, nosso sistema busca auxiliar nos últimos 3 aspectos citados, que normalmente são feitos com papel e caneta pelo mestre da campanha (que é o responsável por criar e gerenciar a história do jogo). 
Por exemplo, um dos jogadores encontra um inimigo e o ataca, ao invés do mestre checar os status dos 2 combatentes, realizar os cálculos do ataque e anotar as mudanças necessárias, o sistema fará todos esses passos automaticamente assim que o mestre der o input do ataque do jogador.

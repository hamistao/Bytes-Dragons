module Classe where

data Classe = Bruxo | Barbaro | Bardo | Clerigo | Druida | Feiticeiro | Guerreiro | Ladino | Mago | Monge | Paladino | Arqueiro deriving (Show, Eq, Read)

vidaMaxima_classe :: Classe -> Int
vidaMaxima_classe Bruxo = 90
vidaMaxima_classe Barbaro = 120
vidaMaxima_classe Bardo = 100
vidaMaxima_classe Clerigo = 80
vidaMaxima_classe Druida = 90
vidaMaxima_classe Feiticeiro = 80
vidaMaxima_classe Guerreiro = 110
vidaMaxima_classe Ladino = 80
vidaMaxima_classe Mago = 90
vidaMaxima_classe Monge = 80
vidaMaxima_classe Paladino = 130
vidaMaxima_classe Arqueiro = 90

forca_classe :: Classe -> Int
forca_classe Bruxo = 0
forca_classe Barbaro = 2
forca_classe Bardo = 0
forca_classe Clerigo = 0
forca_classe Druida = 0
forca_classe Feiticeiro = 0
forca_classe Guerreiro = 2
forca_classe Ladino = 0
forca_classe Mago = 0
forca_classe Monge = 1
forca_classe Paladino = 2
forca_classe Arqueiro = 0

inteligencia_classe :: Classe -> Int
inteligencia_classe Bruxo = 0
inteligencia_classe Barbaro = 0
inteligencia_classe Bardo = 0
inteligencia_classe Clerigo = 0
inteligencia_classe Druida = 1
inteligencia_classe Feiticeiro = 0
inteligencia_classe Guerreiro = 0
inteligencia_classe Ladino = 1
inteligencia_classe Mago = 2
inteligencia_classe Monge = 0
inteligencia_classe Paladino = 0
inteligencia_classe Arqueiro = 0

sabedoria_classe :: Classe -> Int
sabedoria_classe Bruxo = 1
sabedoria_classe Barbaro = 0
sabedoria_classe Bardo = 0
sabedoria_classe Clerigo = 2
sabedoria_classe Druida = 2
sabedoria_classe Feiticeiro = 0
sabedoria_classe Guerreiro = 0
sabedoria_classe Ladino = 0
sabedoria_classe Mago = 1
sabedoria_classe Monge = 1
sabedoria_classe Paladino = 0
sabedoria_classe Arqueiro = 1

destreza_classe :: Classe -> Int
destreza_classe Bruxo = 0
destreza_classe Barbaro = 0
destreza_classe Bardo = 1
destreza_classe Clerigo = 0
destreza_classe Druida = 0
destreza_classe Feiticeiro = 0
destreza_classe Guerreiro = 1
destreza_classe Ladino = 2
destreza_classe Mago = 0
destreza_classe Monge = 2
destreza_classe Paladino = 0
destreza_classe Arqueiro = 2

constituicao_classe :: Classe -> Int
constituicao_classe Bruxo = 0
constituicao_classe Barbaro = 1
constituicao_classe Bardo = 0
constituicao_classe Clerigo = 0
constituicao_classe Druida = 0
constituicao_classe Feiticeiro = 1
constituicao_classe Guerreiro = 0
constituicao_classe Ladino = 0
constituicao_classe Mago = 0
constituicao_classe Monge = 0
constituicao_classe Paladino = 0
constituicao_classe Arqueiro = 0

carisma_classe :: Classe -> Int
carisma_classe Bruxo = 2
carisma_classe Barbaro = 0
carisma_classe Bardo = 2
carisma_classe Clerigo = 1
carisma_classe Druida = 0
carisma_classe Feiticeiro = 2
carisma_classe Guerreiro = 0
carisma_classe Ladino = 0
carisma_classe Mago = 0
carisma_classe Monge = 0
carisma_classe Paladino = 1
carisma_classe Arqueiro = 0
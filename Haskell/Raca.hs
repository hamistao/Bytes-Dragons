module Raca where

data Raca = Hobbit | Anao | Elfo | Gnomo | Humano | Ogro deriving (Show, Eq, Read)

mod_vidaMaxima :: Raca -> Int
mod_vidaMaxima Hobbit = -10
mod_vidaMaxima Anao = 10
mod_vidaMaxima Elfo = 0
mod_vidaMaxima Gnomo = 0
mod_vidaMaxima Humano = 0
mod_vidaMaxima Ogro = 20

mod_forca :: Raca -> Int
mod_forca Hobbit = 0
mod_forca Anao = 2
mod_forca Elfo = 0
mod_forca Gnomo = 0
mod_forca Humano = 1
mod_forca Ogro = 2

mod_inteligencia :: Raca -> Int
mod_inteligencia Hobbit = 2
mod_inteligencia Anao = 0
mod_inteligencia Elfo = 2
mod_inteligencia Gnomo = 3
mod_inteligencia Humano = 1
mod_inteligencia Ogro = 0

mod_sabedoria :: Raca -> Int
mod_sabedoria Hobbit = 0
mod_sabedoria Anao = 0
mod_sabedoria Elfo = 2
mod_sabedoria Gnomo = 0
mod_sabedoria Humano = 1
mod_sabedoria Ogro = 0

mod_destreza :: Raca -> Int
mod_destreza Hobbit = 2
mod_destreza Anao = 0
mod_destreza Elfo = 2
mod_destreza Gnomo = 3
mod_destreza Humano = 1
mod_destreza Ogro = 0

mod_constituicao :: Raca -> Int
mod_constituicao Hobbit = 0
mod_constituicao Anao = 2
mod_constituicao Elfo = 0
mod_constituicao Gnomo = 0
mod_constituicao Humano = 1
mod_constituicao Ogro = 2

mod_carisma :: Raca -> Int
mod_carisma Hobbit = 3
mod_carisma Anao = 1
mod_carisma Elfo = 0
mod_carisma Gnomo = 0
mod_carisma Humano = 1
mod_carisma Ogro = 0
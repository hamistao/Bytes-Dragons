module Main where
import System.Random

main :: IO ()
main = do {
    print("1 - Cadastrar personagem,\n2 - Batalha,\n3 - Usa Item\n3 - Cadastra NPC,\n4 - cadastra Item\n 5 - cadastraHabilidade\n 7 - Sair");
    opcao <- getLine;
    print()
}
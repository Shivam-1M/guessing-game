module Main where
import Actions

main :: IO ()
main = do
  wordToGuess <- getString
  numberOfGuesses <- getNGuesses
  let begin = "Begin Guessing: " ++ replicate  (length wordToGuess) '-'
  print begin
  play wordToGuess numberOfGuesses

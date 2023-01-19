module Main where
import System.Exit (exitSuccess)
import System.IO (hSetEcho, stdin)

main :: IO ()
main = do
  wordToGuess <- getString
  numberOfGuesses <- getNGuesses
  let begin = "Begin Guessing: " ++ replicate  (length wordToGuess) '-'
  print begin
  play wordToGuess numberOfGuesses

getString :: IO String
getString = do
  putStr "Give Player a Word to Guess (remember it will be hidden!) and Enter: "
  hSetEcho stdin False
  wordToGuess <- getLine
  hSetEcho stdin True
  putChar '\n'
  return wordToGuess

getNGuesses :: IO Int
getNGuesses = do
  putStr "Give Player Number of Chances: "
  n <- getLine
  return ( read n :: Int)

verifyNGuesses :: Int -> IO ()
verifyNGuesses n
  | n > 0 = print ("Remaining Chances: " ++ show n ++ "!")
  | otherwise = do
      print "Oops! You Lost!"
      exitSuccess

compareString :: String -> String -> String
compareString wordToGive wordToGuess = [if x `elem` wordToGuess then x else '-' | x <- wordToGive]

play :: String -> Int -> IO ()
play wordToGive count = do
  verifyNGuesses count
  wordToGuess <- getLine
  if wordToGuess == wordToGive
    then print "You did it! Your Guess is Right! Won!"
  else
    do
      let state = compareString wordToGive wordToGuess
      print state
      play wordToGive (count - 1)


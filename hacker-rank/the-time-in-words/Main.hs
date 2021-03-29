
import Data.Map (fromList, lookup, Map)
import Prelude hiding (lookup)
import Data.Maybe (fromMaybe)

shortNames :: Map Integer [Char]
shortNames = fromList [
  (15, "quarter"),
  (30, "half")
  ]

ones :: Map Integer [Char]
ones = fromList $ zip [1..] ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

teens :: Map Integer [Char]
teens = fromList $ zip [11..] [
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen"
    ]

tens :: Map Integer String
tens = fromList $ zip [2..] ["twenty", "thirty", "fourty", "fifty"]

numberToWord :: Integer -> Maybe String
numberToWord n = case n `div` 10 of
    0 -> lookup n ones
    1 -> lookup n teens
    ten -> let one = n `mod` 10 in
        if one == 0
        then lookup ten tens
        else (\s s2 -> s ++ " " ++ s2) <$> lookup ten tens <*> lookup one ones

minuteName :: Integer -> String
minuteName m = case lookup m shortNames of
  Just name -> name
  Nothing -> fromMaybe "invalid time" (numberToWord m) ++ " minute" ++ (if m ==1 then "" else "s")

timeInWords :: Integer -> Integer -> String
timeInWords h m
  | m == 0 = fromMaybe "invalid hour" (numberToWord h) ++ " o' clock"
  | m <= 30 = minuteName m ++ " past " ++ fromMaybe "invalid hour" (numberToWord h)
  | otherwise = minuteName (60-m) ++ " to " ++ fromMaybe "invalid hour" (numberToWord ((h+1) `mod` 12))

main :: IO ()
main = timeInWords <$> (read <$> getLine ) <*> (read <$> getLine) >>= putStrLn

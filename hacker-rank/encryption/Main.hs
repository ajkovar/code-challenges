import Data.Char (isSpace)
import Data.List (transpose)

removeWhitespace :: String -> String 
removeWhitespace [] = "" 
removeWhitespace (x:xs) 
  | isSpace x = removeWhitespace xs
  | otherwise = x:removeWhitespace xs

splitEvery :: Int -> [a] -> [[a]]
splitEvery _ [] = []
splitEvery n list = first : splitEvery n rest
  where
    (first,rest) = splitAt n list

encryption :: String -> String
encryption s = 
  unwords $ transpose $ splitEvery cols s 
  where 
    withoutSpaces = removeWhitespace s
    root = sqrt $ fromIntegral $ length withoutSpaces
    cols = ceiling root

main :: IO ()
main = interact encryption
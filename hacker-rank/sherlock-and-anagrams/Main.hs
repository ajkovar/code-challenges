import Data.List (sort)
import Data.Map (empty, insertWith, Map, toList)

count :: Int -> Int
count 1 = 0
count 2 = 1
count n = n + count (n-1) - 1

substrings :: String -> [String]
substrings [x] = [[x]]
substrings (x:xs) =
  combine [x] xs ++ substrings xs
  where
    combine :: String -> String -> [String]
    combine a [] = [a]
    combine a bbs@(b:bs) = a : combine (a ++ [b]) bs

sherlockAndAnagrams :: String -> Int
sherlockAndAnagrams s = 
    sum $ count . snd <$> toList (foldr (\s m -> insertWith (+) s 1 m) empty (sort <$> substrings s))

main :: IO ()
main = do
  getLine 
  interact $ unlines . fmap (show . sherlockAndAnagrams) . lines
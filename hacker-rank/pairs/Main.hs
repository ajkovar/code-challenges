import Data.List (sort)

pairs :: Int -> [Int] -> Int
pairs k array = 
  let sorted = sort array
      countDiffs [] = 0
      countDiffs (a:as) = findDiff a as + countDiffs as
      findDiff a [] = 0 
      findDiff a (b:bs) 
        | diff < k = findDiff a bs
        | diff == k = 1 + findDiff a bs
        | diff > k = 0
        where diff = b - a
   in countDiffs sorted

main :: IO ()
main = do
  k <- read . last . words <$> getLine 
  a <- fmap read . words <$> getLine
  print $ pairs k a
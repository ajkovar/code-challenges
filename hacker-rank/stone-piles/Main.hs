import Control.Monad (replicateM)
import Data.List (find, sort)

distinct :: Eq a => [a] -> [a]
distinct [x] = [x]
distinct (x:xs) = case find (==x) xs of
  Nothing -> x:distinct xs
  Just x -> distinct xs

isDistinct [x] = True
isDistinct (x:xs) = case find (==x) xs of
  Nothing -> isDistinct xs
  Just x -> False

allSums :: (Eq a, Num a) => a -> [[a]]
allSums 1 = [[1]]
allSums n = map add1 ns ++ map prep1 ns
  where ns          = allSums (n-1)
        prep1 is    = 1:is
        add1 (i:is) = (i+1):is

uniqueSums = filter isDistinct . distinct . fmap sort . allSums

getWinner :: [Int] -> String
getWinner piles =
    if even pileSum then "BOB" else "ALICE"
    where
      pileSum = sum $ fmap (max 0 . flip (-) 2) piles


stonePiles :: [[Int]] -> [String]
stonePiles = fmap getWinner

main = do
  times <- read <$> getLine :: IO Int
  arr <- replicateM times (getLine >> fmap read . words <$> getLine)
  print $ zip arr [1..]
  putStrLn $ unlines $ fmap show $ zip3 arr [1..] $ stonePiles arr
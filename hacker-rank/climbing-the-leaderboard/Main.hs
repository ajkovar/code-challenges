import Data.List (group)
import Control.Monad (void)
import Data.Foldable (find)

assignRanks :: (Num a1, Ord a2) => [a2] -> [(a2, a1)]
assignRanks [] = []
assignRanks a = scanl (\(last, place) i -> (i, place + (if last > i then 1 else 0))) (head a, 1) a

climbingLeaderboard :: [Int] -> [Int] -> String
climbingLeaderboard ranked player =
  unlines $ fmap (show . rank) player
  where
    ranked' = assignRanks ranked
    rank i = case find ((<= i) . fst) ranked' of
      Nothing -> snd (last ranked') + 1
      Just x -> snd x + (if i >= fst x then 0 else 1)

main :: IO ()
main = do
  contents <- getContents
  let lns = lines contents
  let ranked = toScores $ lns !! 1
  let player = toScores $ lns !! 3
  void $ putStrLn $ climbingLeaderboard ranked player
  where toScores = fmap (read :: String -> Int) . words
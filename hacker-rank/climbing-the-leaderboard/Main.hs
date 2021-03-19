import Data.List (group)
import Control.Monad (void)
import Data.Foldable (find)

tagRanks :: (Num a1, Ord a2) => [a2] -> [(a2, a1)]
tagRanks [] = []
tagRanks a = scanl tagItem (head a, 1) a
  where 
    tagItem (last, place) i = (i, place + (if last > i then 1 else 0))

climbingLeaderboard :: [Int] -> [Int] -> [Int]
climbingLeaderboard ranks scores = 
  reverse $ climbingLeaderboard' 1 taggedRanks reversed
  where 
    taggedRanks = tagRanks ranks
    reversed = reverse scores

climbingLeaderboard' :: Int -> [(Int, Int)] -> [Int] -> [Int]
climbingLeaderboard' _ [] [] = []
climbingLeaderboard' lastRank [] playerValues = lastRank + 1 <$ playerValues
climbingLeaderboard' _ _ [] = []
climbingLeaderboard' _ rankedValues@((rankedValue, rank):xs) playerValues@(playerValue:ys) = 
  if rankedValue <= playerValue
    then rank:climbingLeaderboard' rank rankedValues ys
    else climbingLeaderboard' rank xs playerValues

main :: IO ()
main = do
  contents <- getContents
  let lns = lines contents
  let ranked = toScores $ lns !! 1
  let player = toScores $ lns !! 3
  void $ putStrLn $ unlines $ show <$> climbingLeaderboard ranked player
  where 
    toScores = fmap (read :: String -> Int) . words
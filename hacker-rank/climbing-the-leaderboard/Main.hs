import Data.List (group)

climbingLeaderboard :: [Int] -> [Int] -> [Int]
climbingLeaderboard ranks scores = 
  reverse $ climbingLeaderboard' 1 taggedRanks reversed
  where 
    taggedRanks = zip (head <$> group ranks) [ 1 .. ]
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
  putStrLn $ unlines $ show <$> climbingLeaderboard ranked player
  where 
    toScores = fmap (read :: String -> Int) . words
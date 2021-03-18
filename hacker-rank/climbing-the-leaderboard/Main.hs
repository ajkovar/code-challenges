import Data.List (group)
import Control.Monad (void)
import Data.Foldable (find)

uniq :: Eq a => [a] -> [a]
uniq = uniq' []  
  where 
    uniq' xs' [] = []
    uniq' xs' (x:xs) = 
      if x `elem` xs'
        then uniq' xs' xs 
        else x:uniq' (x:xs') xs

climbingLeaderboard :: [Int] -> [Int] -> String
climbingLeaderboard ranked player = 
  unlines $ fmap (show . rank) player 
  where
    ranked' = zip (uniq ranked) [1 .. ]
    rank i = case find ((<= i) . fst) ranked' of
      Nothing -> length ranked' + 1
      Just x -> snd x + (if i >= fst x then 0 else 1)

main :: IO ()
main = do
  contents <- getContents
  let lns = lines contents 
  let ranked = toScores $ lns !! 1
  let player = toScores $ lns !! 3
  void $ putStrLn $ climbingLeaderboard ranked player
  where toScores = fmap (read :: String -> Int) . words
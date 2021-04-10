module Main where

import Control.Monad (replicateM_, replicateM)
import Data.List (elemIndex, insert, find)
import Data.Maybe (fromJust, mapMaybe)
import Control.Lens ((^?), element)

type Coord = (Int, Int)

readForest :: IO ([[Char]], Int)
readForest = do
  [n, m] <- fmap read . words <$> getLine
  matrix <- replicateM n (head . words <$> getLine)
  prediction <- read <$> getLine
  return (matrix, prediction)

findPosition :: Int -> [[Char]] -> Maybe Coord
findPosition _ [] = Nothing
findPosition y (m:ms) =
  case elemIndex 'M' m of
    Just x -> Just (x, y)
    Nothing -> findPosition (y+1) ms

walk :: [[Char]] -> Coord -> Coord -> Maybe (Bool, Int)
walk matrix previous current@(x, y)
  | null outcomes = Just (False, 0)
  | not foundTarget = Just (False, 0)
  | otherwise = if isDecisionPoint then fmap (+1) <$> target else target
  where
      around = [
       (x + dx, y + dy) |
       dx <- [- 1 .. 1],
       dy <- [- 1 .. 1],
       abs dx /= abs dy && (x + dx, y + dy) /= previous
       ]
      look (i, j) = case matrix ^? (element j . element i) of
        Just 'X' -> Nothing
        Nothing -> Nothing
        Just '*' -> Just (True, 0)
        Just _ -> walk matrix current (i, j)
      outcomes = mapMaybe look around
      foundTarget = or $ fst <$> outcomes
      target = find fst outcomes
      isDecisionPoint = length outcomes > 1

countLuck :: [[Char]] -> Int -> String
countLuck matrix k =
  case walk matrix position position of
    Nothing -> "No path found"
    Just (_, decisions) -> if decisions == k then "Impressed" else "Oops!"
  where
    position = fromJust (findPosition 0 matrix)

main :: IO ()
main = do
  n <- read <$> getLine
  replicateM_ n (readForest >>= putStrLn . uncurry countLuck)

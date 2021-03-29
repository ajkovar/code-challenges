import Data.Array (array, (//), (!), indices)
import Control.Monad (replicateM)
import Control.Monad.List (join)
import Debug.Trace (trace)

checkConnections matrix checked size@(n, m) cell@(i, j) =
  if i>=0 && j>=0 && i<n-1 && j<m-1 && not (checked ! cell) && matrix ! cell == 1
    then
      let 
          checked' = trace (show cell ++ " " ++ show checked) checked // [(cell, True)]
          (count, checked'') = connectedCell matrix checked' size cell 
      in (1 + count, checked'')
    else (0, checked)

connectedCell matrix checked size cell@(i, j) =
  if matrix ! cell == 1
  then 
    foldr
      (\adjacent (sum, checked') ->
        (let (count, checked'') = checkConnections matrix checked' size adjacent
         in (sum + count, checked'')))
      (0, checked)
      [(i+di, i+dj) | di <- [-1..1], dj <- [-1..1]]
  else (0, checked)

arrayConsumable :: (Num b1, Num a, Enum b1, Enum a) => [[b2]] -> [((a, b1), b2)]
arrayConsumable list = join $
  zipWith
    (\l x -> zipWith (\v y -> ((x, y), v)) l [0..])
    list
    [0..]

main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    m <- read <$> getLine :: IO Int
    list <- replicateM n (fmap read . words <$> getLine) :: IO [[Int]]
    print (n, m)
    print list
    let a = array ((0, 0), (n - 1, m - 1)) (arrayConsumable list)
    print a
    let checked = array ((0, 0), (n - 1, m - 1)) (arrayConsumable (replicate n (replicate m False)))
    let count = maximum $ fst . connectedCell a checked (n-1, m-1) <$> indices a
    print checked
    print count
    -- print n
    -- print m
    -- print list
    -- print a
    -- connectedCell (0, 1) 
import Data.Array (array, (//), (!), indices, Array)
import Control.Monad (replicateM)
import Control.Monad.List (join)
import Data.Map (empty, insert, lookup, Map)
import Prelude hiding (lookup)
import Data.Maybe (isNothing)

type Coordinate = (Int, Int)

connectedCell matrix checked size@(n, m) cell@(i, j) =
  if i>=0 && j>=0 && i<=n && j<=m && isNothing (lookup cell checked) && matrix ! cell == 1
  then foldr
        (\adjacent (sum, checked') ->
          (let
              (count, checked'') = connectedCell matrix checked' size adjacent
           in (sum + count, checked'')))
        (1, insert cell True checked)
        [(i+di, j+dj) | di <- [-1..1], dj <- [-1..1]]
  else (0, checked)

arrayConsumable :: [[Int]] -> [(Coordinate, Int)]
arrayConsumable list = join $
  zipWith
    (\l x -> zipWith (\v y -> ((x, y), v)) l [0..])
    list
    [0..]

selectHighest a n m cell (highest, checked) 
  | highest >= highest' = (highest, checked')
  | highest' > highest = (highest', checked')
  where (highest', checked') = connectedCell a checked (n-1, m-1) cell

main :: IO ()
main = do
  n <- read <$> getLine :: IO Int
  m <- read <$> getLine :: IO Int
  list <- replicateM n (fmap read . words <$> getLine) :: IO [[Int]]
  let a = array ((0, 0), (n - 1, m - 1)) (arrayConsumable list)
  print $ fst $ foldr (selectHighest a n m) (0, empty) (indices a)
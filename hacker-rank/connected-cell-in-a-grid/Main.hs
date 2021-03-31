import Data.Array (array, (//), (!), indices)
import Control.Monad (replicateM)
import Control.Monad.List (join)

connectedCell matrix checked size@(n, m) cell@(i, j) =
  if i>=0 && j>=0 && i<=n && j<=m && not (checked ! cell) && matrix ! cell == 1
  then foldr
        (\adjacent (sum, checked') ->
          (let
              (count, checked'') = connectedCell matrix checked' size adjacent
           in (sum + count, checked'')))
        (1, checked // [(cell, True)])
        [(i+di, j+dj) | di <- [-1..1], dj <- [-1..1]]
  else (0, checked)

arrayConsumable :: (Num b1, Num a, Enum b1, Enum a) => [[b2]] -> [((a, b1), b2)]
arrayConsumable list = join $
  zipWith
    (\l x -> zipWith (\v y -> ((x, y), v)) l [0..])
    list
    [0..]

main :: IO ()
main = do
    m <- read <$> getLine :: IO Int
    n <- read <$> getLine :: IO Int
    list <- replicateM n (fmap read . words <$> getLine) :: IO [[Int]]
    let a = array ((0, 0), (n - 1, m - 1)) (arrayConsumable list)
    let checked = array ((0, 0), (n - 1, m - 1)) (arrayConsumable (replicate n (replicate m False)))
    print $ maximum $ fst . connectedCell a checked (n-1, m-1) <$> indices a
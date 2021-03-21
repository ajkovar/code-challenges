import Data.List (transpose)
import Control.Monad.List (join)
import Data.Set (fromList)

formingMagicSquare :: [[Int]] -> Int
formingMagicSquare s = minimum $ fmap calculateScore validSquares
  where calculateScore valid = sum $ abs . uncurry (-) <$> (uncurry zip =<< zip valid s)

validSquares :: [[[Int]]]
validSquares = do
  a <- rows
  b <- rows
  c <- rows
  let square = [a, b, c]
  [[a, b, c] | all ((==15) . sum) (transpose square) &&
               length (fromList (join square)) == 9 &&
               head a + b !! 1 + c !! 2 == 15 &&
               head c + b !! 1 + a !! 2 == 15]
   where rows = validRows

validRows :: [[Int]]
validRows = do
  a <- range
  b <- range
  c <- range
  [[a, b, c] | a + b + c == 15]
  where range = [1..9]

main :: IO ()
main = interact $ show . formingMagicSquare . fmap (fmap read . words) . lines
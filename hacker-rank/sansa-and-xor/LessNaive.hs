import Control.Monad (replicateM_)
import Data.List (tails, scanl')
import Data.Bits (xor)

sansaXor :: [Int] -> Int
sansaXor s = xors $ xors <$> fmap (scanl' xor 0) ((init . tails) s)
  where xors = foldr xor 0

main :: IO ()
main = do
  n <- read <$> getLine
  replicateM_ n (getLine >> getLine >>= print . sansaXor . fmap read . words)
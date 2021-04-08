import Control.Monad (replicateM_)
import Data.List (tails, inits)
import Data.Bits (xor)

sansaXor :: [Int] -> Int
sansaXor arr = xors (xors <$> combinations)
  where
    combinations = concatMap (init . tails) ((tail . inits) arr)
    xors = foldr xor 0

main :: IO ()
main = do
  n <- read <$> getLine
  replicateM_ n (getLine >> getLine >>= print . sansaXor . fmap read . words)
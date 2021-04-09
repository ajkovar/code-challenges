import Control.Monad (replicateM_)
import Data.Bits (xor)

sansaXor :: [Int] -> Int
sansaXor s
  | even (length s) = 0
  | otherwise = foldr (xor . fst) 0 (filter (even . snd) (zip s [0..]))

main :: IO ()
main = do
  n <- read <$> getLine
  replicateM_ n (getLine >> getLine >>= print . sansaXor . fmap read . words)
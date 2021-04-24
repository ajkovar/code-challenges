import Control.Monad (replicateM_)

inversions :: [Int] -> Int
inversions [] = 0
inversions [_] = 0
inversions (x:xs) = foldr (\n s -> if n < x then s + 1 else s) 0 xs + inversions xs

larrysArray :: [Int] -> String
larrysArray a = if even (inversions a) then "YES" else "NO"

main :: IO ()
main = do
  n <- read <$> getLine 
  replicateM_ n (getLine >> larrysArray . fmap read . words <$> getLine >>= putStrLn)
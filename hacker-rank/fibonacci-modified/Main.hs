import Data.Foldable (foldl')

fibonacciModified :: Integer -> Integer -> Integer -> Integer
fibonacciModified t1 t2 n = snd $ foldl' (\(a, b) _ -> (b, a + b ^ 2)) (t1,  t2) [1..n-2]

main :: IO ()
main = do
  getLine >>= print . (\[t1, t2, n] -> fibonacciModified t1 t2 n) . fmap read . words
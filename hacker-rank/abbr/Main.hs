import Control.Monad (replicateM_)
import Data.Char (toUpper, isUpper)

abbreviation :: [Char] -> [Char] -> Bool
abbreviation as [] 
  | any isUpper as = False
  | otherwise  = True
abbreviation [] _ = False 
abbreviation (a:as) (b:bs)
  | a == b = abbreviation as bs
  | toUpper a == b = abbreviation as bs || abbreviation as (b:bs)
  | isUpper a = False
  | otherwise = abbreviation as (b:bs)

main :: IO ()
main = do
  n <- read <$> getLine 
  replicateM_ n (abbreviation <$> getLine <*> getLine >>= (\a -> putStrLn (if a then "YES" else "NO"))) 
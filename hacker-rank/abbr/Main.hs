import Control.Monad (replicateM_)
import Data.Char (toUpper, isUpper)

abbreviation :: [Char] -> [Char] -> [Char]
abbreviation as [] 
  | any isUpper as = "NO"
  | otherwise  = "YES"
abbreviation [] _ = "NO" 
abbreviation (a:as) (b:bs) 
  | a == b || toUpper a == b = abbreviation as bs
  | isUpper a = "NO"
  | otherwise = abbreviation as (b:bs)

main :: IO ()
main = do
  n <- read <$> getLine 
  replicateM_ n (abbreviation <$> getLine <*> getLine >>= putStrLn) 
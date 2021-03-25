import Prelude hiding (lookup)
import Data.List (sort, group)
import Data.Map (insert, lookup, empty)
import Data.Maybe (fromMaybe)

nonDivisibleSubset :: Int -> [Int] -> Int
nonDivisibleSubset k s =
    maxSum + zeroes + evenHalf
    where
      getValue key m = fromMaybe 0 (lookup key m)
      setValue key m = insert key (getValue key m + 1) m
      map = foldr setValue empty $ fmap (`mod` k) s
      halfK = k `div` 2
      range = if even k then [1..halfK-1] else [1..halfK]
      maxSum = sum $ fmap (\key -> maximum [getValue key map, getValue (k - key) map]) range
      zeroes = if getValue 0 map > 0 then 1 else 0
      evenHalf = if even k && getValue halfK map > 0 then 1 else 0

main :: IO ()
main = do
    print =<< nonDivisibleSubset <$> (read . last . words <$> getLine)
                                 <*> (fmap read . words <$> getLine)
import Data.Functor ((<&>))
import Data.IntMap (IntMap, insertWith, empty, findWithDefault, foldrWithKey)
import Data.IntSet (IntSet, empty, toList, insert)

getArray :: IO [Int]
getArray = getLine >> getLine <&> (fmap read . words)

toMap :: [Int] -> IntMap Int
toMap = foldl (\s i -> insertWith (+) i 1 s) Data.IntMap.empty

difference :: IntMap Int -> IntMap Int -> IntSet
difference a b = foldrWithKey (\k a' s -> if findWithDefault 0 k b > a' then insert k s else s) Data.IntSet.empty a

main :: IO ()
main = do
  a <-  toMap <$> getArray
  b <- toMap <$> getArray
  putStrLn $ unwords $ show <$> toList (difference a b)
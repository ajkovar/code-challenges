import Control.Monad
import Data.Array
import Data.Array.ST
import Data.List (sortBy)

parseList :: IO [([Char], Int)]
parseList = do
  n <- (`div` 2) . read <$> getLine
  array <- fmap words . lines <$> getContents
  return $ zipWith (\[j, word] i -> (if i < n then "-" else word, read j)) array [0 ..]

createArray :: [([Char], Int)] -> Array Int (Int, Int)
createArray list = runSTArray $ do
  let max = maximum (snd <$> list)
  array <- newArray (0, max) (0, 0)
  forM_ list $ \(word, i) -> do
    (_, count) <- readArray array i
    writeArray array i (count + 1, count + 1)
  return array

main :: IO ()
main = do
  list <- parseList
  -- print $ sortBy (\a b -> compare (snd a) (snd b)) list
  print $ createArray list
  return ()
{-# LANGUAGE TupleSections #-}

import Control.Monad as C
import Control.Monad.ST
import Data.Vector as V
import Data.Vector.Mutable as M
import Debug.Trace;

parseList :: IO [([Char], Int)]
parseList = do
  n <- (`div` 2) . Prelude.read <$> getLine
  array <- fmap words . lines <$> getContents
  return $ Prelude.zipWith (\[j, word] i -> (if i < n then "-" else word, Prelude.read j)) array [0 ..]

-- createArray :: [([Char], Int)] -> [String]
createArray list = runST $ do
  v <- M.replicate max 0
  C.forM_ list $ \(word, i) -> do
    count <- M.read v i
    M.write v i (count + 1)

  v2 <- V.unsafeFreeze v >>= V.unsafeThaw . fmap (,0) . V.scanl1 (+)
  (max2, _) <- M.read v2 (max -1)

  v3 <- M.new max2
  C.forM_ list $ \(word, i) -> do
    (max, count) <- M.read v2 i
    
    M.modify v2 (fmap (+1)) i
    trace (word <> " " <> show max <> " " <> show count) M.write v3 (max-count-1) word

  toList <$> V.freeze v3
  where
    max = Prelude.maximum (snd <$> list) + 1

main :: IO ()
main = do
  list <- parseList
  -- print $ sortBy (\a b -> compare (snd a) (snd b)) list
  print $ createArray list
  return ()
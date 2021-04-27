import Control.Monad as C
import Control.Monad.ST
import Data.Vector as V
import Data.Vector.Mutable as M

parseList :: IO [([Char], Int)]
parseList = do
  n <- (`div` 2) . Prelude.read <$> getLine
  array <- fmap words . lines <$> getContents
  return $ Prelude.zipWith (\[j, word] i -> (if i < n then "-" else word, Prelude.read j)) array [0 ..]

countingSort :: [([Char], Int)] -> [String]
countingSort list = runST $ do
  v <- M.replicate max 0
  C.forM_ list $ \(word, i) -> do
    count <- M.read v i
    M.write v i (count + 1)

  frozen <- V.unsafeFreeze v
  v2 <- V.unsafeThaw $ V.zip (V.scanl1 (+) frozen) frozen
  (max2, _) <- M.read v2 (max -1)

  v3 <- M.new max2
  C.forM_ list $ \(word, i) -> do
    (index, delta) <- M.read v2 i
    M.modify v2 (fmap (\i -> i - 1)) i
    M.write v3 (index-delta) word

  toList <$> V.freeze v3
  where
    max = Prelude.maximum (snd <$> list) + 1

main :: IO ()
main = do
  list <- parseList
  putStrLn $ unwords $ countingSort list
  return ()
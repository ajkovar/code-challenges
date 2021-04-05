import Data.List ((\\), sort)
import Data.Functor ((<&>))

getArray :: IO [Int]
getArray = getLine >> getLine <&> (fmap read . words)

main :: IO ()
main = do
  a <-  getArray
  b <- getArray
  putStrLn $ unwords $ show <$> sort (b \\ a)
import Data.Foldable (foldl')
import Data.Bits ((.&.), Bits (complement, zeroBits))

andProduct :: Int -> Int -> Int
andProduct a b = foldl' (.&.) (complement zeroBits) [a..b]

main :: IO ()
main = do
    getLine
    lines <- fmap (fmap read . words) . lines <$> getContents
    putStrLn $ unlines $ show . (\(x:x2:_) -> andProduct x x2) <$> lines
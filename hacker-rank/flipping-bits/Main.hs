toBinary :: Int -> [Int]
toBinary n =
  take 32 $ snd <$> iterate (\(r, _) -> step r) (step n)
  where
    step r = (r `div` 2, r `mod` 2)

fromBinary :: [Int] -> Int
fromBinary ns = foldl (\s (i, p) -> s + i * 2 ^ p) 0 $ zip ns [0..]

flipBits :: [Int] -> [Int]
flipBits = fmap (1 -)

flippingBits :: Int -> Int
flippingBits = fromBinary . flipBits . toBinary

main :: IO ()
main = do
  getLine 
  interact $ unlines . fmap ( show . flippingBits . read) . lines
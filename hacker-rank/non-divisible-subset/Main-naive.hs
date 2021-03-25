import Control.Monad.Cont (filterM)

powerset :: [b] -> [[b]]
powerset = filterM (const [True,False])

pairs :: [a] -> [[a]]
pairs [] = []
pairs [x] = []
pairs (x:xs) = fmap (:[x]) xs ++ pairs xs

nonDivisibleSubset :: Int -> [Int] -> Int
nonDivisibleSubset k s =
    case length lengths of
        0 -> 0
        _ -> maximum lengths
    where 
        isMatch = all ((>0) . flip mod k . sum) . pairs
        lengths = length <$> filter isMatch (powerset s)

main :: IO ()
main = do
    print =<< nonDivisibleSubset <$> (read . last . words <$> getLine)
                                 <*> (fmap read . words <$> getLine)
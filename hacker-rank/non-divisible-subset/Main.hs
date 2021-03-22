import Control.Monad.Cont (filterM)

powerset :: [b] -> [[b]]
powerset = filterM (const [True,False])

nonDivisibleSubset :: Int -> [Int] -> Int
nonDivisibleSubset k s =
    maximum $ length <$> filter isMatch (powerset s)
    where isMatch = all ((>0) . flip mod k . sum) . filter ((==2) . length) . powerset

main :: IO ()
main = do
    print =<< nonDivisibleSubset <$> (read . last . words <$> getLine) 
                                    <*> (fmap read . words <$> getLine)
import Data.List (nub, (\\))

type Coord = (Int, Int)

moves :: Coord -> Int -> [Coord] -> [Coord] -> Int
moves step@(a, b) n visited squares
  | any (\(x, y) -> x == n-1 && y == n-1) squares = 0
  | null squares = -1
  | otherwise =
      let squares' = nub $
                     filter (\(x, y) -> x >= 0 && y >= 0 && x < n && y < n) $
                     concatMap
                       (\(x, y) -> [
                        (x+a, y+b), (x-a, y+b), (x+a, y-b), (x-a, y-b),
                        (x+b, y+a), (x-b, y+a), (x+b, y-a), (x-b, y-a)
                       ])
                       squares
          visited' = visited ++ squares
          movesToEnd = moves step n visited' (squares' \\ visited')
      in
        if movesToEnd < 0
        then movesToEnd
        else 1 + movesToEnd

knightlOnAChessboard :: Int -> [[Int]]
knightlOnAChessboard n = [ [ moves (a, b) n [] [(0, 0)] | b <- [1..n-1] ] | a <- [1..n-1] ]

main :: IO ()
main = do
  getLine >>= putStrLn . unlines . fmap (unwords . fmap show) . knightlOnAChessboard . read
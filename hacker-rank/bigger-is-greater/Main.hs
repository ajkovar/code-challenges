import Data.List (sort)

swap :: Char -> String -> Maybe (Char, String)
swap c [] = Nothing
swap c (r:rs) = if r > c then Just (r, c:rs) else fmap (r:) <$> swap c rs

rearrange :: String -> String -> Maybe String
rearrange rest [x] =
  case swap x (sort rest) of
    Nothing -> Nothing
    Just (g, rest') -> Just (reverse (sort rest') ++ [g])
rearrange rest (x:xs) =
  case swap x (sort rest) of
    Nothing -> rearrange (x:rest) xs
    Just (g, rest') -> Just (reverse (sort rest') ++ [g] ++ xs)

biggerIsGreater :: String -> String
biggerIsGreater s = maybe "no answer" reverse (rearrange "" (reverse s))

main :: IO ()
main = interact $ unlines . fmap biggerIsGreater . tail . lines
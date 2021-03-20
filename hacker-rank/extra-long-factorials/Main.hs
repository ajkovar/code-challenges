extraLongFactorials :: Integer -> Integer
extraLongFactorials 1 = 1
extraLongFactorials n = n * extraLongFactorials (n - 1)

main :: IO ()
main = print . extraLongFactorials . read =<< getLine
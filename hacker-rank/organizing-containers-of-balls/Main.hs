{-# LANGUAGE FlexibleInstances, UndecidableInstances, DuplicateRecordFields #-}

module Main where

import Control.Monad
import Data.Array
import Data.Bits
import Data.List
import Data.Set
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe
import Data.Monoid (Sum(Sum))

count containers = Data.List.sort $ foldMap Sum <$> containers

organizingContainers :: [[Int]] -> String
organizingContainers containers =
    if count containers == count (transpose containers) then
        "Possible"
    else
        "Impossible"

readMultipleLinesAsStringArray :: Int -> IO [String]
readMultipleLinesAsStringArray 0 = return []
readMultipleLinesAsStringArray n = do
    line <- getLine
    rest <- readMultipleLinesAsStringArray(n - 1)
    return (line : rest)

main :: IO()
main = do

    q <- readLn :: IO Int

    forM_ [1..q] $ \q_itr -> do
        n <- readLn :: IO Int

        containerTemp <- readMultipleLinesAsStringArray n
        let container = Data.List.map (Data.List.map (read :: String -> Int) . words) containerTemp

        let result = organizingContainers container

        putStrLn result
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
import Data.Monoid (Sum(Sum), getSum)


cellTotal a i (c, j) = 
    (if i == 0 then c else max 0 (c - a !! (i - 1) !! j)) + 
    (if i == length a - 1 then c else max 0 (c - a !! (i + 1) !! j)) + 
    (if j == 0 then c else max 0 (c - a !! i !! (j - 1))) +
    (if j == length (a !! i) - 1 then c else max 0 (c - a !! i !! (j + 1))) + 
    2

sumRow a (r, i) = 
    getSum $ foldMap Sum $ cellTotal a i <$> zip r [0 .. ]

surfaceArea :: [[Int]] -> Int
surfaceArea a = 
    getSum $ foldMap Sum $ sumRow a <$> zip a [0 .. ]

readMultipleLinesAsStringArray :: Int -> IO [String]
readMultipleLinesAsStringArray 0 = return []
readMultipleLinesAsStringArray n = do
    line <- getLine
    rest <- readMultipleLinesAsStringArray(n - 1)
    return (line : rest)

main :: IO()
main = do

    hwTemp <- getLine
    let hw = words hwTemp

    let h = read (head hw) :: Int

    let w = read (hw !! 1) :: Int

    atemp <- readMultipleLinesAsStringArray h
    let a = Data.List.map (Data.List.map (read :: String -> Int) . words) atemp

    let result = surfaceArea a

    print result

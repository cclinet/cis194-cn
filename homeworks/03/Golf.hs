module Golf where

skips :: [a] -> [[a]]
skips x = [each i x | i <- [1 .. length x]]

each :: Int -> [a] -> [a]
each n lst = map fst $ filter ((\x -> mod x n == 0) . snd) indexed
  where
    indexed = zip lst [1 ..]

localMaxima :: [Integer] -> [Integer]
localMaxima xs = map (!! 1) $ filter (\(a : b : c : _) -> b > a && b > c) [take 3 $ drop i xs | i <- [0 .. length xs - 3]]

histogram :: [Integer] -> String
histogram xs = unlines [fill n count | n <- reverse [1 .. tall]] ++ base
  where
    base = "==========\n0123456789\n"
    count = [length $ filter (== i) xs | i <- [0 .. 9]]
    tall = maximum count

fill :: Int -> [Int] -> String
fill n (x : xs) | x >= n = "*" ++ fill n xs | otherwise = " " ++ fill n xs
fill _ _ = ""

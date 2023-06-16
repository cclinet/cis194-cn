import Distribution.Simple.Utils (xargs)

toDigits :: Integer -> [Integer]
toDigits n
  | n > 0 = toDigits (div n 10) ++ [mod n 10]
  | otherwise = []

toDigitsRev :: Integer -> [Integer]
toDigitsRev n
  | n > 0 = mod n 10 : toDigitsRev (div n 10)
  | otherwise = []

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther (x : y : zs)
  | odd (length zs) = x : 2 * y : doubleEveryOther zs
  | otherwise = 2 * x : y : doubleEveryOther zs
doubleEveryOther zs = zs

sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x : xs) = sum (toDigits x) + sumDigits xs

validate :: Integer -> Bool
validate x = mod (sumDigits (doubleEveryOther (toDigits x))) 10 == 0

type Peg = String

type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi n src goal tmp
  | n <= 0 = []
  | n == 1 = [(src, goal)]
  | otherwise = hanoi (n - 1) src tmp goal ++ hanoi 1 src goal tmp ++ hanoi (n - 1) tmp goal src

hanoi4 :: Integer -> Peg -> Peg -> Peg -> Peg -> [Move]
hanoi4 n src goal tmp1 tmp2
  | n <= 0 = []
  | n == 1 = [(src, goal)]
  | n == 3 = [(src, tmp1), (src, tmp2), (src, goal), (tmp2, goal), (tmp1, goal)]
  | otherwise = hanoi4 (n - 1) src tmp1 goal tmp2 ++ hanoi4 1 src goal tmp1 tmp2 ++ hanoi4 (n - 1) tmp1 goal src tmp2

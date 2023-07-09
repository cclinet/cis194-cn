fun1 :: [Integer] -> Integer
fun1 [] = 1
fun1 (x : xs)
  | even x = (x - 2) * fun1 xs
  | otherwise = fun1 xs

fun1' :: [Integer] -> Integer
fun1' = product . map (\x -> x - 2) . filter even

fun2 :: Integer -> Integer
fun2 1 = 0
fun2 n
  | even n = n + fun2 (n `div` 2)
  | otherwise = fun2 (3 * n + 1)

fun2' = sum . filter even . takeWhile (/= 1) . iterate (\x -> if even x then div x 2 else 3 * x + 1)

-- exercise 2
data Tree a
  = Leaf
  | Node Integer (Tree a) a (Tree a)
  deriving (Show, Eq)

insert :: a -> Tree a -> Tree a
insert value Leaf = Node 1 Leaf value Leaf
insert value (Node size Leaf node Leaf) =
  Node (size + 1) (insert value Leaf) node Leaf
insert value (Node size left@Node {} node Leaf) =
  Node (size + 1) left node (insert value Leaf)
insert value (Node size left@(Node leftsize _ _ _) node right@(Node rightsize _ _ _))
  | leftsize == rightsize = Node (size + 1) (insert value left) node right
  | otherwise = Node (size + 1) left node (insert value right)

getHeight :: Tree a -> Tree a
getHeight Leaf = Leaf
getHeight (Node size left node right) = Node (log2 size) (getHeight left) node (getHeight right)
  where
    log2 = floor . logBase 2.0 . fromIntegral

foldTree :: [a] -> Tree a
foldTree = getHeight . foldr insert Leaf

-- exercise 3
xor :: [Bool] -> Bool
xor = foldr (\a b -> (a && not b) || (not a && b)) False

-- map'' :: (a -> b) -> [a] -> [b]
-- map'' f (x : xs) = f x : map' f xs
-- map'' f [] = []

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\a b -> f a : b) [] 

-- exercise 4
-- sieveSundaram :: Integer -> [Integer]
-- sieveSundaram
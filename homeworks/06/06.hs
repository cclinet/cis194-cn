fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib x = fib (x - 1) + fib (x - 2)

fibs1 :: [Integer]
fibs1 = fmap fib [0 ..]

fibo :: Integer -> Integer -> [Integer]
fibo a b = a : fibo b (a + b)

fibs2 :: [Integer]
fibs2 = fibo 0 1

data Stream a = Cons a (Stream a)

streamToList :: Stream a -> [a]
streamToList (Cons x xs) = x : streamToList xs

instance (Show a) => Show (Stream a) where
  show = show . take 20 . streamToList

streamRepeat :: a -> Stream a
streamRepeat x = Cons x (streamRepeat x)

streamMap :: (a -> b) -> Stream a -> Stream b
streamMap f (Cons x xs) = Cons (f x) (streamMap f xs)

streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed f x = Cons x (streamFromSeed f (f x))

nats :: Stream Integer
nats = streamFromSeed (+ 1) 0

-- ruler :: Stream Integer

-- interleaveStreams
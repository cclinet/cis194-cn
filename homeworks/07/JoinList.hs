module JoinList where

import Sized

data JoinList m a
  = Empty
  | Single m a
  | Append m (JoinList m a) (JoinList m a)
  deriving (Eq, Show)

tag :: (Monoid m) => JoinList m a -> m
tag (Single m _) = m
tag (Append m _ _) = m
tag _ = mempty

(+++) :: (Monoid m) => JoinList m a -> JoinList m a -> JoinList m a
(+++) a b = Append (tag a <> tag b) a b

indexJ :: (Sized b, Monoid b) => Int -> JoinList b a -> Maybe a
indexJ i (Single _ a)
  | i == 0 = Just a
  | otherwise = Nothing
indexJ i (Append m l1 l2)
  | i < 0 || i > total_size = Nothing
  | i<fst_size = indexJ fst_size l1
  | otherwise = indexJ (total_size-fst_size) l2
  where
    total_size = getSize . size $ m
    fst_size = getSize . size $ tag l1

-- dropJ :: (Sized b, Monoid b) =>Int -> JoinList b a -> JoinList b a

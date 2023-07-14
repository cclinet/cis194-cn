module Party where

import Data.Tree
import Employee

glCons :: Employee -> GuestList -> GuestList
glCons emp (GL emps fun) = GL (emp : emps) (fun + empFun emp)

instance Semigroup GuestList where
  GL lemployee lfun <> GL remployee rfun = GL (lemployee ++ remployee) (lfun + rfun)

instance Monoid GuestList where
  mempty = GL [] 0

moreFun :: GuestList -> GuestList -> GuestList
moreFun l@(GL _ lfun) r@(GL _ rfun) = if lfun >= rfun then l else r

treeFold :: (a -> [b] -> b) -> b -> Tree a -> b
treeFold f init t@(Node rootLabel subForest) = f rootLabel (map (treeFold f init) subForest)

-- combineGLs :: Employee -> [GuestList] -> GuestList
nextLevel :: Employee -> [(GuestList, GuestList)] -> (GuestList, GuestList)
nextLevel emp [(withList, withoutList)] = (withList, withoutList)

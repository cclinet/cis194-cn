{-# OPTIONS_GHC -Wall #-}

module LogAnalysis where

import Log

parseMessage :: String -> LogMessage
parseMessage str =
  let wordsList = words str
   in case wordsList of
        ("E" : level : ts : msg) -> LogMessage (Error (read level)) (read ts) (unwords msg)
        ("I" : ts : msg) -> LogMessage Info (read ts) (unwords msg)
        ("W" : ts : msg) -> LogMessage Warning (read ts) (unwords msg)
        _ -> Unknown (unwords wordsList)

parse :: String -> [LogMessage]
parse = map parseMessage . lines

insert :: LogMessage -> MessageTree -> MessageTree
insert lmsg@(LogMessage _ _ _) Leaf = Node Leaf lmsg Leaf
insert lmsg@(LogMessage _ ts _) (Node left lmsg2@(LogMessage _ ts2 _) right)
  | ts > ts2 = Node left lmsg2 (insert lmsg right)
  | otherwise = Node (insert lmsg left) lmsg2 right
insert _ tree = tree

build :: [LogMessage] -> MessageTree
build (x : xs) = insert x (build xs)
build [] = Leaf

inOrder :: MessageTree -> [LogMessage]
inOrder (Node left msg right) = inOrder left ++ [msg] ++ inOrder right
inOrder Leaf = []

filterSeverityMoreThan50 :: LogMessage -> Bool
filterSeverityMoreThan50 (LogMessage (Error severity) _ _) = severity>=50
filterSeverityMoreThan50 _ = False

string :: LogMessage -> String
string (LogMessage _ _ string) = string
string _ = ""

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong xs = map string (inOrder (build (filter filterSeverityMoreThan50 xs)))
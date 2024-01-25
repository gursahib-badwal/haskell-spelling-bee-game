{-# LANGUAGE NoImplicitPrelude #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module GameEngine
    (   Score (..),
        toCandidateBasis,
        extractBases,
        basisToPuzzle,
        isWordCorrect,
        allAnswers,
        finalScore,
        cheat
    ) where

import Helpers
import Prelude hiding (foldl, foldr, init, map, length, filter)

data Score = Zero | Bad | OK | Good | Great | Perfect
    deriving (Eq, Show)

type Dictionary = [String]
type Basis = [Char]
type Puzzle = (Char,[Char])


toCandidateBasis :: String -> Maybe Basis
-- toCandidateBasis = error "Unimplemented"
toCandidateBasis [] = Nothing
toCandidateBasis string = if length dedup_string == 7
                            then Just dedup_string
                            else Nothing
                          where dedup_string = dedupAndSort string

extractBases :: [String] -> [String]
-- extractBases = error "Unimplemented"
extractBases [] = []
extractBases string_list = remove_duplicate (filter (/= "") (map special_candidate string_list))
                           where
                            special_candidate :: String -> String
                            special_candidate string = if length dedup_string == 7
                                                         then dedup_string
                                                         else ""
                                                       where dedup_string = dedupAndSort string
                            
                            remove_duplicate :: [String] -> [String]
                            remove_duplicate [] = []
                            remove_duplicate (h:t) 
                                | h `elem` t = remove_duplicate (filter (/= h) t)
                                | otherwise = h: remove_duplicate t
                            

basisToPuzzle :: Basis -> Int -> Puzzle
-- basisToPuzzle = error "Unimplemented"
basisToPuzzle basis index = (basis !! index, filter (/= (basis !! index)) basis)



isWordCorrect :: Dictionary -> Puzzle -> String -> Bool
-- isWordCorrect = error "Unimplemented"
isWordCorrect dictionary puzzle string = (string `elem` dictionary) && second_req string puzzle dictionary
                                        where 
                                            second_req:: String -> Puzzle -> Dictionary -> Bool 
                                            second_req string puzzle dictionary = (fst puzzle `elem` string) && is_subset string (fst puzzle : snd puzzle)
                                             where 
                                                is_subset:: String -> String -> Bool
                                                is_subset [] puzzle = True
                                                is_subset (h:t) puzzle = h `elem` puzzle && is_subset t puzzle

      

allAnswers :: Dictionary -> Puzzle -> [String]
-- allAnswers = error "Unimplemented"
allAnswers dictionary puzzle = [word | word <- dictionary, isWordCorrect dictionary puzzle word]

finalScore :: Dictionary -> Puzzle -> [String] -> Score
-- finalScore = error "Unimplemented"
finalScore dictionary puzzle user_answers
    | length correct_answers == 0 = Zero
    | correct_ratio < 0.25 = Bad
    | correct_ratio < 0.5 = OK
    | correct_ratio < 0.75 = Good
    | correct_ratio < 1.0 = Great
    | otherwise = Perfect

  where 
    correct_answers = filter (isWordCorrect dictionary puzzle) user_answers
    correct_ratio = divide (length correct_answers) (length (allAnswers dictionary puzzle))


cheat :: (Puzzle -> String -> Bool) -> Int -> Puzzle -> [String]
-- cheat = error "Unimplemented"
cheat predicate i puzzle = concatMap (create_words puzzle) [i, i - 1 .. 1]
  where
    create_words :: Puzzle -> Int -> [String]
    create_words puzzle size = filter (predicate puzzle) (custom_replicate size (fst puzzle : snd puzzle))
     where
        custom_replicate :: Int -> [a] -> [[a]]
        custom_replicate 0 string = [[]]
        custom_replicate size string = [x : tail | x <- string, tail <- custom_replicate (size-1) string]

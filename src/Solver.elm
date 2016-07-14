module Solver exposing (solveStep)

import List exposing (map, map2, length, repeat, concat, sum, foldl, filterMap, isEmpty, member, head, tail, indexedMap, filter)
import Maybe exposing (andThen)
import Matrix exposing (Matrix, matrix, toList, fromList)

solveStep : List (List Int) -> List (List Int) -> Matrix (Maybe Bool) -> Maybe (List (List (Maybe Bool)))
solveStep rowHints colHints xs = (solveStep_ rowHints (toList xs)) `andThen` (transpose >> solveStep_ colHints >> Maybe.map transpose)

solveStep_ cs xs = sequence ( map2 solveLine cs xs)

solveLine cs xs = 
  let 
    xss : List (List Bool)
    xss = tile cs xs
    f : List Bool -> Maybe (Maybe Bool)
    f l = case l of 
      (x :: xs) -> Just ( if member (not x) xs then Nothing else Just x)
      [] -> Debug.crash "cannot recover form this"
  in
    if isEmpty xss then
      Nothing
    else
      Just ( filterMap f (transpose xss))

tile : List Int -> List (Maybe Bool) -> List (List Bool)
tile h xs = case h of
  [] -> case ( replicate xs ( repeat (length xs) False)) of 
    Just m -> [m]
    Nothing -> []
  (c::cs) -> 
    let
      v separator = 
        let
          (false, xss) = splitAt separator xs
          (true, xsss)  = splitAt c xss
          (space, xssss) = splitAt 1 xsss
          first = Maybe.withDefault [] ( replicate false (repeat separator False ))
          middle = Maybe.withDefault [] ( replicate true  (repeat c True ) )
          last = Maybe.withDefault [] ( replicate space ( repeat (length space) False) )
        in
          (xssss, first, middle, last)
      auxiliary (rest, first, middle, last) = map (\r -> first ++ middle ++ last ++ r) ( tile cs rest )
    in
      filter (\l -> length l == length xs) ( concat (map (\separator -> auxiliary (v separator)) [0 .. length xs - (c + sum cs + length cs)]))


-- helper functions
replicate : List (Maybe Bool) -> List Bool -> Maybe (List Bool)
replicate xs ys = 
  if length xs == length ys && (foldl (&&) True) (map2 (\x y -> maybe True (\x -> x == y) x) xs ys) then
    Just ys
  else
    Nothing
 
splitAt : Int -> List a -> (List a, List a)
splitAt n xs = (List.take n xs, List.drop n xs)


maybe : b -> (a -> b) -> Maybe a -> b
maybe d f m = Maybe.withDefault d ( Maybe.map f m)

sequence : List (Maybe a) -> Maybe (List a)
sequence xs = 
  let 
    go : List (Maybe a) -> List a -> Maybe (List a)
    go list acc = 
      case list of
        [] -> Just acc
        (Just v :: rest) -> go rest (acc ++ [v])
        (Nothing :: _) -> Nothing
  in
    go xs []

transpose : List (List a) -> List (List a)
transpose ll =
  case ll of
    [] -> []
    ([]::xss) -> transpose xss
    ((x::xs)::xss) ->
      let
        heads = filterMap head xss
        tails = filterMap tail xss
      in
        (x::heads)::transpose (xs::tails)
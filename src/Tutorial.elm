module Tutorial exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.App exposing (program)
import Html.Attributes exposing (..)

tutorialtext = [ [
        Html.text "A nonogram is a picture logic puzzle in which cells in a grid must be colored according to the sequence"
        , br [] []
        , Html.text " and value of numbers at the side of the grid (see figure)."
        , br [] []
        , br [] []
        , Html.text "These numbers refer to the amount of adjacent squares in the row or column which have to be colored."
        , br [] []
        , Html.text "Between each of these adjacent colored squares at least one square has to be blank."
        , br [] []
        , Html.text "In a short upcoming tutorial the basic strategies to solve such puzzles will be explained."
        , br [] []
        , br [] []
        , Html.img [ src "../Bilder/Nonogram2.jpg" ] []
        , br [] []
        , br [] []
        ] ,
        [
        Html.text "Let us have a closer look on the basic techniques to solve a nonogram."
        , br [] []
        , Html.text "In this tutorial we will solve the following 10x10 nonogram."
        , br [] []
        , Html.img [ src "../Bilder/Nonogram_tutorial_1.jpg" ] []
        , br [] []
        , br [] []
        ],
        [
        Html.text "First we look for rows or columns where the number is 0 or the size of the puzzle."
        , br [] []
        , Html.text "These lines are the ones which can be most easily solved, because they are completly colored"
        , br [] []
        , Html.text "or have to stay completly blank. We have two such rows in this puzzle."
        , br [] []
        , Html.img [ src "../Bilder/Nonogram_tutorial_2.jpg" ] []
        , br [] []
        , br [] []
        ] ,
        [
        Html.text "In the next step we look for rows and columns where the numbers of the colored squares and minimum blank squares"
        , br [] []
        , Html.text "add up to the size of the puzzle. Since there has to be at least one empty field between adjacent colored squares"
        , br [] []
        , Html.text "we add 1 for each additional number. In this puzzle we have 2 of these columns and one row. The columns with 7 2"
        , br [] []
        , Html.text "add up to 10 because at least one empty square is needed to seperate the seven adjacent and two adjacent colored squares."
        , br [] []
        , Html.text "There cannot be more than one empty field, because there are only 10 squares per row and column. Therefore the solution"
        , br [] []
        , Html.text "for these two rows is unique. The third row (2 4 2) also add up to 10. Here we have to add 2 to the sum, because"
        , br [] []
        , Html.text "there are 3 seperated filled fields and therefore at least two empty field are needed."
        , br [] []
        , Html.img [ src "../Bilder/Nonogram_tutorial_3.jpg" ] []
        , br [] []
        , br [] []
        ] ,
        [
        Html.text "The first row is already solved because two single squares are already filled, so every other"
        , br [] []
        , Html.text "square in this row cannot be part of the puzzles solution. These squares will be marked with an X"
        , br [] []
        , Html.text "to remind us we already checked them."
        , br [] []
        , Html.img [ src "../Bilder/Nonogram_tutorial_4.jpg" ] []
        , br [] []
       , br [] []
        ] ,
        [
        Html.text "We have a similar situations for the three 2 2 rows. Here we cannot mark all squares with X but"
        , br [] []
        , Html.text "at least some squares can be excluded from the solution of the puzzle. We have in these rows already two filled squares"
        , br [] []
        , Html.text "which have to be part of the solution. The squares not adjacent to these can be marked with an X"
        , br [] []
        , Html.img [ src "../Bilder/Nonogram_tutorial_5.gif" ] []
        , br [] []
        , br [] []
        ] ]

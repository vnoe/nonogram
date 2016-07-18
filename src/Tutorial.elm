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
        ],
        [
        Html.text "Checking some of the empty squares in this way can be done for the second, third and fourth row."
        , br [] []
        , Html.text "The fifth row has to be filled with 8 adjacent squares. Since we have two single filled squares"
        , br [] []
        , Html.text "these can be combined with filled field. The same is true for the last row."
        , br [] []
        , Html.img [ src "../Bilder/Nonogram_tutorial_7.jpg" ] []
        , br [] []
        , br [] []
        ], 
        [ 
        Html.text "Let us have a look at the 4 4 row. The first 4 adjacent filled fields can start at the first filled field."
        , br [] []
        , Html.text "Also these can start at the outter left field. In each case, the forth field from the left has to be colored."
        , br [] []
        , Html.text "The same applies for the second 4 adjacent fields. Therefore two fields can be colored in this row."
        , br [] []
        , Html.img [ src "../Bilder/Nonogram_tutorial_8.jpg" ] []
        , br [] []
        , br [] []
        ],
        [
        Html.text "Since we cannot fill any more fields with the help of the row numbers, let us have a look at the column numbers."
        , br [] []
        , Html.text "Most easily the 9 columns can be solved. Since one field is already checke there are only 9 fields left and each"
        , br [] []
        , Html.text "of these has to be filled. More interestingly are the 6 columns. In these columns there are already three filled fields."
        , br [] []
        , Html.text "Therefore another three fields have to be colored. In upper direction there are 4 empty fields. Since only three of them"
        , br [] []
        , Html.text "could be filled the last one can be checked."
        , br [] []
        , Html.img [ src "../Bilder/Nonogram_tutorial_9.jpg" ] []
        , br [] []
        , br [] []
        ],
        [
        Html.text "These two fields could be checked more easily since we have a 2 2 in this row and this amount of fields are already filled."
        , br [] []
        , Html.text "Also in the third and fourth row the remaining fields can be checked. And therefore we can fill in the 6 columns the "
        , br [] []
        , Html.text "remaining three fields."
        , br [] []
        , Html.img [ src "../Bilder/Nonogram_tutorial_10.jpg" ] []
        , br [] []
        , br [] []
        ] ,
        [
        Html.text "The puzzle is almost solved. Just have a look at the remaining empty fields and look if these can be checked or colored."
        , br [] []
        , Html.text "To color a field right click on it once. To check a field perform two right clicks. To empty a field again right click three times."
        , br [] []
        , Html.text "Click on Next to start with the first puzzle."
        , br [] []
        , br [] []
        ] ]

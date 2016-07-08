module Functions exposing (..)

import Style exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.App exposing (program)
import Html.Attributes exposing (..)
import Matrix exposing (Matrix, matrix)

get n xs = Maybe.withDefault [] (List.head (List.drop n xs))

colHintsVis colHints =
    [ tr []
        (List.map
            (\hint ->
                td [ colHintStyle ]
                    (List.map (\n -> div [] [ Html.text (toString n) ]) hint)
            )
            colHints
        )
    ]


rowHintsVis hint =
    td [ rowHintStyle ]
        (List.map (\n -> span [] [ Html.text (" " ++ (toString n)) ]) hint)


--calc_row_hings field = List.map (\r -> )

--calc_col_hints field = 

--has_won field row_hints col_hints = 

module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.App exposing (program)
import Html.Attributes exposing (..)
import Markdown
import Element
import Collage exposing (..)
import Color exposing (..)
import Time exposing (Time, second)
import Mouse exposing (Position)
import Json.Decode exposing (Decoder, (:=))
import Matrix exposing (Matrix, matrix)
import Random


type Msg
    = Pause
    | Tick Time
    | Change Int Int


type alias Model =
    { pause : Bool
    , field : Matrix (Maybe Bool)
    , lastClicked : ( Int, Int )
    , row_hints : List (List Int)
    , col_hints : List (List Int)
    }


linestyle =
    { color = black
    , width = 3.0
    , cap = Flat
    , join = Smooth
    , dashing = []
    , dashOffset = 0
    }


trtdstyle =
    Html.Attributes.style [ ( "border", "2px solid black" ), ( "padding", "0px" ) ]



--, ("font-family", "sans-serf"), ("font-style", "bold")


tablestyle =
    Html.Attributes.style [ ( "border-spacing", "0px" ), ( "border", "2px solid black" ) ]


init =
    ( { field = matrix 10 10 (\_ -> Nothing)
      , pause = False
      , lastClicked = ( 0, 0 )
      , row_hints = [ [ 3 ], [ 2, 1 ], [ 3, 1 ], [ 1, 2, 3 ], [ 1, 1, 1 ], [ 1, 3, 2 ], [ 2, 3, 1 ], [ 4, 1, 1 ], [ 7 ], [ 7 ] ]
      , col_hints = [ [ 5 ], [ 2, 4 ], [ 1, 3 ], [ 3, 5 ], [ 7, 2 ], [ 1, 5 ], [ 1, 2 ], [ 1, 1, 1, 1 ], [ 5 ], [ 1 ] ]
      }
    , Cmd.none
    )


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


view : Model -> Html Msg
view { pause, field, row_hints, col_hints, lastClicked } =
    if pause then
        pausescreen
    else
        gamescreen field row_hints col_hints lastClicked



--calc_row_hings field = List.map (\r -> )

--calc_col_hints field = 


--has_won field row_hints col_hints = 





col_hint_style =
    Html.Attributes.style [ ( "text-align", "center" ), ( "vertical-align", "bottom" ), ( "border", "2px solid black" ) ]


row_hint_style =
    Html.Attributes.style [ ( "text-align", "right" ), ( "border", "2px solid black" ) ]


col_hints_vis col_hints =
    [ tr []
        (List.map
            (\hint ->
                td [ col_hint_style ]
                    (List.map (\n -> div [] [ Html.text (toString n) ]) hint)
            )
            col_hints
        )
    ]


row_hints_vis hint =
    td [ row_hint_style ]
        (List.map (\n -> span [] [ Html.text (" " ++ (toString n)) ]) hint)


nth n xs =
    Maybe.withDefault [] (List.head (List.drop n xs))


grid2table grid col_hints row_hints =
    table [ tablestyle ]
        ((col_hints_vis ([] :: col_hints))
            ++ (List.indexedMap (\x cols -> tr [ trtdstyle ] (row_hints_vis (nth x row_hints) :: (List.indexedMap (square2html x) cols))) (Matrix.toList grid))
        )


square2html x y square =
    td [ trtdstyle ]
        [ case square of
            Nothing ->
                div [ onClick (Change x y) ] [ Element.toHtml <| collage 30 30 [ filled white (rect 30 30) ] ]

            Just True ->
                div [ onClick (Change x y) ] [ Element.toHtml <| collage 30 30 [ filled black (rect 30 30) ] ]

            Just False ->
                div [ onClick (Change x y) ] [ Element.toHtml <| collage 30 30 [ traced linestyle (path [ ( -30, -30 ), ( 30, 30 ) ]), traced linestyle (path [ ( -30, 30 ), ( 30, -30 ) ]) ] ]
        ]


gamescreen field col_hints row_hints lastClicked =
    div []
        [ grid2table field col_hints row_hints
        ]


pausescreen =
    div []
        [ button [ onClick Pause ] [ Html.text "pause" ]
        ]


update msg ({ pause, field } as model) =
    case msg of
        Pause ->
            ( { model | pause = True }, Cmd.none )

        Tick _ ->
            ( { model | pause = pause }, Cmd.none )

        Change x y ->
            ( case Matrix.get (Matrix.loc x y) field of
                Just Nothing ->
                    { model | field = Matrix.set (Matrix.loc x y) (Just True) field }

                Just (Just True) ->
                    { model | field = Matrix.set (Matrix.loc x y) (Just False) field }

                Just (Just False) ->
                    { model | field = Matrix.set (Matrix.loc x y) (Nothing) field }

                Nothing ->
                    { model | field = field }
            , Cmd.none
            )


subscriptions _ =
    Time.every second Tick

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
    | Click Int Int


type alias Model =
    { pause : Bool
    , field : Matrix (Maybe Bool)
    , lastClicked : ( Int, Int )
    }



--type alias Field =
--    { size: (Int, Int)
--    , rows: Matrix Int
--    , cols: Matrix Int
--    , grid: Matrix (Maybe Bool)
--    }


init =
    ( { field = matrix 10 10 (\_ -> Nothing), pause = False, lastClicked = ( 0, 0 ) }, Cmd.none )


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


view : Model -> Html Msg
view { pause, field, lastClicked } =
    if pause then
        pausescreen
    else
        gamescreen field lastClicked


grid2table grid =
    table [] (List.indexedMap (\x cols -> tr [] (List.indexedMap (square2html x) cols)) (Matrix.toList grid))


square2html x y square =
    td []
        [ case square of
            Nothing ->
                button [ onClick (Click x y) ] [ Html.text ((toString x) ++ " " ++ (toString y)) ]

            Just True ->
                Html.text "b"

            Just False ->
                Html.text "c"
        ]


gamescreen field lastClicked =
    div []
        [ grid2table field
        , Html.text (toString lastClicked)
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

        Click x y ->
            ( { model | lastClicked = ( x, y ) }, Cmd.none )


subscriptions _ =
    Time.every second Tick

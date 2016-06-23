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
    }



--type alias Field =
--    { size: (Int, Int)
--    , rows: Matrix Int
--    , cols: Matrix Int
--    , grid: Matrix (Maybe Bool)
--    }


init =
    ( { field = matrix 10 10 (\_ -> Nothing), pause = False }, Cmd.none )


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


view : Model -> Html Msg
view { pause, field } =
    if pause then
        pausescreen
    else
        gamescreen field


grid2table grid =
    table [] (List.map (\cols -> tr [] (List.map (square2html 1 2) cols)) (Matrix.toList grid))


square2html x y square =
    td []
        [ case square of
            Nothing ->
                button [ onClick (Click x y) ] [ Html.text "a" ]

            Just True ->
                Html.text "b"

            Just False ->
                Html.text "c"
        ]


gamescreen field =
    div []
        [ grid2table field
        , Html.text "pause"]

pausescreen =
    div []
        [ button [ onClick Pause ]  [ Html.text "pause" ]
        ]


update msg ({ pause, field } as model) =
    case msg of
        Pause ->
            ( { model | pause = True }, Cmd.none )

        Tick _ ->
            ( { model | pause = pause }, Cmd.none )

        Click x y ->
            ( { model | field = field }, Cmd.none )


subscriptions _ =
    Time.every second Tick

module Main exposing (..)

import Database exposing (..)
import Style exposing (..)
import Functions exposing (..)

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
    | Next
    | Tick Time
    | Change Int Int


type alias Model =
    { pause : Bool
    , riddleNum : Int
    , field : Matrix (Maybe Bool)
    , lastClicked : ( Int, Int )
    , rowHints : List (List Int)
    , colHints : List (List Int)
    }

init =
    ( { riddleNum = 1
      , field = matrix (List.length (get 0 rowHintDatabase)) (List.length (get 0 colHintDatabase)) (\_ -> Nothing)
      , pause = False
      , lastClicked = ( 0, 0 )
      , rowHints = get 0 rowHintDatabase
      , colHints = get 0 colHintDatabase
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
view { riddleNum, field, pause, lastClicked, rowHints, colHints } =
    if pause then
        pausescreen
    else
        gamescreen riddleNum field lastClicked rowHints colHints


grid2table grid colHints rowHints =
    table [ tablestyle ]
        ((colHintsVis ([] :: colHints))
            ++ (List.indexedMap (\x cols -> tr [ trtdstyle ] (rowHintsVis (get x rowHints) :: (List.indexedMap (square2html x) cols))) (Matrix.toList grid))
        )


square2html x y square =
    td [ trtdstyle ]
        [ case square of
            Nothing ->
                div [ onClick (Change x y) ] [ Element.toHtml <| collage 30 30 [ filled white (rect 30 30) ] ]

            Just True ->
                div [ onClick (Change x y) ] [ Element.toHtml <| collage 30 30 [ filled (rgb 90 90 90) (rect 28 28) ] ]

            Just False ->
                div [ onClick (Change x y) ] [ Element.toHtml <| collage 30 30 [ traced linestyle (path [ ( -13, -13 ), ( 13, 13 ) ]), traced linestyle (path [ ( -13, 13 ), ( 13, -13 ) ]) ] ]
        ]


gamescreen riddleNum field lastClicked rowHints colHints =
    div []
        [ grid2table field colHints rowHints,
          button [ onClick Next ] [ Html.text "Next" ]
        ]


pausescreen =
    div []
        [ button [ onClick Pause ] [ Html.text "pause" ]
        ]


update msg ({ riddleNum, field, pause, lastClicked, rowHints, colHints } as model) =
    case msg of
        Pause ->
            ( { model | pause = True }, Cmd.none )

        Next ->
            ( { model | riddleNum = riddleNum + 1,
                        rowHints = get riddleNum rowHintDatabase,
                        colHints = get riddleNum colHintDatabase,
                        field = matrix (List.length (get riddleNum rowHintDatabase)) (List.length (get riddleNum colHintDatabase)) (\_ -> Nothing) }, Cmd.none )

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

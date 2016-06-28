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
   Html.Attributes.style [("border", "2px solid black"), ("padding", "0px")]

tablestyle =
   Html.Attributes.style [("border-spacing", "0px"), ("border", "2px solid black")]


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
    table [tablestyle] (List.indexedMap (\x cols -> tr [trtdstyle] (List.indexedMap (square2html x) cols)) (Matrix.toList grid))


square2html x y square =
    td [trtdstyle]
        [ case square of
            Nothing ->
                div [onClick (Change x y)] [ Element.toHtml <| collage 30 30 [filled white (rect 30 30)] ]

            Just True ->
                div [onClick (Change x y)] [ Element.toHtml <| collage 30 30 [filled black (rect 30 30)] ]

            Just False ->
                div [onClick (Change x y)] [ Element.toHtml <| collage 30 30 [traced linestyle (path [(-30,-30), (30,30)]), traced linestyle (path [(-30,30), (30,-30)])] ]
        ]


gamescreen field lastClicked =
    div []
        [ grid2table field
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
                   Just Nothing -> { model | field = Matrix.set (Matrix.loc x y) (Just True) field}
                   Just (Just True) -> { model | field = Matrix.set (Matrix.loc x y) (Just False) field}
                   Just (Just False) -> { model | field = Matrix.set (Matrix.loc x y) (Nothing) field}
                   Nothing -> { model | field = field }
              , Cmd.none)


subscriptions _ =
    Time.every second Tick

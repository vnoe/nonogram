module Style exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.App exposing (program)
import Html.Attributes exposing (..)
import Element
import Collage exposing (..)
import Color exposing (..)

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

tablestyle =
    Html.Attributes.style [ ( "border-spacing", "0px" ), ( "border", "2px solid black" ) ]

colHintStyle =
    Html.Attributes.style [ ( "text-align", "center" ), ( "vertical-align", "bottom" ), ( "border", "2px solid black" ) ]

rowHintStyle =
    Html.Attributes.style [ ( "text-align", "right" ), ( "border", "2px solid black" ) ]

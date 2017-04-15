module Main exposing (..)

import Html
import Messages exposing (Msg(..))
import Model exposing (..)
import Update exposing (..)
import View exposing (view)
import Mouse


-- import Http
-- import Json.Decode as Json exposing (..)
-- import Json.Decode.Pipeline as JsonPipeline exposing (decode, required)
-- import RegistrationView


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    initialModel ! []



-- subscriptions : Model -> Sub Msg


subscriptions : Model -> Sub Msg
subscriptions model =
    if not model.menuOptionsHidden then
        Mouse.clicks (always Blur)
    else
        Sub.none

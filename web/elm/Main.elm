module Main exposing (..)

import Html
import Messages exposing (Msg(..))
import Model exposing (..)
import Update exposing (..)
import Views.MainView exposing (view)
import Mouse
import SrHttp exposing (getInitData)


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
    initialModel ! [ getInitData ]



-- subscriptions : Model -> Sub Msg


subscriptions : Model -> Sub Msg
subscriptions model =
    if not model.menuOptionsHidden then
        Mouse.clicks (always Blur)
    else
        Sub.none

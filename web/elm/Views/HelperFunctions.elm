module Views.HelperFunctions exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as JDecode
import Html.Events exposing (onWithOptions)
import Messages exposing (..)
import Model exposing (..)


setEditableStatus : Bool -> String
setEditableStatus editModeActive =
    case editModeActive of
        True ->
            "true"

        False ->
            "false"



-- helper to cancel click anywhere


onClick : msg -> Attribute msg
onClick message =
    onWithOptions
        "click"
        { stopPropagation = True
        , preventDefault = False
        }
        (JDecode.succeed message)


addLogo : Html Msg
addLogo =
    div [ class "jumbotron" ] [ p [ class "logo" ] [] ]


registerButton : Html Msg
registerButton =
    button
        [ class "btn btn-primary btn-lg btn-block"
        , onClick (SetState RegistrationPage)
        ]
        [ text "REGISTER NOW!" ]

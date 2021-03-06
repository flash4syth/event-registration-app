module Views.HelperFunctions exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as JDecode


-- import Json.Encode as JEncode

import Html.Events exposing (onWithOptions, onInput)
import Messages exposing (..)
import Model exposing (..)
import Styles.Styles as Styles


makeEditableTag :
    ( Model
    , List (Attribute Msg)
      -> List (Html Msg)
      -> Html Msg
    , String -> Msg
    , String
    )
    -> Html Msg
makeEditableTag ( model, tag_func, msg_func, text_content ) =
    case model.editModeActive of
        True ->
            input
                [ type_ "text"
                , style Styles.mediumText
                , onInput msg_func
                , value text_content
                ]
                []

        False ->
            tag_func
                [ style (List.append Styles.mediumText [ ( "width", "100%" ) ])
                ]
                [ text text_content ]



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


registerButton : String -> Html Msg
registerButton label =
    button
        [ class "btn btn-primary btn-lg btn-block"
        , onClick (SetState RegistrationPage)
        ]
        [ text label ]


updateFood : List Event -> Cmd Msg
updateFood meals =
    Cmd.none

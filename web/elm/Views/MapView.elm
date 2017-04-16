module Views.MapView exposing (..)

import Messages exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)


view : Html Msg
view =
    section []
        [ ul []
            [ li [] [ a [ href "#" ] [ text "Directions" ] ]
            , li []
                [ a
                    [ href "https://www.hebervalleycamp.org/forms/CampsSmithandEsther.pdf" ]
                    [ text "Map of Heber Valley Girls Camp" ]
                ]
            ]
        ]

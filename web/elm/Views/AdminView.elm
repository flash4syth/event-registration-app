module Views.AdminView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Messages exposing (..)


view : Model -> Html Msg
view model =
    section []
        [ h1 [] [ text "Administration Page" ]
        , table [ style [ ( "border", "2px solid black" ) ] ]
            [ tr [] [ td [] [ text "Overnight Count:" ], td [] [ text (toString 100) ] ]
            , tr [] [ td [] [ text "Dinner Count:" ], td [] [ text (toString 100) ] ]
            , tr [] [ td [] [ text "Breakfast Count:" ], td [] [ text (toString 100) ] ]
            , tr [] [ td [] [ text "Lunch Count:" ], td [] [ text (toString 100) ] ]
            ]
        ]

module Views.PackingView exposing (..)

import Messages exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Styles.Styles as Styles
import Views.HelperFunctions exposing (..)


view : Model -> Html Msg
view model =
    section [ class "row" ]
        (addLogo
            :: [ header []
                    [ h1 [ style Styles.centerText ] [ text "Packing List" ] ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ header [] [ h2 [] [ text "Bedding" ] ]
                    , ul [] [ li [] [ text "Sleeping Pad" ] ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ header [] [ h2 [] [ text "Toiletries" ] ]
                    , ul [] [ li [] [ text "tooth brush" ] ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ header [] [ h2 [] [ text "Clothing" ] ]
                    , ul [] [ li [] [ text "pajamas" ] ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ header [] [ h2 [] [ text "Other" ] ]
                    , ul [] [ li [] [ text "flash light" ] ]
                    ]
               ]
        )

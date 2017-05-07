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
                    , ul [ style Styles.mediumText ]
                        [ li [] [ text "Sleeping pad (but seriously, bring one)" ]
                        , li [] [ text "Sleeping bag" ]
                        , li [] [ text "Pillow" ]
                        , li [] [ text "Extra blanket if you get cold easily" ]
                        ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ header [] [ h2 [] [ text "Personal Items" ] ]
                    , ul [ style Styles.mediumText ]
                        [ li [] [ text "Long pants" ]
                        , li [] [ text "Short sleeve shirt" ]
                        , li [] [ text "Long sleeve shirt" ]
                        , li [] [ text "Pajamas" ]
                        , li [] [ text "Jacket or coat" ]
                        , li [] [ text "Close-toed shoes" ]
                        , li [] [ text "Rain gear (if forecast predicts rain)" ]
                        , li [] [ text "Toiletries" ]
                        , li [] [ text "Hand towel" ]
                        , li [] [ text "Sunscreen" ]
                        , li [] [ text "Chapstick" ]
                        , li [] [ text "Sunglasses" ]
                        , li [] [ text "Hat" ]
                        ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ header [] [ h2 [] [ text "Other" ] ]
                    , ul [ style Styles.mediumText ]
                        [ li [] [ text "Camping chair" ]
                        , li [] [ text "Bug spray" ]
                        , li [] [ text "Flash light / head lamp" ]
                        , li [] [ text "Camera" ]
                        , li [] [ text "Phone charger" ]
                        ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ header [] [ h2 [] [ text "Optional" ] ]
                    , ul [ style Styles.mediumText ]
                        [ li [] [ text "Board games" ]
                        , li [] [ text "Cards" ]
                        , li [] [ text "Balls" ]
                        , li [] [ text "Frisbees" ]
                        , li [] [ text "Portable instruments" ]
                        , li [] [ text "Selfie stick" ]
                        , li [] [ text "Snacks" ]
                        ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ header []
                        [ h2 []
                            [ text "Helpful information to know whilst packing"
                            ]
                        ]
                    , ul [ style Styles.mediumText ]
                        [ li []
                            [ text
                                ("Tents and hammocks are not allowed at "
                                    ++ "Heber Valley Girls Camp"
                                )
                            ]
                        , li []
                            [ text
                                ("The camp is equipped with running water, "
                                    ++ "flushing toilets, and electricity"
                                )
                            ]
                        ]
                    ]
               ]
        )

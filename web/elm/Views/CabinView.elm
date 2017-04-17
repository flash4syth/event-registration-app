module Views.CabinView exposing (..)

import Messages exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Styles.Styles as Styles


view : Model -> Html Msg -> Html Msg
view model addLogo =
    section [ class "row" ]
        (addLogo
            :: [ header [] [ h1 [ style Styles.centerText ] [ text "Cabins & Facilities" ] ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ img [ width 200, height 200 ] []
                    , p [ style Styles.mediumText ] [ text "The Cabins fit 16 each for beds." ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ img [ width 200, height 200 ] []
                    , p [ style Styles.mediumText ] [ text "beds are first come first serve." ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ img [ width 200, height 200 ] []
                    , p [ style Styles.mediumText ] [ text "Bathrooms are next to the cabins." ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ img [ width 200, height 200 ] []
                    , p [ style Styles.mediumText ]
                        [ text "Hammocks are not allowed.  Do you want to get eaten by a bear?" ]
                    ]
               ]
        )

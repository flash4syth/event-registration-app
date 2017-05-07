module Views.CabinView exposing (..)

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
            :: [ header [ class "col-xs-12 col-md-12" ] [ h1 [ style Styles.centerText ] [ text "Cabins & Facilities" ] ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ img [ width 300, height 300, src "/images/cabin.jpg" ] []
                    , p [ style Styles.mediumText ] [ text "The Cabins fit 16 each for beds." ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ img [ width 300, height 300, src "/images/beds.jpg" ] []
                    , p [ style Styles.mediumText ] [ text "Beds are first come first serve." ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ img [ width 300, height 300, src "/images/bathrooms.jpg" ] []
                    , p [ style Styles.mediumText ] [ text "Bathrooms are next to the cabins." ]
                    ]
               , section [ class "col-xs-12 col-md-6" ]
                    [ img [ width 300, height 300, src "/images/not_allowed.png" ] []
                    , p [ style Styles.mediumText ]
                        [ text "Hammocks are not allowed.  Do you want to get eaten by a bear?" ]
                    ]
               ]
        )

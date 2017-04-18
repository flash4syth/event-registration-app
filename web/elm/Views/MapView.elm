module Views.MapView exposing (..)

import Messages exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Styles.Styles as Styles
import Views.HelperFunctions exposing (..)


view : Html Msg
view =
    section [ class "row" ]
        (addLogo
            :: [ header [] [ h1 [ style Styles.centerText ] [ text "Map" ] ]
               , section [ class "jumbotron custom" ]
                    -- , section [ class "like-jumbotron" ]
                    [ div [ class "col-xs-12 col-md-6" ]
                        [ section []
                            [ h2 [] [ text "Directions" ]
                            , p []
                                [ ol []
                                    (List.append
                                        (List.map
                                            (\item ->
                                                li [] [ text item ]
                                            )
                                            [ "Depart from MSB (350 N 900 E, Provo, UT)"
                                            , "Take 900 E to US-189 N/N University Ave"
                                            , "Turn right onto US-189 N/N University Ave"
                                            , "Continue to follow US-189 N 29 min (24.9 mi)"
                                            , "Follow E 1200 S to Cummings Memorial Dr 19 min (9.2 mi)"
                                            ]
                                        )
                                        [ li [ style [ ( "font-weight", "bold" ) ] ]
                                            [ text "Arrive at Heber Valley Camp" ]
                                        ]
                                    )
                                ]
                            ]
                        , section []
                            [ img
                                [ src "/images/HeberValleyCampMap.png"
                                , height 361
                                , width 320
                                ]
                                [ text "Map of Heber Valley Girls Camp" ]
                            ]
                        ]
                    , div [ class "col-xs-12 col-md-6" ]
                        [ section []
                            [ img
                                [ src "/images/googlemap.png"
                                , width 400
                                , height 650
                                ]
                                []
                            ]
                        , section [] [ h3 [] [ a [ href "https://www.hebervalleycamp.org/camp-rules/" ] [ text "View Camp Rules" ] ] ]
                        ]
                    ]
               ]
        )

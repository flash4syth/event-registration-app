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
                                , width 300
                                ]
                                [ text "Map of Heber Valley Girls Camp" ]
                            ]
                        ]
                    , div [ class "col-xs-12 col-md-6" ]
                        [ section []
                            [ iframe
                                [ src "https://www.google.com/maps/embed?pb=!1m28!1m12!1m3!1d194555.71329154624!2d-111.62716290915984!3d40.366009496224216!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m13!3e0!4m5!1s0x874d974ab3205331%3A0xe0e7bfd36b2d2f6c!2s350+900+E%2C+Provo%2C+UT+84606!3m2!1d40.2387622!2d-111.6431673!4m5!1s0x874df712d5f351ef%3A0x86b92e047919e15!2s6402+E+1200+S%2C+Heber+City%2C+UT+84032!3m2!1d40.4923743!2d-111.3153992!5e0!3m2!1sen!2sus!4v1492357553922"
                                , width 600
                                , height 450
                                , attribute "frameborder" "0"
                                , style [ ( "border", "0" ) ]
                                , attribute "allowfullscreen" "allowfullscreen"
                                ]
                                []
                            ]
                        , section [] [ h3 [] [ a [ href "https://www.hebervalleycamp.org/camp-rules/" ] [ text "View Camp Rules" ] ] ]
                        ]
                    ]
               ]
        )

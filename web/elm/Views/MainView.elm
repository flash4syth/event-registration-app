module Views.MainView exposing (..)

import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Model exposing (..)
import Messages exposing (..)
import Styles.Styles as Styles
import Views.MapView as MapView
import Views.RegistrationView as RegistrationView
import Views.AdminView as AdminView
import Views.ActivityView as ActivityView
import Views.PackingView as PackingView
import Views.ScheduleView as ScheduleView
import Views.CabinView as CabinView
import Views.MealView as FoodView
import Views.HelperFunctions exposing (..)


optionList : List ( String, Msg )
optionList =
    [ ( "Home", SetState HomePage )
    , ( "Map", SetState MapPage )
    , ( "Activities", SetState ActivitiesPage )
    , ( "Food", SetState FoodPage )
    , ( "Schedule", SetState SchedulePage )
    , ( "Cabins", SetState CabinsPage )
    , ( "Packing List", SetState PackingPage )
    ]


view : Model -> Html Msg
view model =
    let
        optionsDisplay =
            if model.menuOptionsHidden then
                ( "display", "none" )
            else
                ( "display", "block" )
    in
        article []
            [ nav [ class "navbar navbar-default navbar-static-top", attribute "role" "navigation" ]
                [ div [ class "container" ]
                    [ div [ class "navbar-header" ]
                        [ button
                            [ type_ "button"
                            , class "navbar-toggle collapsed"
                              -- , attribute "data-toggle" "collapse"
                              -- , attribute "data-target" "#navbar-collapse"
                            , onClick DropDownClicked
                            ]
                            [ --Toggle navigation
                              span [ class "sr-only" ] []
                            , span [ class "icon-bar" ] []
                            , span [ class "icon-bar" ] []
                            , span [ class "icon-bar" ] []
                            ]
                        , ul [ style <| optionsDisplay :: Styles.dropdownList ]
                            (List.map optionView optionList)
                        ]
                      -- Collect the nav links, forms, and other content for toggling
                    , div
                        [ class "collapse navbar-collapse", id "navbar-collapse" ]
                        [ ul [ class "nav navbar-nav" ]
                            (List.map optionView optionList)
                        ]
                    ]
                ]
            , (pageContent model)
            ]


optionView : ( String, Msg ) -> Html Msg
optionView ( option, msg ) =
    li [ style Styles.dropdownListItem ]
        [ a [ href "#", onClick msg ] [ text option ] ]


pageContent : Model -> Html Msg
pageContent model =
    case model.state of
        HomePage ->
            div [ class "jumbotron" ]
                [ p [ class "logo" ] []
                , hr [] []
                , registerButton "REGISTER NOW!"
                , header []
                    [ h1 [] [ text "Provo YSA 16th Stake Summer Retreat" ]
                    , h2 [] [ text "Overnight trip at Heber Valley Girl's Camp" ]
                    , h3 [] [ text "June 9 - 10, 2017" ]
                    , p [] [ text "Come enjoy a weekend of nature, activities, and some amazing stake members." ]
                    ]
                , section []
                    [ -- , iframe [, , frameborder "0", allowfullscreen "True"][]
                      iframe
                        [ style [ ( "width", "560" ), ( "height", "315" ) ]
                        , src "https://www.youtube.com/embed/1_qbun73D6k"
                        ]
                        []
                    , iframe
                        [ style [ ( "width", "560" ), ( "height", "315" ) ]
                        , src "https://www.youtube.com/embed/g4uMfdpcNf0"
                        ]
                        []
                    , iframe
                        [ style [ ( "width", "560" ), ( "height", "315" ) ]
                        , src "https://www.youtube.com/embed/Ps67N0kWjNk"
                        ]
                        []
                    , iframe
                        [ style [ ( "width", "560" ), ( "height", "315" ) ]
                        , src "https://www.youtube.com/embed/ObUSqEpM7j4"
                        ]
                        []
                    , p []
                        [ text "For questions contact your ward activities co-chairs." ]
                    ]
                , registerButton "REGISTER NOW!"
                ]

        MapPage ->
            MapView.view

        RegistrationPage ->
            RegistrationView.view model

        RegistrationSuccess ->
            h2 [ style Styles.centerText ] [ text "You have successfully registered!" ]

        AdminPage ->
            AdminView.view model

        ActivitiesPage ->
            ActivityView.view model

        FoodPage ->
            FoodView.view model

        SchedulePage ->
            ScheduleView.view

        CabinsPage ->
            CabinView.view model

        PackingPage ->
            PackingView.view model

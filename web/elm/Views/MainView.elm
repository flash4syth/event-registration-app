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
    [ ( "Map", SetState MapPage )
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
            [ header [ class "header" ]
                [ nav
                    [ attribute "role" "navigation"
                    ]
                    [ ul
                        [ style Styles.dropdownContainer
                        , class "nav nav-pills pull-left"
                        ]
                        -- [ ul [ class "nav nav-pills pull-right" ]
                        [ li [ style Styles.padElement ] [ div [] [ a [ href "#", onClick (SetState HomePage) ] [ text "Home  -  " ] ] ]
                          -- , li [ style Styles.padElement ] [ div [] [ a [ href "#" ] [ text "Login  -  " ] ] ]
                          -- , li [] [ a [ href "#", onClick (SetState AdminPage) ] [ text "Admin" ] ]
                        , li [ style Styles.padElement, onClick DropDownClicked ]
                            [ div []
                                [ a [ href "#" ]
                                    [ text "More Info"
                                    , span [ class "caret" ] []
                                    ]
                                , ul [ style <| optionsDisplay :: Styles.dropdownList ]
                                    (List.map optionView optionList)
                                ]
                            ]
                          -- , li [] [ a [ href "#", onClick (SetState Map) ] [ text "Map" ] ]
                          -- , li [] [ a [ href "#" ] [ text "Activities" ] ]
                          -- , li [] [ a [ href "#" ] [ text "Food" ] ]
                          -- , li [] [ a [ href "#" ] [ text "Full Schedule" ] ]
                          -- , li [] [ a [ href "#" ] [ text "Cabins" ] ]
                          -- , li [] [ a [ href "#" ] [ text "Packing List" ] ]
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
                , registerButton
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
                , registerButton
                ]

        MapPage ->
            MapView.view

        RegistrationPage ->
            RegistrationView.view model

        AdminPage ->
            AdminView.view model

        ActivitiesPage ->
            ActivityView.view model

        FoodPage ->
            FoodView.view model

        SchedulePage ->
            ScheduleView.view model

        CabinsPage ->
            CabinView.view model

        PackingPage ->
            PackingView.view model

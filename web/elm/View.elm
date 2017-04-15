module View exposing (..)

import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (onWithOptions)
import Json.Decode as JDecode
import Model exposing (..)
import Messages exposing (..)
import Styles.Styles as Styles


optionList : List ( String, Msg )
optionList =
    [ ( "Map", Map )
    , ( "Activities", Activities )
    , ( "Food", Food )
    , ( "Schedule", Schedule )
    , ( "Cabins", Cabins )
    , ( "Packing List", Packing )
    ]



-- helper to cancel click anywhere


onClick : msg -> Attribute msg
onClick message =
    onWithOptions
        "click"
        { stopPropagation = True
        , preventDefault = False
        }
        (JDecode.succeed message)


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
                        [ li [ style Styles.padElement ] [ div [] [ a [ href "#", onClick (SetState HomePage) ] [ text "Home" ] ] ]
                        , li [ style Styles.padElement ] [ div [] [ a [ href "#" ] [ text "Login" ] ] ]
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


registerButton : Html Msg
registerButton =
    button
        [ class "btn btn-primary btn-lg btn-block"
        , onClick Register
        ]
        [ text "REGISTER NOW!" ]


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

        Registration ->
            section []
                [ header [] [ h1 [] [ text "Registration" ] ]
                , section []
                    [ header [] [ h2 [] [ text "Personal Information" ] ]
                    , input [ style Styles.mediumText, type_ "text", placeholder "First Name" ] []
                    , br [] []
                    , input [ style Styles.mediumText, type_ "text", placeholder "Last Name" ] []
                    , br [] []
                    , input [ style Styles.mediumText, type_ "text", placeholder "Email" ] []
                    , br [] []
                    , input [ style Styles.mediumText, type_ "text", placeholder "Phone Number" ] []
                    , br [] []
                    , span [ style Styles.mediumText ]
                        [ text "Gender:" ]
                    , label
                        []
                        [ input [ style Styles.mediumText, type_ "radio", name "gender", Attr.value "Female" ] []
                        , text "Female"
                        ]
                    , label []
                        [ input [ style Styles.mediumText, type_ "radio", name "gender", Attr.value "Male" ] []
                        , text "Male"
                        ]
                    , br [] []
                    , label
                        []
                        [ text "Your Ward:"
                        , select [ style Styles.mediumText ]
                            (List.map makeOption model.registration_info.wards)
                        ]
                    ]
                , hr [] []
                , section []
                    [ header [] [ h2 [] [ text "Level of Participation" ] ]
                    , p [ style Styles.mediumText ] [ text "How long do you plan to attend the stake retreat?" ]
                    , label
                        [ style (List.append Styles.padElement Styles.mediumText) ]
                        [ input [ type_ "radio", name "length-of-stay", Attr.value "friday" ] []
                        , text " Friday Only"
                        ]
                    , label [ style (List.append Styles.padElement Styles.mediumText) ]
                        [ input [ type_ "radio", name "length-of-stay", Attr.value "overnight" ] []
                        , text " Overnight on Friday"
                        ]
                    , label [ style (List.append Styles.padElement Styles.mediumText) ]
                        [ input [ type_ "radio", name "length-of-stay", Attr.value "saturday" ] []
                        , text " Saturday Only"
                        ]
                    , br [] []
                    , p [ style (List.append Styles.mediumText [ ( "box-sizing", "float" ) ]) ]
                        ((text "Please check which meals you will be eating:")
                            :: (makeEventCheckBox model.meals [])
                        )
                    , p [ style Styles.mediumText ]
                        ((text
                            ("Please check which activities you"
                                ++ " will attend and your interest level"
                                ++ "(interested or very interested):"
                            )
                         )
                            :: (makeEventCheckBox model.activities
                                    [ " Interested", " Very Interested" ]
                               )
                        )
                    ]
                , hr [] []
                , section []
                    [ header [] [ h2 [] [ text "Special Accommodations" ] ]
                    , p [ style Styles.mediumText ]
                        [ text "Do you have any special needs?"
                        , label []
                            [ input
                                [ type_ "checkbox"
                                , onClick ToggleSpecialNeeds
                                ]
                                []
                            , text "Yes"
                            ]
                        ]
                    , section [ style Styles.padElement, hidden model.specialNeedsHidden ]
                        [ label [ style Styles.mediumText ] [ input [ type_ "checkbox", name "wheel-chair", value "true" ] [], text "Wheel Chair Access" ]
                        , br [] []
                        , label [ style Styles.mediumText ] [ input [ type_ "checkbox", name "food-allergy", value "true" ] [], text "Food Allergies" ]
                        , br [] []
                        , label [ style Styles.mediumText ] [ input [ type_ "checkbox", name "other", value "true" ] [], text "Other" ]
                        , br [] []
                        , label [] [ text "Instructions:", textarea [ style Styles.mediumText, cols 60, rows 1 ] [] ]
                        ]
                    ]
                , button [ class "btn btn-lg", style Styles.mediumText ] [ text "Submit Registration" ]
                ]

        AdminPage ->
            section []
                [ h1 [] [ text "Administration Page" ]
                , table [ style [ ( "border", "2px solid black" ) ] ]
                    [ tr [] [ td [] [ text "Overnight Count:" ], td [] [ text (toString 100) ] ]
                    , tr [] [ td [] [ text "Dinner Count:" ], td [] [ text (toString 100) ] ]
                    , tr [] [ td [] [ text "Breakfast Count:" ], td [] [ text (toString 100) ] ]
                    , tr [] [ td [] [ text "Lunch Count:" ], td [] [ text (toString 100) ] ]
                    ]
                ]

        ActivitiesPage ->
            h1 [] [ text "Activities" ]

        FoodPage ->
            h1 [] [ text "Food" ]

        SchedulePage ->
            h1 [] [ text "Schedule" ]

        CabinsPage ->
            h1 [] [ text "Cabins" ]

        PackingPage ->
            h1 [] [ text "Packing List" ]


makeEventCheckBox : List Event -> List String -> List (Html Msg)
makeEventCheckBox events survey_options =
    let
        survey =
            if List.isEmpty survey_options then
                div [] []
            else
                div []
                    (List.map
                        (\option ->
                            label [ style (List.concat [ [ ( "padding-left", "3px" ) ], Styles.padElement, Styles.mediumText ]) ]
                                [ input
                                    [ type_ "radio"
                                    , name "survey"
                                    , value option
                                    ]
                                    []
                                , text option
                                ]
                        )
                        survey_options
                    )
    in
        List.map
            (\event ->
                div []
                    [ label [ style (List.append Styles.padElement Styles.mediumText) ]
                        [ input [ type_ "checkbox" ] []
                        , text event.name
                        , span [ class "short-desc" ]
                            [ text
                                ("--" ++ event.short_description)
                            ]
                        ]
                    , survey
                    ]
            )
            events


makeOption : String -> Html Msg
makeOption ward =
    option [ value ward ] [ text ward ]

module View exposing (..)

import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Messages exposing (..)


view : Model -> Html Msg
view model =
    article []
        [ header [ class "header" ]
            [ nav [ attribute "role" "navigation" ]
                [ ul [ class "nav nav-pills pull-right" ]
                    [ li [] [ a [ href "#", onClick (SetState Home) ] [ text "Home" ] ]
                    , li [] [ a [ href "#", onClick (SetState Admin) ] [ text "Admin" ] ]
                    , li [] [ a [ href "#" ] [ text "Map" ] ]
                    , li [] [ a [ href "#" ] [ text "Activities" ] ]
                    , li [] [ a [ href "#" ] [ text "Food" ] ]
                    , li [] [ a [ href "#" ] [ text "Full Schedule" ] ]
                    , li [] [ a [ href "#" ] [ text "Cabins" ] ]
                    , li [] [ a [ href "#" ] [ text "Packing List" ] ]
                    ]
                ]
            , span [] [ text "Logo" ]
              -- , span [ class "logo" ] []
            ]
        , (pageContent model)
        ]



-- view : Model -> Html Msg
-- view model =
--     article [ pageStyle ]
--         [ nav []
--             [ a [ padElement, href "#", onClick (SetState Home) ] [ text "Home" ]
--             , a [ padElement, href "#", onClick (SetState Admin) ] [ text "Admin" ]
--             ]
--         , (pageContent model)
--         ]


pageContent : Model -> Html Msg
pageContent model =
    case model.state of
        Home ->
            section []
                [ header [] [ h1 [] [ text "Provo YSA 16th Stake Summer Retreat" ] ]
                , input [ id "login", type_ "text", onInput UpdatePassword ] []
                , button [ class "btn btn-md", onClick (Login model.password) ] [ text "Login" ]
                , p [ id "error-message", style [ ( "color", "red" ) ] ]
                    [ text model.loginError ]
                , section []
                    [ -- , iframe [, , frameborder "0", allowfullscreen "True"][]
                      iframe
                        [ style [ ( "width", "560" ), ( "height", "315" ) ]
                        , src "https://www.youtube.com/embed/oob6nNCt3DQ"
                        ]
                        []
                    ]
                ]

        Registration ->
            section []
                [ header [] [ h1 [] [ text "Registration" ] ]
                , section []
                    [ header [] [ h2 [] [ text "Personal Information" ] ]
                    , input [ mediumText, type_ "text", placeholder "First Name" ] []
                    , br [] []
                    , input [ mediumText, type_ "text", placeholder "Last Name" ] []
                    , br [] []
                    , input [ mediumText, type_ "text", placeholder "Email" ] []
                    , br [] []
                    , input [ mediumText, type_ "text", placeholder "Phone Number" ] []
                    , br [] []
                    , span [ mediumText ]
                        [ text "Gender:" ]
                    , label
                        []
                        [ input [ mediumText, type_ "radio", name "gender", Attr.value "Female" ] []
                        , text "Female"
                        ]
                    , label []
                        [ input [ mediumText, type_ "radio", name "gender", Attr.value "Male" ] []
                        , text "Male"
                        ]
                    , br [] []
                    , label
                        []
                        [ text "Your Ward:"
                        , select [ mediumText ]
                            (List.map makeOption model.registration_info.wards)
                        ]
                    , p [ mediumText ]
                        [ text "Can we send email to you about the stake retreat?"
                        , label [] [ input [ type_ "checkbox", name "can-email", value "true" ] [], text "Yes" ]
                        ]
                    ]
                , hr [] []
                , section []
                    [ header [] [ h2 [] [ text "Level of Participation" ] ]
                    , p [ mediumText ] [ text "How long do you plan to attend the stake retreat?" ]
                    , label
                        [ padElement, mediumText ]
                        [ input [ type_ "radio", name "length-of-stay", Attr.value "friday" ] []
                        , text " Friday Only"
                        ]
                    , label [ padElement, mediumText ]
                        [ input [ type_ "radio", name "length-of-stay", Attr.value "overnight" ] []
                        , text " Overnight on Friday"
                        ]
                    , label [ padElement, mediumText ]
                        [ input [ type_ "radio", name "length-of-stay", Attr.value "saturday" ] []
                        , text " Saturday Only"
                        ]
                    , br [] []
                    , p [ mediumText, style [ ( "box-sizing", "float" ) ] ]
                        ((text "Please check which meals you will be eating:")
                            :: (makeEventCheckBox model.meals [])
                        )
                    , p [ mediumText ]
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
                    , p [ mediumText ]
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
                    , section [ padElement, hidden model.specialNeedsHidden ]
                        [ label [ mediumText ] [ input [ type_ "checkbox", name "wheel-chair", value "true" ] [], text "Wheel Chair Access" ]
                        , br [] []
                        , label [ mediumText ] [ input [ type_ "checkbox", name "food-allergy", value "true" ] [], text "Food Allergies" ]
                        , br [] []
                        , label [ mediumText ] [ input [ type_ "checkbox", name "other", value "true" ] [], text "Other" ]
                        , br [] []
                        , label [] [ text "Instructions:", textarea [ mediumText, cols 60, rows 1 ] [] ]
                        ]
                    ]
                , button [ class "btn btn-lg", mediumText ] [ text "Submit Registration" ]
                ]

        Admin ->
            section []
                [ h1 [] [ text "Administration Page" ]
                , table [ style [ ( "border", "2px solid black" ) ] ]
                    [ tr [] [ td [] [ text "Overnight Count:" ], td [] [ text (toString 100) ] ]
                    , tr [] [ td [] [ text "Dinner Count:" ], td [] [ text (toString 100) ] ]
                    , tr [] [ td [] [ text "Breakfast Count:" ], td [] [ text (toString 100) ] ]
                    , tr [] [ td [] [ text "Lunch Count:" ], td [] [ text (toString 100) ] ]
                    ]
                ]


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
                            label [ style [ ( "padding-left", "3px" ) ], padElement, mediumText ]
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
                    [ label [ padElement, mediumText ]
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


padElement : Attribute Msg
padElement =
    style [ ( "margin", "2px 3px 2px 3px" ) ]


pageStyle : Attribute Msg
pageStyle =
    style [ ( "margin", "50px 0px 0px 150px" ), ( "font-size", "1.2em" ) ]


mediumText : Attribute Msg
mediumText =
    style [ ( "font-size", "1.2em" ) ]

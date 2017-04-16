module Views.RegistrationView exposing (..)

import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)
import Styles.Styles as Styles
import Messages exposing (..)
import Model exposing (..)


view : Model -> Html Msg
view model =
    section [ class "jumbotron" ]
        [ header [] [ h1 [] [ text "Registration" ] ]
        , section [ class "row col-lg-12" ]
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
                [ text "Please check which activities you will attend" ]
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
        , button [ class "btn btn-info btn-lg btn-block", style Styles.mediumText ] [ text "Submit Registration" ]
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

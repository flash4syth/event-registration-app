module Views.RegistrationView exposing (..)

import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (onInput)
import Styles.Styles as Styles
import Messages exposing (..)
import Model exposing (..)
import Views.HelperFunctions exposing (..)
import Dict exposing (..)


view : Model -> Html Msg
view model =
    let
        regInfo =
            model.registration_info
    in
        section [ class "row" ]
            [ header [] [ h1 [ style Styles.centerText ] [ text "Registration" ] ]
            , section [ class "col-xs-12" ]
                --  , section [ class "jumbotron custom" ]
                [ header [] [ h2 [] [ text "Enter Personal Information" ] ]
                , label [ class "required-field" ]
                    [ text "First Name: "
                    , input
                        [ style
                            (Styles.mediumText
                                ++ (checkValidation model regInfo.first_name)
                            )
                        , type_ "text"
                        , value regInfo.first_name
                        , placeholder "First Name"
                        , onInput UpdateFirstName
                        ]
                        []
                    ]
                , br [] []
                , label [ class "required-field" ]
                    [ text "Last Name: "
                    , input
                        [ style (Styles.mediumText ++ (checkValidation model regInfo.last_name))
                        , type_ "text"
                        , value regInfo.last_name
                        , placeholder "Last Name"
                        , onInput UpdateLastName
                        ]
                        []
                    ]
                , br [] []
                , label [ class "required-field" ]
                    [ text "Email: "
                    , input
                        [ style
                            (Styles.mediumText
                                ++ (checkValidation model regInfo.email)
                            )
                        , type_ "email"
                        , value regInfo.email
                        , placeholder "Email"
                        , onInput UpdateEmail
                        ]
                        []
                    ]
                , br [] []
                , label []
                    [ text "Phone: "
                    , input
                        [ style Styles.mediumText
                        , type_ "tel"
                        , value regInfo.phone
                        , placeholder "555-555-5555"
                        , onInput UpdatePhone
                        ]
                        []
                    ]
                , br []
                    []
                , section
                    [ style (checkValidation model regInfo.gender) ]
                    [ label [ class "required-field" ]
                        [ text "Gender: "
                        , br [] []
                        , input
                            [ type_ "radio"
                            , checked (regInfo.gender == "Female")
                            , name "gender"
                            , onClick (UpdateGender "Female")
                            ]
                            []
                        , text "Male"
                        , br [] []
                        , input
                            [ type_ "radio"
                            , checked (regInfo.gender == "Male")
                            , name "gender"
                            , onClick (UpdateGender "Male")
                            ]
                            []
                        , text "Female"
                        ]
                    ]
                , br [] []
                , label
                    [ class "required-field" ]
                    [ text "Your Ward: "
                    , select
                        [ style
                            (Styles.mediumText
                                ++ (checkValidation model regInfo.selectedWard)
                            )
                        , onInput UpdateWard
                        ]
                        (List.map (makeOption regInfo.selectedWard) model.wards)
                    ]
                , hr [] []
                ]
            , section [ class "col-xs-12" ]
                [ header []
                    [ h2 [] [ text "Choose Meals" ] ]
                , p
                    [ class "required-field"
                    , style
                        (List.concat
                            [ Styles.mediumText
                            , [ ( "box-sizing", "float" )
                              ]
                            , (case
                                ( (List.isEmpty
                                    model.registration_info.meals
                                  )
                                , model.registrationValid
                                )
                               of
                                ( _, True ) ->
                                    []

                                ( False, _ ) ->
                                    []

                                ( _, _ ) ->
                                    Styles.validationError
                              )
                            ]
                        )
                    ]
                    (List.concat
                        [ [ text "Please check which meals you will be eating:" ]
                        , (makeEventCheckBox regInfo.meals model.meals)
                        , [ div []
                                [ label
                                    [ style
                                        (List.append
                                            Styles.padElement
                                            Styles.mediumText
                                        )
                                    ]
                                    [ input
                                        [ type_ "checkbox"
                                        ]
                                        []
                                    , text "No Meals"
                                      -- , span [ class "short-desc" ]
                                      --     [ text
                                      --         ("--" ++ event.blurb)
                                      --     ]
                                    ]
                                ]
                          ]
                        ]
                    )
                , hr [] []
                ]
            , section [ class "col-xs-12" ]
                [ header [] [ h2 [] [ text "Length of Stay" ] ]
                , p [ class "required-field", style Styles.mediumText ]
                    [ text "How long do you plan to attend the stake retreat?" ]
                , section [ style (checkValidation model regInfo.reg_type) ]
                    (lengthOfStayOptions regInfo.reg_type
                        [ ( "friday", " Friday Only" )
                        , ( "saturday", " Saturday Only" )
                        , ( "fridaynight", " Friday and Saturday" )
                        ]
                    )
                , p [ class "jon", style Styles.mediumText ]
                    [ text
                        ("Mattresses are not provided. Please bring your own "
                            ++ "sleeping bag and sleeping pad. "
                        )
                    ]
                , p []
                    [ a
                        [ class "btn btn-info btn-md"
                        , onClick (SetState ActivitiesPage)
                        ]
                        [ text "See Activity Details" ]
                    ]
                , hr [] []
                ]
            , section [ class "col-xs-12" ]
                --  , section [ class "jumbotron custom" ]
                [ header [] [ h2 [] [ text "Special Accommodations" ] ]
                , p [ style Styles.mediumText ]
                    [ text "Do you have any special needs?"
                    , label []
                        [ input
                            [ type_ "checkbox"
                            , onClick ToggleShowSpecialNeeds
                            ]
                            []
                        , text "Yes"
                        ]
                    ]
                , section
                    [ class "col-xs-12"
                    , style Styles.padElement
                    , hidden model.specialNeedsHidden
                    ]
                    [ label [ style Styles.mediumText ]
                        [ input
                            [ type_ "checkbox"
                            , onClick (ToggleSpecialNeedType WheelChair)
                            ]
                            []
                        , text "Wheel Chair Access"
                        ]
                    , br [] []
                    , label [ style Styles.mediumText ]
                        [ input
                            [ type_ "checkbox"
                            , onClick (ToggleSpecialNeedType FoodAllergies)
                            ]
                            []
                        , text "Food Allergies"
                        ]
                    , br [] []
                    , label [ style Styles.mediumText ]
                        [ input
                            [ type_ "checkbox"
                            , onClick (ToggleSpecialNeedType Other)
                            ]
                            []
                        , text "Other"
                        ]
                    , br [] []
                    , h3 [] [ text "How can we best accomodate you?" ]
                    , textarea
                        [ style Styles.mediumText
                        , cols 60
                        , rows 3
                        , onInput UpdateSpecialNeedDescription
                        ]
                        []
                    ]
                ]
            , p []
                [ a
                    [ class "btn btn-info btn-md"
                    , onClick (SetState MapPage)
                    ]
                    [ text "See Map" ]
                ]
            , p
                [ style
                    (List.concat
                        [ [ ( "font-weight", "bold" ) ]
                        , Styles.mediumText
                        , Styles.centerText
                        ]
                    )
                ]
                [ span []
                    [ img
                        [ height 50, width 50, src "/images/no_pets.png" ]
                        []
                    ]
                , text "NO PETS ALLOWED"
                ]
            , p
                [ style
                    (Styles.mediumText
                        ++ [ ( "color", "red" )
                           , ( "border", "2px solid red" )
                           ]
                    )
                , hidden model.registrationValid
                ]
                [ text "Please include missing information above." ]
            , button
                [ class "btn btn-info btn-lg btn-block"
                , style Styles.mediumText
                , onClick Register
                ]
                [ text "Submit Registration" ]
            ]


lengthOfStayOptions : String -> List ( String, String ) -> List (Html Msg)
lengthOfStayOptions reg_type optionList =
    List.map
        (\( value_, text_ ) ->
            label
                [ style
                    (List.append
                        Styles.padElement
                        Styles.mediumText
                    )
                , class "stacked-label"
                ]
                [ input
                    [ type_ "radio"
                    , name "length-of-stay"
                    , checked (reg_type == value_)
                    , onClick (UpdateRegistrationType value_)
                    ]
                    []
                , text text_
                ]
        )
        optionList


checkValidation : Model -> String -> List ( String, String )
checkValidation model stringValue =
    if String.isEmpty stringValue && not model.registrationValid then
        Styles.validationError
    else
        []


makeEventCheckBox : List Id -> Dict Id Event -> List (Html Msg)
makeEventCheckBox selectedMeals eventDict =
    List.map
        (\( id, event ) ->
            div []
                [ label
                    [ style
                        (List.append
                            Styles.padElement
                            Styles.mediumText
                        )
                    ]
                    [ input
                        [ type_ "checkbox"
                        , checked (List.member id selectedMeals)
                        , onClick <| UpdateMeals id
                        ]
                        []
                    , text event.name
                    , span [ class "short-desc" ]
                        [ text
                            ("--" ++ event.blurb)
                        ]
                    ]
                ]
        )
    <|
        Dict.toList eventDict


makeOption : String -> String -> Html Msg
makeOption selectedWard ward =
    option
        [ value ward
        , selected (selectedWard == ward)
        ]
        [ text ward ]

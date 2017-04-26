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
    section [ class "row" ]
        (addLogo
            :: [ header [] [ h1 [ style Styles.centerText ] [ text "Registration" ] ]
               , section [ class "col-xs-12" ]
                    --  , section [ class "jumbotron custom" ]
                    [ header [] [ h2 [] [ text "Enter Personal Information" ] ]
                    , input
                        [ style Styles.mediumText
                        , type_ "text"
                        , placeholder "First Name"
                        , onInput UpdateFirstName
                        ]
                        []
                    , br [] []
                    , input
                        [ style Styles.mediumText
                        , type_ "text"
                        , placeholder "Last Name"
                        , onInput UpdateLastName
                        ]
                        []
                    , br [] []
                    , input
                        [ style Styles.mediumText
                        , type_ "text"
                        , placeholder "Email"
                        , onInput UpdateEmail
                        ]
                        []
                    , br [] []
                    , input
                        [ style Styles.mediumText
                        , type_ "tel"
                        , placeholder "555-555-5555"
                        , onInput UpdatePhone
                        ]
                        []
                    , br [] []
                    , span [ style Styles.mediumText ]
                        [ text "Gender:" ]
                    , label
                        []
                        [ input
                            [ style Styles.mediumText
                            , type_ "radio"
                            , name "gender"
                            , onClick (UpdateGender "Female")
                            ]
                            []
                        , text "Female"
                        ]
                    , label []
                        [ input
                            [ style Styles.mediumText
                            , type_ "radio"
                            , name "gender"
                            , onClick (UpdateGender "Male")
                            ]
                            []
                        , text "Male"
                        ]
                    , br [] []
                    , label
                        []
                        [ text "Your Ward:"
                        , select [ style Styles.mediumText, onInput UpdateWard ]
                            (List.map makeOption model.wards)
                        ]
                    ]
               , hr [] []
               , section [ class "col-xs-12" ]
                    [ header []
                        [ h2 [] [ text "Choose Meals and Length of Stay" ]
                        , h3 []
                            [ a
                                [ class "btn btn-info btn-md"
                                , onClick (SetState ActivitiesPage)
                                ]
                                [ text "Click for Activity Details" ]
                            ]
                        ]
                    , p [ style Styles.mediumText ]
                        [ text
                            ("For those staying overnight, the bed availability is on "
                                ++ "a first come first serve basis.  You will need to be prepared to "
                                ++ "sleep on the floor."
                            )
                        ]
                    , p [ style Styles.mediumText ] [ text "How long do you plan to attend the stake retreat?" ]
                    , div []
                        (lengthOfStayOptions
                            [ ( "friday", " Friday Only" )
                            , ( "fridaynight", " Overnight on Friday" )
                            , ( "saturday", " Saturday Only" )
                            ]
                        )
                    , br [] []
                    , p
                        [ style
                            (List.append Styles.mediumText
                                [ ( "box-sizing", "float" )
                                ]
                            )
                        ]
                        ((text "Please check which meals you will be eating:")
                            :: (makeEventCheckBox model.meals)
                        )
                    ]
               , hr [] []
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
               , button
                    [ class "btn btn-info btn-lg btn-block"
                    , style Styles.mediumText
                    ]
                    [ text "Submit Registration" ]
               ]
        )


lengthOfStayOptions : List ( String, String ) -> List (Html Msg)
lengthOfStayOptions optionList =
    List.map
        (\( value_, text_ ) ->
            label
                [ style
                    (List.append
                        Styles.padElement
                        Styles.mediumText
                    )
                ]
                [ input
                    [ type_ "radio"
                    , name "length-of-stay"
                    , onClick (UpdateRegistrationType value_)
                    ]
                    []
                , text text_
                ]
        )
        optionList


makeEventCheckBox : Dict Id Event -> List (Html Msg)
makeEventCheckBox eventDict =
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


makeOption : String -> Html Msg
makeOption ward =
    option [ value ward ] [ text ward ]

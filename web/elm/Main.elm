module Main exposing (..)

import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)


-- import Http
-- import Json.Decode as Json exposing (..)
-- import Json.Decode.Pipeline as JsonPipeline exposing (decode, required)
-- import RegistrationView


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    ( { meals =
            [ { name = "Friday Dinner"
              , event_id = 1
              , start_datetime = "Friday 6:00pm"
              , end_datetime = "Friday 8:00pm"
              , location = "Pavilion"
              , picture = ""
              , short_description = "Roast Beef and Bread"
              , long_description = ""
              }
            , { name = "Saturday Breakfast"
              , event_id = 2
              , start_datetime = "Saturday 8:00am"
              , end_datetime = "Saturday 9:30am"
              , location = "Pavilion"
              , picture = ""
              , short_description = "Breakfast Burritos"
              , long_description = ""
              }
            , { name = "Saturday Lunch"
              , event_id = 3
              , start_datetime = "Saturday 12:00pm"
              , end_datetime = "Saturday 1:00pm"
              , location = "Pavilion"
              , picture = ""
              , short_description = "PB&J Mmmm!"
              , long_description = ""
              }
            ]
      , activities =
            [ { name = "Friday Night Star Gazing"
              , event_id = 4
              , start_datetime = ""
              , end_datetime = ""
              , location = ""
              , picture = ""
              , short_description = "Explore the universe"
              , long_description = ""
              }
            , { name = "Friday Night Devotional"
              , event_id = 5
              , start_datetime = ""
              , end_datetime = ""
              , location = ""
              , picture = ""
              , short_description = "Spiritual Feast"
              , long_description = ""
              }
            , { name = "Saturday Afternoon Speaker: Brad Wilcox"
              , event_id = 6
              , start_datetime = ""
              , end_datetime = ""
              , location = ""
              , picture = ""
              , short_description = "A wonderful man"
              , long_description = ""
              }
            ]
      , registration_info =
            { first_name = ""
            , reg_type = ""
            , consented_to_email = False
            , last_name = ""
            , special_needs =
                { need_type = ""
                , description = ""
                }
            , gender = ""
            , email = ""
            , selectedWard = ""
            , specialNeedsHidden = True
            , activities = []
            , meals = []
            , wards =
                [ "Select Ward"
                , "93rd"
                , "98th"
                , "99th"
                , "100th"
                , "227th"
                , "228th"
                , "229th"
                , "230th"
                , "231st"
                , "232nd"
                , "233rd"
                , "235th"
                ]
            }
      , password = ""
      , state = Registration
      , loginError = ""
      }
    , Cmd.none
    )


type alias Model =
    { meals : List Event
    , activities : List Event
    , registration_info : RegistrationInfo
    , password : String
    , state : UiState
    , loginError : String
    }


type alias RegistrationInfo =
    { first_name : String
    , reg_type : String
    , consented_to_email : Bool
    , last_name : String
    , special_needs : SpecialNeeds
    , gender : String
    , email : String
    , selectedWard : String
    , wards : List String
    , specialNeedsHidden : Bool
    , surveys : List Survey
    , activities : List Activity
    , meals : List Int
    }


type alias Event =
    { name : String
    , event_id : Int
    , start_datetime : String
    , end_datetime : String
    , location : String
    , picture : String
    , short_description : String
    , long_description : String
    }


type alias SpecialNeeds =
    { need_type : String
    , description : String
    }


type alias Activity =
    { activity_id : Int
    , interest_level : String
    }


type UiState
    = Home
    | Admin
    | Registration


type Msg
    = UpdatePassword String
    | SetState UiState
    | Login String
    | AddActivity Int String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdatePassword newPassword ->
            ( { model | password = newPassword }, Cmd.none )

        SetState newState ->
            ( { model | state = newState }, Cmd.none )

        Login password ->
            if (String.toLower password) == "provo16stake" then
                ( { model | state = Registration }, Cmd.none )
            else
                ( { model | loginError = "That password is incorrect." }
                , Cmd.none
                )

        AddActivity event_id interest_level ->
          let activities = []
          in
            ( {model | registration_info = .activities = activities}, Cmd.none )


activityMap : (a -> a) -> (a -> Bool) -> List a -> List a
activityMap mapper check activities =
  List.map (\activity -> if check activity then mapper else activity)
  activities
{--
            let
              newEvents =
                model.event
                |> List.map
                  (\event ->
                  if event.event_id == event_id then
                  {event | field = newFieldValue})
                  else
                    event -- unchanged event
            in
            ( {model | events = newEvents}, Cmd.none)


          -- A more abstracted example:
          mapIf : (a -> a) -> (a -> Bool) -> List a -> List a
          mapIf mapper check xs =
            List.map (\x -> if check x then mapper else x) xs
            --}


view : Model -> Html Msg
view model =
    article [ pageStyle ]
        [ nav []
            [ a [ padElement, href "#", onClick (SetState Home) ] [ text "Home" ]
            , a [ padElement, href "#", onClick (SetState Admin) ] [ text "Admin" ]
            ]
        , (pageContent model)
        ]


pageContent : Model -> Html Msg
pageContent model =
    case model.state of
        Home ->
            section []
                [ header [] [ h1 [] [ text "Home" ] ]
                , input [ id "login", type_ "text", onInput UpdatePassword ] []
                , button [ onClick (Login model.password) ] [ text "Login" ]
                , p [ id "error-message", style [ ( "color", "red" ) ] ]
                    [ text model.loginError ]
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
                        [ mediumText ]
                        [ input [ type_ "radio", name "length-of-stay", Attr.value "friday" ] []
                        , text "Friday Only"
                        ]
                    , label [ mediumText ]
                        [ input [ type_ "radio", name "length-of-stay", Attr.value "overnight" ] []
                        , text "Overnight on Friday"
                        ]
                    , label [ mediumText ]
                        [ input [ type_ "radio", name "length-of-stay", Attr.value "saturday" ] []
                        , text "Saturday Only"
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
                                ++ "(1- not interested, 5- very interested):"
                            )
                         )
                            :: (makeEventCheckBox model.activities
                                    [ "Interested", "Very Interested" ]
                               )
                        )
                    ]
                , hr [] []
                , section []
                    [ header [] [ h2 [] [ text "Special Accommodations" ] ]
                    , p [ mediumText ]
                        [ text "Do you have any special needs?"
                        , label [] [ input [ type_ "checkbox" ] [], text "Yes" ]
                        ]
                    , section [ hidden True ]
                        [ label [ mediumText ] [ input [ type_ "checkbox", name "wheel-chair", value "true" ] [], text "Wheel Chair Access" ]
                        , br [] []
                        , label [ mediumText ] [ input [ type_ "checkbox", name "food-allergy", value "true" ] [], text "Food Allergies" ]
                        , br [] []
                        , label [ mediumText ] [ input [ type_ "checkbox", name "other", value "true" ] [], text "Other" ]
                        , br [] []
                        , label [] [ text "Instructions:", textarea [ mediumText, cols 60, rows 1 ] [] ]
                        ]
                    ]
                , button [ mediumText ] [ text "Submit Registration" ]
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
                            label [ mediumText ]
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
                    [ label [ mediumText ]
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
    style [ ( "padding", "2px 3px 2px 3px" ) ]


pageStyle : Attribute Msg
pageStyle =
    style [ ( "margin", "50px 0px 0px 150px" ), ( "font-size", "1.2em" ) ]


mediumText : Attribute Msg
mediumText =
    style [ ( "font-size", "1.2em" ) ]



-- subscriptions : Model -> Sub Msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

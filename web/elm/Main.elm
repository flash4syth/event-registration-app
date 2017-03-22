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
    ( { first_name = ""
      , last_name = ""
      , special_needs = ""
      , meals = []
      , driving = True
      , registration_type = ""
      , gender = ""
      , email = ""
      , password = ""
      , state = Home
      , loginError = ""
      , wards =
            [ "93rd"
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
    , Cmd.none
    )


type alias Model =
    { first_name : String
    , last_name : String
    , special_needs : String
    , meals : List String
    , driving : Bool
    , registration_type : String
    , gender : String
    , email : String
    , password : String
    , wards : List String
    , state : UiState
    , loginError : String
    }


type UiState
    = Home
    | Admin
    | Registration


type Msg
    = UpdatePassword String
    | SetState UiState
    | Login String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdatePassword newPassword ->
            ( { model | password = newPassword }, Cmd.none )

        SetState newState ->
            ( { model | state = newState }, Cmd.none )

        Login password ->
            if password == "provo16stake" then
                ( { model | state = Registration }, Cmd.none )
            else
                ( { model | loginError = "That password is incorrect." }
                , Cmd.none
                )


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
                [ h1 [] [ text "Home" ]
                , input [ id "login", type_ "text", onInput UpdatePassword ] []
                , button [ onClick (Login model.password) ] [ text "Login" ]
                , p [ id "error-message", style [ ( "color", "red" ) ] ]
                    [ text model.loginError ]
                ]

        Registration ->
            section []
                [ h1 [] [ text "Registration" ]
                , input [ mediumText, type_ "text", placeholder "First Name" ] []
                , br [] []
                , input [ mediumText, type_ "text", placeholder "Last Name" ] []
                , br [] []
                , input [ mediumText, type_ "text", placeholder "Email" ] []
                , br [] []
                , input [ mediumText, type_ "text", placeholder "Phone Number" ] []
                , br [] []
                , label []
                    [ text "Your Ward:"
                    , select [ mediumText ]
                        (List.map makeOption model.wards)
                    ]
                , br [] []
                , p [ mediumText ]
                    [ text "Gender:" ]
                  -- , label [ for "female-gender" ] [ text "Female" ]
                  -- , input [ id "female-gender", type_ "radio", name "gender", Attr.value "Female" ] []
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
                , p [ mediumText ] [ text "Will you be spending the night on Friday?" ]
                , label
                    [ mediumText ]
                    [ input [ type_ "radio", name "overnight", Attr.value "Yes" ] []
                    , text "Yes"
                    ]
                , label [ mediumText ]
                    [ input [ type_ "radio", name "overnight", Attr.value "No", checked True ] []
                    , text "No"
                    ]
                , br [] []
                , p [ mediumText ]
                    [ (text "Please check which meals you will be eating:")
                    , br [] []
                    , label [ mediumText ] [ input [ type_ "checkbox" ] [], text "Friday Dinner" ]
                    , br [] []
                    , label [ mediumText ] [ input [ type_ "checkbox" ] [], text "Saturday Breakfast" ]
                    , br [] []
                    , label [ mediumText ] [ input [ type_ "checkbox" ] [], text "Saturday Lunch" ]
                    ]
                , p [ mediumText ]
                    [ (text "Please check which activities you will attend:")
                    , br [] []
                    , label [ mediumText ] [ input [ type_ "checkbox" ] [], text "Friday Night Star Gazing" ]
                    , br [] []
                    , label [ mediumText ] [ input [ type_ "checkbox" ] [], text "Saturday Afternoon Speaker: Brad Wilcox" ]
                    , br [] []
                    , label [ mediumText ] [ input [ type_ "checkbox" ] [], text "Friday Night Devotional" ]
                    ]
                  -- ,input [type_ "radio"] []
                  -- ,input [type_ "radio"] []
                  -- ,input [type_ "radio"] []
                  -- ,input [type_ "radio"] []
                , hr [] []
                , p [ mediumText ]
                    [ (text "If you have any special needs, please describe them below:")
                    , br [] []
                    , textarea [ mediumText, cols 60, rows 10 ] []
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

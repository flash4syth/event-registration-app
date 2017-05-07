module Views.ScheduleView exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Styles.Styles as Styles
import Views.HelperFunctions exposing (addLogo, onClick)
import Messages exposing (Msg(..))
import Model exposing (UiState(..))


type alias HardCodedEvent =
    { time : String
    , name : String
    , location : String
    , details : String
    }


view : Html Msg
view =
    let
        fridayEvents =
            [ { time = "4:30 pm - 6:30 pm"
              , name = "Check In"
              , location = "Lower parking lot at Heber Valley Camp"
              , details =
                    ("Make sure to check in at the registration tables to get "
                        ++ "your name badge, swag, and to find out where your "
                        ++ "ward is assigned."
                    )
              }
            , { time = "5:00 pm - 6:30 pm"
              , name = "Dinner"
              , location = "Smith or Esther Pavilions"
              , details =
                    ("Dinner will be served in both pavilions and will end "
                        ++ "at 6:30 in time to get seated for the devotional"
                    )
              }
            , { time = "7:00 pm - 8:00 pm"
              , name = "Devotional"
              , location = "Smith Amphitheater"
              , details = "There aren't enough seats to accommodate everyone, so make sure to bring your camp chairs."
              }
            , { time = "8:00 pm - 10:00 pm"
              , name = "Activities"
              , location = "Various"
              , details = "Bonfire w/s'mores, stargazing, dance, glow in the dark crafts, and more!"
              }
            , { time = "10:00 pm"
              , name = "Quiet hours / Ward time"
              , location = "Ward campsites"
              , details = ""
              }
            ]

        saturdayEvents =
            [ { time = "8:00 am - 8:45 am"
              , name = "Morningside with Bishoprics"
              , location = "Ward campsites"
              , details = ""
              }
            , { time = "9:00 am - 9:45 am"
              , name = "Breakfast"
              , location = "Smith or Esther Pavilions"
              , details = "Breakfast will be served in both pavilions."
              }
            , { time = "10:00 am - 11:30 am"
              , name = "Service Project"
              , location = "Smith or Esther Pavilions"
              , details = "The service project will be the same in both pavilions."
              }
            , { time = "11:30 am - 12:30 pm"
              , name = "Clean Up & Check Out"
              , location = "Ward campsites"
              , details = "More details from ward activities co-chairs."
              }
            , { time = "12:30 pm - 1:15 pm"
              , name = "Lunch"
              , location = "Smith Pavilion"
              , details = ""
              }
            , { time = "1:30 pm - 2:30 pm"
              , name = "Speaker: Brad Wilcox"
              , location = "Esther Pavillion"
              , details = ""
              }
            , { time = "2:30 PM"
              , name = "End of Retreat"
              , location = ""
              , details = ""
              }
            ]
    in
        section [ class "row" ]
            (addLogo
                :: [ header []
                        [ h1 [ style Styles.centerText ] [ text "Full Schedule" ] ]
                   , (makeTable fridayEvents saturdayEvents "FRIDAY" "SATURDAY")
                   ]
            )


makeTable : List HardCodedEvent -> List HardCodedEvent -> String -> String -> Html Msg
makeTable eventList1 eventList2 day1 day2 =
    let
        show_activity_link : String -> Html Msg
        show_activity_link event_name =
            if event_name == "Activities" then
                a [ onClick (SetState ActivitiesPage) ] [ text " see activities" ]
            else
                span [] []

        fridayRows =
            List.map
                (\event ->
                    tr []
                        [ td [] [ text event.time ]
                        , td [] [ text event.name ]
                        , td [] [ text event.location ]
                        , td []
                            [ text event.details
                            , show_activity_link event.name
                            ]
                        ]
                )
                eventList1

        saturdayRows =
            List.map
                (\event ->
                    tr []
                        [ td [] [ text event.time ]
                        , td [] [ text event.name ]
                        , td [] [ text event.location ]
                        , td [] [ text event.details ]
                        ]
                )
                eventList2
    in
        table [ class "table table-bordered table-striped" ]
            [ thead []
                [ tr []
                    [ th [] [ text "Time" ]
                    , th [] [ text "Event" ]
                    , th [] [ text "Location" ]
                    , th [] [ text "Details" ]
                    ]
                , tr [] [ th [ colspan 5, scope "colgroup" ] [ text day1 ] ]
                ]
            , tbody [] (fridayRows)
            , thead []
                [ tr [] [ th [ colspan 5, scope "colgroup" ] [ text day2 ] ]
                ]
            , tbody [] (saturdayRows)
            ]

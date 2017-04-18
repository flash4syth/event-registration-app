module Views.ScheduleView exposing (..)

import Messages exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Styles.Styles as Styles
import Views.HelperFunctions exposing (..)


view : Model -> Html Msg
view model =
    section [ class "row" ]
        (addLogo
            :: [ header []
                    [ h1 [ style Styles.centerText ] [ text "Full Schedule" ] ]
               , table
                    [ class "table table-bordered table-striped" ]
                    [ thead []
                        [ tr []
                            [ th [] [ text "Date" ]
                            , th [] [ text "Location" ]
                            , th [] [ text "Description" ]
                            ]
                        ]
                    , tbody []
                        (makeRows (List.append model.activities model.meals))
                    ]
               ]
        )


makeRows : List Event -> List (Html Msg)
makeRows eventList =
    List.map
        (\event ->
            tr []
                [ td [] [ text event.start_datetime ]
                , td [] [ text event.location ]
                , td [] [ text event.short_description ]
                ]
        )
        eventList

module Update exposing (..)

import Messages exposing (..)
import Model exposing (..)
import Dict exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetState newState ->
            { model
                | state = newState
                , menuOptionsHidden = True
            }
                ! []

        ToggleSpecialNeeds ->
            let
                truth =
                    case model.specialNeedsHidden of
                        True ->
                            False

                        False ->
                            True
            in
                { model | specialNeedsHidden = truth } ! []

        Blur ->
            { model | menuOptionsHidden = True } ! []

        DropDownClicked ->
            { model | menuOptionsHidden = not model.menuOptionsHidden } ! []

        ToggleEditMode ->
            { model | editModeActive = not model.editModeActive } ! []

        AddEvent ->
            let
                newActivity =
                    { name = "New"
                    , start_datetime = "Needs Time"
                    , end_datetime = ""
                    , location = "Needs Location"
                    , picture = ""
                    , short_description = "Needs Blurb"
                    , long_description = "Needs Description"
                    , eventModified = True
                    }

                -- reverseActivityList =
                --     List.reverse model.activities
                newActivityDict =
                    Dict.insert -1 newActivity model.activities
            in
                ({ model
                    | activities = newActivityDict
                    , editModeActive = True
                 }
                    ! []
                )

        UpdateFood ->
            ({ model | editModeActive = False } ! [])

        UpdateEvent field id inputText ->
            let
                updatedActivities =
                    case Dict.get id model.activities of
                        Nothing ->
                            model.activities

                        Just event ->
                            Dict.insert id
                                (case field of
                                    Blurb ->
                                        { event
                                            | short_description = inputText
                                            , eventModified = True
                                        }

                                    Description ->
                                        { event
                                            | long_description = inputText
                                            , eventModified = True
                                        }

                                    Name ->
                                        { event
                                            | name = inputText
                                            , eventModified = True
                                        }

                                    StartTime ->
                                        { event
                                            | start_datetime = inputText
                                            , eventModified = True
                                        }

                                    Location ->
                                        { event
                                            | start_datetime = inputText
                                            , eventModified = True
                                        }
                                )
                                model.activities
            in
                ({ model | activities = updatedActivities } ! [])



--             let
--                 updatedActivities = updateEventDict id model.activities inputText
--             in
--                 ({ model | activities = updatedActivities } ! [])
--
-- updateEventDict : Id -> Dict Id Event -> String -> Dict Id Event
-- updateEventDict id eventDict inputText
--   case (Dict.get id eventDict) of
--       Nothing ->
--           eventDict
--
--       Just event ->
--           Dict.insert id
--               { event | long_description = inputText }
--               eventDict
{--
activityMap : (a -> a) -> (a -> Bool) -> List a -> List a
activityMap mapper check activities =
  List.map (\activity -> if check activity then mapper else activity)
  activities
  --}
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

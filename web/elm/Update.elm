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
                    , datetime = "Needs Time"
                    , location = "Needs Location"
                    , image = ""
                    , blurb = "Needs Blurb"
                    , description = "Needs Description"
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
                                            | blurb = inputText
                                            , eventModified = True
                                        }

                                    Description ->
                                        { event
                                            | description = inputText
                                            , eventModified = True
                                        }

                                    Name ->
                                        { event
                                            | name = inputText
                                            , eventModified = True
                                        }

                                    StartTime ->
                                        { event
                                            | datetime = inputText
                                            , eventModified = True
                                        }

                                    Location ->
                                        { event
                                            | location = inputText
                                            , eventModified = True
                                        }
                                )
                                model.activities
            in
                ({ model | activities = updatedActivities } ! [])

        SaveEdits eventType ->
            case eventType of
                Activity ->
                    let
                        modifiedActivities =
                            fromList <|
                                List.filter (\( _, activity ) -> activity.eventModified)
                                    (toList model.activities)
                    in
                        -- (model, postUpdatedEvents model)
                        { model | activities = modifiedActivities } ! []

                Meal ->
                    let
                        modifiedMeals =
                            fromList <|
                                List.filter (\( _, meal ) -> meal.eventModified)
                                    (toList model.meals)
                    in
                        -- (model, postUpdatedEvents model)
                        { model | meals = modifiedMeals } ! []

        FetchResult (Ok initJson) ->
            let
                ( _, newMealDict ) =
                    eventWithIdMapper ( initJson.meals, Dict.empty )

                ( _, newActivityDict ) =
                    eventWithIdMapper ( initJson.activities, Dict.empty )

                currentRegistrationInfo =
                    model.registration_info

                newRegistrationInfo =
                    { currentRegistrationInfo | wards = initJson.wards }
            in
                { model
                    | activities = newActivityDict
                    , meals = newMealDict
                    , registration_info = newRegistrationInfo
                }
                    ! []

        FetchResult (Err _) ->
            model ! []


eventWithIdMapper :
    ( List EventWithId, Dict Id Event )
    -> ( List EventWithId, Dict Id Event )
eventWithIdMapper ( eventWithIdList, eventDict ) =
    case eventWithIdList of
        [] ->
            ( eventWithIdList, eventDict )

        headEventWithId :: tailEventsWithId ->
            let
                newEvent =
                    { name = headEventWithId.name
                    , datetime = headEventWithId.datetime
                    , location = headEventWithId.location
                    , image = headEventWithId.image
                    , blurb = headEventWithId.blurb
                    , description = headEventWithId.description
                    , eventModified = headEventWithId.eventModified
                    }

                newId =
                    headEventWithId.id
            in
                eventWithIdMapper
                    ( tailEventsWithId
                    , (Dict.insert newId newEvent eventDict)
                    )



-- postUpdatedEvents : Model -> Cmd Msg
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
--               { event | description = inputText }
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

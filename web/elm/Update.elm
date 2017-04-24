module Update exposing (..)

import Messages exposing (..)
import Model exposing (..)
import Dict exposing (..)
import SrHttp exposing (postUpdatedEvents)


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
                        modifiedActivitiesList =
                            List.filter
                                (\( _, activity ) -> activity.eventModified)
                                (toList model.activities)
                    in
                        ( { model | editModeActive = False }
                        , postUpdatedEvents eventType
                            modifiedActivitiesList
                        )

                Meal ->
                    let
                        modifiedMealList =
                            List.filter
                                (\( _, meal ) -> meal.eventModified)
                                (toList model.meals)
                    in
                        ( { model | editModeActive = False }
                        , postUpdatedEvents eventType
                            modifiedMealList
                        )

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

        PostEventEdits eventType (Ok eventWithIdList) ->
            case eventType of
                Activity ->
                    let
                        ( _, newActivityDict ) =
                            eventWithIdMapper ( eventWithIdList, Dict.empty )

                        updatedActivityDict =
                            Dict.union newActivityDict
                                model.activities
                    in
                        { model | activities = updatedActivityDict } ! []

                Meal ->
                    let
                        ( _, newMealDict ) =
                            eventWithIdMapper ( eventWithIdList, Dict.empty )

                        updatedMealDict =
                            Dict.union newMealDict
                                model.meals
                    in
                        { model | meals = updatedMealDict } ! []

        PostEventEdits _ (Err _) ->
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

module Update exposing (..)

import Messages exposing (..)
import Model exposing (..)
import Dict exposing (..)
import SrHttp exposing (postUpdatedEvents, postRegistration)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetState newState ->
            { model
                | state = newState
                , menuOptionsHidden = True
            }
                ! []

        ToggleShowSpecialNeeds ->
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
            in
                { model
                    | activities = newActivityDict
                    , meals = newMealDict
                    , wards = ("Select Ward" :: initJson.wards)
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

        UpdateFirstName newValue ->
            let
                old_registration =
                    model.registration_info

                new_registration =
                    { old_registration | first_name = newValue }
            in
                { model | registration_info = new_registration } ! []

        UpdateLastName newValue ->
            let
                old_registration =
                    model.registration_info

                new_registration =
                    { old_registration | last_name = newValue }
            in
                { model | registration_info = new_registration } ! []

        UpdateRegistrationType newValue ->
            let
                old_registration =
                    model.registration_info

                new_registration =
                    { old_registration | reg_type = newValue }
            in
                { model | registration_info = new_registration } ! []

        ToggleSpecialNeedType typeTag ->
            let
                old_specialneeds_types =
                    model.registration_info.special_needs.need_types

                old_specialneeds =
                    model.registration_info.special_needs

                old_registration =
                    model.registration_info

                new_specialneeds_types =
                    (case typeTag of
                        WheelChair ->
                            { old_specialneeds_types
                                | wheelChair =
                                    not old_specialneeds_types.wheelChair
                            }

                        FoodAllergies ->
                            { old_specialneeds_types
                                | foodAllergy =
                                    not old_specialneeds_types.foodAllergy
                            }

                        Other ->
                            { old_specialneeds_types
                                | other =
                                    not old_specialneeds_types.other
                            }
                    )

                new_specialneeds =
                    { old_specialneeds
                        | need_types =
                            new_specialneeds_types
                    }

                new_registration =
                    { old_registration | special_needs = new_specialneeds }
            in
                { model | registration_info = new_registration } ! []

        UpdateSpecialNeedDescription newValue ->
            let
                old_specialneeds =
                    model.registration_info.special_needs

                old_registration =
                    model.registration_info

                new_specialneeds =
                    { old_specialneeds | description = newValue }

                new_registration =
                    { old_registration | special_needs = new_specialneeds }
            in
                { model | registration_info = new_registration } ! []

        UpdateGender newValue ->
            let
                old_registration =
                    model.registration_info

                new_registration =
                    { old_registration | gender = newValue }
            in
                { model | registration_info = new_registration } ! []

        UpdateEmail newValue ->
            let
                old_registration =
                    model.registration_info

                new_registration =
                    { old_registration | email = newValue }
            in
                { model | registration_info = new_registration } ! []

        UpdatePhone newValue ->
            let
                old_registration =
                    model.registration_info

                new_registration =
                    { old_registration | phone = newValue }
            in
                { model | registration_info = new_registration } ! []

        UpdateWard newWard ->
            let
                old_registration =
                    model.registration_info

                new_registration =
                    { old_registration | selectedWard = newWard }
            in
                { model | registration_info = new_registration } ! []

        UpdateMeals mealId ->
            let
                add_rem_mealId : Id -> List Id -> List Id
                add_rem_mealId mealId mealIds =
                    -- filter out or add the meal id depending on its existence
                    if List.member mealId mealIds then
                        List.filter (\id -> id /= mealId) mealIds
                    else
                        mealId :: mealIds

                old_registration =
                    model.registration_info

                new_registration =
                    { old_registration
                        | meals =
                            (add_rem_mealId mealId old_registration.meals)
                    }
            in
                { model | registration_info = new_registration } ! []

        Register ->
            let
                reg_info =
                    model.registration_info

                isValid =
                    if
                        List.isEmpty
                            (List.filter String.isEmpty
                                [ reg_info.first_name
                                , reg_info.last_name
                                , reg_info.email
                                , reg_info.gender
                                , reg_info.selectedWard
                                , reg_info.phone
                                , reg_info.reg_type
                                ]
                            )
                            && not (List.isEmpty reg_info.meals)
                    then
                        True
                    else
                        False
            in
                if isValid then
                    model ! [ postRegistration model ]
                else
                    { model | registrationValid = False } ! []

        PostRegistration (Ok successMsg) ->
            { initialModel
                | meals = model.meals
                , activities = model.activities
                , wards = model.wards
            }
                ! []

        PostRegistration (Err errorMsg) ->
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

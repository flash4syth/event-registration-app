module Update exposing (..)

import Messages exposing (..)
import Model exposing (..)


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
                    , event_id = -1
                    , start_datetime = "Needs Time"
                    , end_datetime = ""
                    , location = "Needs Location"
                    , picture = ""
                    , short_description = "Needs Blurb"
                    , long_description = "Needs Description"
                    }

                reverseActivityList =
                    List.reverse model.activities

                newActivityList =
                    List.reverse (newActivity :: reverseActivityList)
            in
                ( { model
                    | activities = newActivityList
                    , editModeActive = True
                  }
                , Cmd.none
                )



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

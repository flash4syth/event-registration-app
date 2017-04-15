module Update exposing (..)

import Messages exposing (..)
import Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetState newState ->
            { model | state = newState } ! []

        Register ->
            { model | state = Registration } ! []

        Map ->
            { model | state = MapPage } ! []

        Activities ->
            { model | state = ActivitiesPage } ! []

        Food ->
            { model | state = FoodPage } ! []

        Schedule ->
            { model | state = SchedulePage } ! []

        Cabins ->
            { model | state = CabinsPage } ! []

        Packing ->
            { model | state = PackingPage } ! []

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



{--AddActivity event_id interest_level ->
          let activities = []
          in
            ( {model | registration_info = .activities = activities}, Cmd.none )


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

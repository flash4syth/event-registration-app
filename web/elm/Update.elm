module Update exposing (..)

import Messages exposing (..)
import Model exposing (..)


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
            else if password == "" then
                ( { model | state = Registration }, Cmd.none )
            else
                ( { model | loginError = "That password is incorrect." }
                , Cmd.none
                )

        ToggleSpecialNeeds ->
            let
                truth =
                    case model.specialNeedsHidden of
                        True ->
                            False

                        False ->
                            True
            in
                ( { model | specialNeedsHidden = truth }, Cmd.none )



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

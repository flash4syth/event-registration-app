module Messages exposing (..)

import Model exposing (..)
import Http


type Msg
    = SetState UiState
    | ToggleSpecialNeeds
    | Blur
    | DropDownClicked
    | ToggleEditMode
    | AddEvent
    | UpdateFood
      {--Id--}
    | UpdateEvent EventField Id String
    | SaveEdits EventType
    | FetchResult (Result Http.Error InitJson)
    | PostEventEdits EventType (Result Http.Error (List EventWithId))


type EventField
    = Blurb
    | Description
    | Name
    | StartTime
    | Location


type EventType
    = Activity
    | Meal



-- | AddActivity Int String

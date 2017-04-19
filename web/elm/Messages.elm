module Messages exposing (..)

import Model exposing (..)


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


type EventField
    = Blurb
    | Description
    | Name



-- | AddActivity Int String

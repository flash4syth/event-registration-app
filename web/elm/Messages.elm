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
    | UpdateActivityDescription Id String
    | UpdateActivityBlurb Id String



-- | AddActivity Int String

module Messages exposing (..)

import Model exposing (..)
import Http


type Msg
    = SetState UiState
    | ToggleShowSpecialNeeds
    | Blur
    | DropDownClicked
    | ToggleEditMode
    | AddEvent
    | UpdateFirstName String
    | UpdateLastName String
    | UpdateRegistrationType String
    | ToggleSpecialNeedType SpecialNeedTypeTag
    | UpdateSpecialNeedDescription String
    | UpdateGender String
    | UpdateEmail String
    | UpdatePhone String
    | UpdateWard String
    | UpdateMeals Id
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


type SpecialNeedTypeTag
    = WheelChair
    | FoodAllergies
    | Other



-- | AddActivity Int String

module Model exposing (..)

import Dict exposing (Dict)


type alias Id =
    Int


type TagType tag
    = TagType tag


initialModel : Model
initialModel =
    { meals = Dict.empty
    , activities = Dict.empty
    , registration_info =
        { first_name = ""
        , reg_type = ""
        , last_name = ""
        , special_needs =
            { need_type = ""
            , description = ""
            }
        , gender = ""
        , email = ""
        , selectedWard = ""
        , meals = []
        , wards = []
        }
    , editModeActive = False
    , specialNeedsHidden = True
    , menuOptionsHidden = True
    , password = ""
    , state = HomePage
    , userType = AdminUser
    , loginError = ""
    }


wardList : List String
wardList =
    [ "Select Ward"
    , "93rd"
    , "98th"
    , "99th"
    , "100th"
    , "227th"
    , "228th"
    , "229th"
    , "230th"
    , "231st"
    , "232nd"
    , "233rd"
    , "235th"
    ]


type alias Model =
    { meals : Dict Id Event
    , activities : Dict Id Event
    , registration_info : RegistrationInfo
    , password : String
    , state : UiState
    , userType : UserType
    , loginError : String
    , specialNeedsHidden : Bool
    , menuOptionsHidden : Bool
    , editModeActive : Bool
    }


type alias RegistrationInfo =
    { first_name : String
    , reg_type : String
    , last_name : String
    , special_needs : SpecialNeeds
    , gender : String
    , email : String
    , selectedWard : String
    , wards : List String
    , meals :
        List Int
        -- , activities : List Int
    }


type alias SpecialNeeds =
    { need_type : String
    , description : String
    }


type UiState
    = HomePage
    | AdminPage
    | RegistrationPage
    | MapPage
    | ActivitiesPage
    | FoodPage
    | SchedulePage
    | CabinsPage
    | PackingPage


type UserType
    = AdminUser
    | MemberUser
    | AnonymousUser



-- Events are Meals or Activities


type alias Event =
    { name : String
    , datetime : String
    , location : String
    , image : String
    , blurb : String
    , description : String
    , eventModified : Bool
    }


type alias EventWithId =
    { id : Int
    , name : String
    , datetime : String
    , location : String
    , image : String
    , blurb : String
    , description : String
    , eventModified : Bool
    }


type alias InitJson =
    { wards : List String
    , meals : List EventWithId
    , activities : List EventWithId
    }

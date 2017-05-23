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
    , wards = []
    , registration_info =
        { first_name = ""
        , reg_type = ""
        , last_name = ""
        , special_needs =
            { need_types =
                { wheelChair = False
                , foodAllergy = False
                , other = False
                }
            , description = ""
            }
        , gender = ""
        , email = ""
        , phone = ""
        , selectedWard = ""
        , meals = []
        , no_meals = False
        }
    , registrationValid = True
    , editModeActive = False
    , specialNeedsHidden = True
    , menuOptionsHidden = True
    , password = ""
    , state = HomePage
    , userType = AnonymousUser
    , loginError = ""
    }


type alias Model =
    { meals : Dict Id Event
    , activities : Dict Id Event
    , wards : List String
    , registration_info : RegistrationInfo
    , registrationValid : Bool
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
    , phone : String
    , selectedWard : String
    , meals : List Id
    , no_meals : Bool
    }


type alias SpecialNeeds =
    { need_types : SpecialNeedTypes
    , description : String
    }


type alias SpecialNeedTypes =
    { wheelChair : Bool
    , foodAllergy : Bool
    , other : Bool
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
    | RegistrationSuccess


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
    , image_width : Int
    , image_height : Int
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
    , image_width : Int
    , image_height : Int
    , blurb : String
    , description : String
    , eventModified : Bool
    }


type alias InitJson =
    { wards : List String
    , meals : List EventWithId
    , activities : List EventWithId
    }

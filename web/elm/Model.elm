module Model exposing (..)

import Dict exposing (Dict)
import Json.Decode exposing (int, string, Decoder)


type alias Id =
    Int


type TagType tag
    = TagType tag


initialModel : Model
initialModel =
    { meals = mealDict
    , activities = activityDict
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
        , wards = wardList
        }
    , editModeActive = False
    , specialNeedsHidden = True
    , menuOptionsHidden = True
    , password = ""
    , state = HomePage
    , userType = AdminUser
    , loginError = ""
    }



--fetchInitialData
{--fetchInitialData : Cmd Msg
fetchInitialData =
  Http.get "/initialdata", Json.Decoder initialDataDecoder

initJsonDecoder: Decoder InitJson
initJsonDecoder =
--}


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


mealDict : Dict Id Event
mealDict =
    Dict.fromList
        [ ( 0
          , { name = "Friday Dinner"
            , datetime = "Friday 6:00pm"
            , location = "Pavilion"
            , image = ""
            , blurb = "Roast Beef and Bread"
            , description = ""
            , eventModified = False
            }
          )
        , ( 1
          , { name = "Saturday Breakfast"
            , datetime = "Saturday 8:00am"
            , location = "Pavilion"
            , image = ""
            , blurb = "Breakfast Burritos"
            , description = ""
            , eventModified = False
            }
          )
        , ( 2
          , { name = "Saturday Lunch"
            , datetime = "Saturday 12:00pm"
            , location = "Pavilion"
            , image = ""
            , blurb = "PB&J Mmmm!"
            , description = "Here is a long description that will go on and on and on."
            , eventModified = False
            }
          )
        ]


activityDict : Dict Id Event
activityDict =
    Dict.fromList
        [ ( 0
          , { name = "Friday Night Star Gazing"
            , datetime = "Friday 8:00pm"
            , location = "Pavilion"
            , image = ""
            , blurb = "Explore the universe"
            , description = "Here is a long description that will go on and on and on."
            , eventModified = False
            }
          )
        , ( 1
          , { name = "Friday Night Devotional"
            , datetime = "Friday 6:30pm"
            , location = "Pavilion"
            , image = ""
            , blurb = "Spiritual Feast"
            , description = "Here is a long description that will go on and on and on."
            , eventModified = False
            }
          )
        , ( 2
          , { name = "Saturday Afternoon Speaker: Brad Wilcox"
            , datetime = "Saturday 1:00pm"
            , location = "Pavilion"
            , image = ""
            , blurb = "A wonderful man"
            , description = "Here is a long description that will go on and on and on."
            , eventModified = False
            }
          )
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



-- Includes Meals and Activities


type alias Event =
    { name : String
    , datetime : String
    , location : String
    , image : String
    , blurb : String
    , description : String
    , eventModified : Bool
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

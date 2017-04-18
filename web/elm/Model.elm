module Model exposing (..)


initialModel : Model
initialModel =
    { meals = mealList
    , activities = activityList
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
    , userType = AnonymousUser
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


mealList : List Event
mealList =
    [ { name = "Friday Dinner"
      , event_id = 1
      , start_datetime = "Friday 6:00pm"
      , end_datetime = "Friday 8:00pm"
      , location = "Pavilion"
      , picture = ""
      , short_description = "Roast Beef and Bread"
      , long_description = ""
      }
    , { name = "Saturday Breakfast"
      , event_id = 2
      , start_datetime = "Saturday 8:00am"
      , end_datetime = "Saturday 9:30am"
      , location = "Pavilion"
      , picture = ""
      , short_description = "Breakfast Burritos"
      , long_description = ""
      }
    , { name = "Saturday Lunch"
      , event_id = 3
      , start_datetime = "Saturday 12:00pm"
      , end_datetime = "Saturday 1:00pm"
      , location = "Pavilion"
      , picture = ""
      , short_description = "PB&J Mmmm!"
      , long_description = "Here is a long description that will go on and on and on."
      }
    ]


activityList : List Event
activityList =
    [ { name = "Friday Night Star Gazing"
      , event_id = 4
      , start_datetime = "Friday 8:00pm"
      , end_datetime = ""
      , location = "Pavilion"
      , picture = ""
      , short_description = "Explore the universe"
      , long_description = "Here is a long description that will go on and on and on."
      }
    , { name = "Friday Night Devotional"
      , event_id = 5
      , start_datetime = "Friday 6:30pm"
      , end_datetime = ""
      , location = "Pavilion"
      , picture = ""
      , short_description = "Spiritual Feast"
      , long_description = "Here is a long description that will go on and on and on."
      }
    , { name = "Saturday Afternoon Speaker: Brad Wilcox"
      , event_id = 6
      , start_datetime = "Saturday 1:00pm"
      , end_datetime = ""
      , location = "Pavilion"
      , picture = ""
      , short_description = "A wonderful man"
      , long_description = "Here is a long description that will go on and on and on."
      }
    ]


type alias Model =
    { meals : List Event
    , activities : List Event
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
    , meals : List Int
    }



-- Includes Meals and Activities


type alias Event =
    { name : String
    , event_id : Int
    , start_datetime : String
    , end_datetime : String
    , location : String
    , picture : String
    , short_description : String
    , long_description : String
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

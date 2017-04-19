module Model exposing (..)

import Dict exposing (Dict)


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
            , start_datetime = "Friday 6:00pm"
            , end_datetime = "Friday 8:00pm"
            , location = "Pavilion"
            , picture = ""
            , short_description = "Roast Beef and Bread"
            , long_description = ""
            }
          )
        , ( 1
          , { name = "Saturday Breakfast"
            , start_datetime = "Saturday 8:00am"
            , end_datetime = "Saturday 9:30am"
            , location = "Pavilion"
            , picture = ""
            , short_description = "Breakfast Burritos"
            , long_description = ""
            }
          )
        , ( 2
          , { name = "Saturday Lunch"
            , start_datetime = "Saturday 12:00pm"
            , end_datetime = "Saturday 1:00pm"
            , location = "Pavilion"
            , picture = ""
            , short_description = "PB&J Mmmm!"
            , long_description = "Here is a long description that will go on and on and on."
            }
          )
        ]


activityDict : Dict Id Event
activityDict =
    Dict.fromList
        [ ( 0
          , { name = "Friday Night Star Gazing"
            , start_datetime = "Friday 8:00pm"
            , end_datetime = ""
            , location = "Pavilion"
            , picture = ""
            , short_description = "Explore the universe"
            , long_description = "Here is a long description that will go on and on and on."
            }
          )
        , ( 1
          , { name = "Friday Night Devotional"
            , start_datetime = "Friday 6:30pm"
            , end_datetime = ""
            , location = "Pavilion"
            , picture = ""
            , short_description = "Spiritual Feast"
            , long_description = "Here is a long description that will go on and on and on."
            }
          )
        , ( 2
          , { name = "Saturday Afternoon Speaker: Brad Wilcox"
            , start_datetime = "Saturday 1:00pm"
            , end_datetime = ""
            , location = "Pavilion"
            , picture = ""
            , short_description = "A wonderful man"
            , long_description = "Here is a long description that will go on and on and on."
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

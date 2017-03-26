module Model exposing (..)


initialModel : Model
initialModel =
    { meals =
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
          , long_description = ""
          }
        ]
    , activities =
        [ { name = "Friday Night Star Gazing"
          , event_id = 4
          , start_datetime = ""
          , end_datetime = ""
          , location = ""
          , picture = ""
          , short_description = "Explore the universe"
          , long_description = ""
          }
        , { name = "Friday Night Devotional"
          , event_id = 5
          , start_datetime = ""
          , end_datetime = ""
          , location = ""
          , picture = ""
          , short_description = "Spiritual Feast"
          , long_description = ""
          }
        , { name = "Saturday Afternoon Speaker: Brad Wilcox"
          , event_id = 6
          , start_datetime = ""
          , end_datetime = ""
          , location = ""
          , picture = ""
          , short_description = "A wonderful man"
          , long_description = ""
          }
        ]
    , registration_info =
        { first_name = ""
        , reg_type = ""
        , consented_to_email = False
        , last_name = ""
        , special_needs =
            { need_type = ""
            , description = ""
            }
        , gender = ""
        , email = ""
        , selectedWard = ""
        , specialNeedsHidden = True
        , activities = []
        , meals = []
        , wards =
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
        }
    , password = ""
    , state = Registration
    , loginError = ""
    }


type alias Model =
    { meals : List Event
    , activities : List Event
    , registration_info : RegistrationInfo
    , password : String
    , state : UiState
    , loginError : String
    }


type alias RegistrationInfo =
    { first_name : String
    , reg_type : String
    , consented_to_email : Bool
    , last_name : String
    , special_needs : SpecialNeeds
    , gender : String
    , email : String
    , selectedWard : String
    , wards : List String
    , specialNeedsHidden : Bool
    , activities : List Activity
    , meals : List Int
    }


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


type alias Activity =
    { activity_id : Int
    , interest_level : String
    }


type UiState
    = Home
    | Admin
    | Registration

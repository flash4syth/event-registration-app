module Views.MealView exposing (..)

import Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Styles.Styles as Styles
import Views.HelperFunctions exposing (..)
import Dict exposing (..)


view : Model -> Html Msg
view model =
    section [ class "row" ]
        (addLogo
            :: [ header []
                    [ h1 [ style Styles.centerText ] [ text "Meals" ] ]
               , dl [ style Styles.mediumText ]
                    -- Dinner
                    [ dt [] [ text "Dinner - Fresh Mex Salads and Burritos" ]
                    , dd [] [ text "Sweet Pork and Lime Chicken" ]
                    , dd [] [ text "Fiesta Rice and Black Beans" ]
                    , dd [] [ text "Flour Tortillas" ]
                    , dd [] [ text "Shredded Romaine, Sour Cream and Pico d' gallo" ]
                    , dd [] [ text "Cheddar Jack Cheese, Cilantro Ranch and Tortilla Chips" ]
                    , dd [] [ text "Chocolate Caramel Cake" ]
                    , dd [] [ text "Lemon Cream Cake" ]
                      -- Breakfast
                    , dt [] [ text "Breakfast" ]
                    , dd [] [ text "French Toast Bake with Buttermilk Syrup" ]
                    , dd [] [ text "Savory Sausage Egg Bake" ]
                    , dd [] [ text "Ketchup and Hot Sauce" ]
                    , dd [] [ text "Fresh Fruit Platter" ]
                    , dd [] [ text "Milk" ]
                    , dd [] [ text "Orange Juice" ]
                      -- Lunch
                    , dt [] [ text "BBQ Lunch" ]
                    , dd [] [ text "Pulled Pork and BBQ Beef" ]
                    , dd [] [ text "Dutch Oven Potatoes" ]
                    , dd [] [ text "Spinach Salad" ]
                    , dd [] [ text "White Dinner Rolls and Butter" ]
                    , dd [] [ text "Snickerdoodles" ]
                    , dd [] [ text "Chocolate Chip Cookies" ]
                    , dd [] [ text "Lemonade" ]
                    ]
               , registerButton "Go To Registration"
               ]
        )


makeRows : Model -> List (Html Msg)
makeRows model =
    List.map
        (\( id, meal ) ->
            tr [ name "id", value "0" ]
                (List.map makeEditableTag
                    [ ( model
                      , (td)
                      , (UpdateEvent StartTime id)
                      , meal.datetime
                      )
                    , ( model
                      , (td)
                      , (UpdateEvent Location id)
                      , meal.location
                      )
                    , ( model
                      , (td)
                      , (UpdateEvent Blurb id)
                      , meal.blurb
                      )
                    ]
                )
        )
    <|
        Dict.toList model.meals

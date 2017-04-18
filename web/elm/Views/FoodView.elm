module Views.FoodView exposing (..)

import Messages exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Styles.Styles as Styles
import Views.HelperFunctions exposing (..)


view : Model -> Html Msg
view model =
    section [ class "row" ]
        (addLogo
            :: [ header []
                    [ h1 [ style Styles.centerText ] [ text "Meal Schedule" ] ]
               , table
                    [ class "table table-bordered table-striped" ]
                    [ thead []
                        [ tr []
                            [ th [] [ text "Date" ]
                            , th [] [ text "Location" ]
                            , th [] [ text "Description" ]
                            ]
                        ]
                    , tbody []
                        (makeRows model.meals)
                    ]
               ]
        )


makeRows : List Event -> List (Html Msg)
makeRows mealList =
    List.map
        (\meal ->
            tr []
                [ td [] [ text meal.start_datetime ]
                , td [] [ text meal.location ]
                , td [] [ text meal.short_description ]
                ]
        )
        mealList

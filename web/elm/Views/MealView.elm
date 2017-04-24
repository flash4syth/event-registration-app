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
                        (makeRows model)
                    ]
                 --  , (if model.userType == AdminUser then
                 --       if model.editModeActive then
                 --           button
                 --               [ class "btn btn-info btn-lg"
                 --               , onClick UpdateFood
                 --               ]
                 --               [ text "Save" ]
                 --       else
                 --           button
                 --               [ class "btn btn-warning btn-lg"
                 --               , onClick ToggleEditMode
                 --               ]
                 --               [ text "Edit Meals" ]
                 --     else
                 --       p [] []
                 --    )
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

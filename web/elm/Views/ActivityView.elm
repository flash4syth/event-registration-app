module Views.ActivityView exposing (..)

import Messages exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Styles.Styles as Styles


view : Model -> Html Msg -> Html Msg -> Html Msg
view model addLogo registerButton =
    section [ class "row" ]
        (List.concat
            [ [ addLogo
              , header [ class "col-xs-11" ]
                    [ h1 [ style Styles.centerText ]
                        [ text "Activities" ]
                    ]
              ]
            , (makeActivities model)
            , [ registerButton ]
            ]
        )


makeActivities : Model -> List (Html Msg)
makeActivities model =
    List.map
        (\activity ->
            section [ class "col-xs-11" ]
                [ header [] [ h2 [] [ text activity.name ] ]
                , div [ class "col-xs-12 col-md-4" ]
                    [ img [ height 200, width 200, src activity.picture ] [ text "Need Photo" ]
                    , p [ style Styles.mediumText ] [ text activity.short_description ]
                    ]
                , div [ class "col-xs-12 col-md-4" ]
                    [ p [ style Styles.mediumText ] [ text activity.long_description ]
                    ]
                  -- , div [ class "col-xs-12 col-md-4 col-md-offset-2" ] [ p [] [ text activity.long_description ] ]
                ]
        )
        model.activities

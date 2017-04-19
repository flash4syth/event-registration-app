module Views.ActivityView exposing (..)

import Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Model exposing (..)
import Styles.Styles as Styles
import Views.HelperFunctions exposing (..)
import Dict exposing (..)


view : Model -> Html Msg
view model =
    section [ class "row" ]
        (List.concat
            [ [ addLogo
              , header [ class "col-xs-11" ]
                    [ h1 [ style Styles.centerText ]
                        [ text "Activities" ]
                    ]
              ]
            , (makeActivities model)
            , [ (case model.userType of
                    AdminUser ->
                        if model.editModeActive then
                            button
                                [ class "btn btn-info btn-lg"
                                , onClick ToggleEditMode
                                ]
                                [ text "Save" ]
                        else
                            div []
                                [ button
                                    [ class "btn btn-warning btn-lg"
                                    , onClick ToggleEditMode
                                    ]
                                    [ text "Edit Activities" ]
                                , button
                                    [ class "btn btn-warning btn-lg"
                                    , onClick AddEvent
                                    ]
                                    [ text "Add Activity" ]
                                ]

                    MemberUser ->
                        p [] []

                    AnonymousUser ->
                        registerButton
                )
              ]
            ]
        )


makeActivities : Model -> List (Html Msg)
makeActivities model =
    List.map
        (\( id, activity ) ->
            section [ class "col-xs-11" ]
                [ header []
                    [ h2
                        [ attribute "contenteditable" <|
                            setEditableStatus model.editModeActive
                        ]
                        [ text activity.name ]
                    ]
                , div [ class "col-xs-12 col-md-4" ]
                    ([ img [ height 200, width 200, src activity.picture ]
                        [ text "Need Photo" ]
                     ]
                        ++ [ (makeEditableTag model
                                (UpdateEvent Blurb id)
                                activity.short_description
                             )
                           ]
                    )
                , div [ class "col-xs-12 col-md-4" ]
                    [ (makeEditableTag model
                        (UpdateEvent Description id)
                        activity.long_description
                      )
                    ]
                  -- , div [ class "col-xs-12 col-md-4 col-md-offset-2" ] [ p [] [ text activity.long_description ] ]
                ]
        )
    <|
        Dict.toList model.activities


makeEditableTag : Model -> (String -> Msg) -> String -> Html Msg
makeEditableTag model func text_content =
    case model.editModeActive of
        True ->
            input
                [ type_ "text"
                , style Styles.mediumText
                , onInput func
                ]
                [ text text_content ]

        False ->
            p
                [ style Styles.mediumText
                ]
                [ text text_content ]

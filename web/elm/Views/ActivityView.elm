module Views.ActivityView exposing (..)

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
                            section []
                                [ button
                                    [ class "btn btn-info btn-lg"
                                    , onClick (SaveEdits Activity)
                                    ]
                                    [ text "Save" ]
                                ]
                        else
                            section []
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
                        registerButton "Go To Registration"
                )
              ]
            ]
        )


makeActivities : Model -> List (Html Msg)
makeActivities model =
    List.map
        (\( id, activity ) ->
            section [ class "col-xs-11 activity-section" ]
                [ header []
                    [ (makeEditableTag
                        ( model
                        , (h2)
                        , (UpdateEvent Name id)
                        , activity.name
                        )
                      )
                    ]
                , div [ class "col-xs-12" ]
                    ([ img
                        [ class "activity-img"
                        , height activity.image_height
                        , width activity.image_width
                        , src ("/images/" ++ activity.image)
                        ]
                        []
                     ]
                        ++ [ (makeEditableTag
                                ( model
                                , (p)
                                , (UpdateEvent Blurb id)
                                , activity.blurb
                                )
                             )
                           ]
                    )
                , div [ class "col-xs-12 col-md-4" ]
                    [ (makeEditableTag
                        ( model
                        , (p)
                        , (UpdateEvent Location id)
                        , activity.location
                        )
                      )
                    , (makeEditableTag
                        ( model
                        , (p)
                        , (UpdateEvent StartTime id)
                        , activity.datetime
                        )
                      )
                    , (makeEditableTag
                        ( model
                        , (p)
                        , (UpdateEvent Description id)
                        , activity.description
                        )
                      )
                    ]
                ]
        )
    <|
        List.reverse <|
            Dict.toList model.activities

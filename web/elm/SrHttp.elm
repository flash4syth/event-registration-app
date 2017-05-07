module SrHttp exposing (..)

import Json.Decode as JDecode exposing (..)
import Json.Encode as JEncode
import Model exposing (..)
import Json.Decode.Pipeline exposing (decode, required, hardcoded)
import Http
import Messages exposing (Msg(..), EventType(..))


eventWithIdDecoder : Decoder EventWithId
eventWithIdDecoder =
    decode EventWithId
        |> required "id" int
        |> required "name" string
        |> required "datetime" string
        |> required "location" string
        |> required "image" string
        |> required "blurb" string
        |> required "description" string
        |> hardcoded False


getInitData : Cmd Msg
getInitData =
    Http.get "/initialdata" initDecoder
        |> Http.send FetchResult


initDecoder : Decoder InitJson
initDecoder =
    map3 InitJson
        (at [ "data", "wards" ] (list string))
        (at [ "data", "meals" ] (list eventWithIdDecoder))
        (at [ "data", "activities" ] (list eventWithIdDecoder))


postUpdatedEvents : EventType -> List ( Int, Event ) -> Cmd Msg
postUpdatedEvents eventType eventList =
    let
        url =
            (case eventType of
                Activity ->
                    "/post-activities"

                Meal ->
                    "/post-meals"
            )

        eventValues =
            List.map
                (\( id, event ) ->
                    JEncode.object
                        [ ( "id", JEncode.int id )
                        , ( "name", JEncode.string event.name )
                        , ( "datetime", JEncode.string event.datetime )
                        , ( "location", JEncode.string event.location )
                        , ( "image", JEncode.string event.image )
                        , ( "blurb", JEncode.string event.blurb )
                        , ( "description", JEncode.string event.description )
                        ]
                )
                eventList
    in
        Http.post url
            (Http.jsonBody (JEncode.list eventValues))
            (list eventWithIdDecoder)
            |> Http.send (PostEventEdits eventType)


postRegistration : Model -> Cmd Msg
postRegistration model =
    let
        reg_info =
            model.registration_info

        spec_needs =
            reg_info.special_needs

        need_types =
            spec_needs.need_types

        registrationValue =
            JEncode.object
                [ ( "first_name", JEncode.string reg_info.first_name )
                , ( "last_name", JEncode.string reg_info.last_name )
                , ( "email", JEncode.string reg_info.email )
                , ( "phone", JEncode.string reg_info.phone )
                , ( "gender", JEncode.string reg_info.gender )
                , ( "ward", JEncode.string reg_info.selectedWard )
                , ( "reg_type", JEncode.string reg_info.reg_type )
                , ( "meals"
                  , JEncode.list
                        (List.map
                            (\id -> JEncode.int id)
                            reg_info.meals
                        )
                  )
                , ( "special_needs"
                  , JEncode.object
                        [ ( "description"
                          , JEncode.string spec_needs.description
                          )
                        ]
                  )
                ]
    in
        Http.post "/register"
            (Http.jsonBody registrationValue)
            string
            |> Http.send PostRegistration

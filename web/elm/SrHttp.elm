module SrHttp exposing (..)

import Json.Decode as Json exposing (..)
import Model exposing (..)
import Json.Decode.Pipeline exposing (decode, required, hardcoded)
import Http
import Messages exposing (Msg(..))


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

module TestingBoard.Json exposing (..)

import Dict
import TestingBoard.Types as Types
import Json.Decode exposing (andThen, dict, Decoder, fail, int, list, maybe, string, succeed)
import Json.Decode.Pipeline exposing (decode, optional, required)
import Result
import String


scoreDecoder : Decoder Types.Score
scoreDecoder =
    decode Types.Score
        |> required "failures" int
        |> required "total" int


-- intKeys : Dict.Dict String a -> Dict.Dict Int a
-- intKeys =
--     let
--         intKey k v acc =
--             case (String.toInt k) of
--                 Result.Ok i ->
--                     Dict.insert i v acc

--                 Result.Err _ ->
--                     acc
--     in
--         Dict.foldl intKey Dict.empty


scoresDecoder : Decoder Types.Scores
scoresDecoder =
    dict scoreDecoder
    -- (dict scoreDecoder) |> andThen (intKeys >> succeed)

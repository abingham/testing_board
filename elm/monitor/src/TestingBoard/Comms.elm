module TestingBoard.Comms exposing (..)

{-| High-level API for talking to the schedule server.

# Commands
@docs TODO
-}

import TestingBoard.Json as Json
import TestingBoard.Msg as Msg
import Http


fetchScores : String -> Cmd Msg.Msg
fetchScores url =
    let
        request =
            Http.get url Json.scoresDecoder
    in
        Http.send Msg.ScoresFetched request

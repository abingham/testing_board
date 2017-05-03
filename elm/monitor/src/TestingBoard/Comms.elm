module TestingBoard.Comms exposing (..)

{-| High-level API for talking to the schedule server.

# Commands
@docs TODO
-}

import TestingBoard.Json as Json
import TestingBoard.Msg as Msg
import TestingBoard.Types as Types
import Http


fetchScores : Types.GameId -> Cmd Msg.Msg
fetchScores gameId =
    let
        url = "http://127.0.0.1:8080/results/" ++ gameId
        request =
            Http.get url Json.scoresDecoder
    in
        Http.send Msg.ScoresFetched request

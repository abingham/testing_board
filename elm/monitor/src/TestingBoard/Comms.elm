module TestingBoard.Comms exposing (..)

{-| High-level API for talking to the schedule server.

# Commands
@docs TODO
-}

import TestingBoard.Json as Json
import TestingBoard.Model as Model
import TestingBoard.Msg as Msg
import Http


fetchScores : Model.Model -> Cmd Msg.Msg
fetchScores model =
    let
        url = model.apiRootUrl ++ "results/" ++ model.gameId
        request =
            Http.get url Json.scoresDecoder
    in
        Http.send Msg.ScoresFetched request

module TestingBoard.Comms exposing (..)

{-| High-level API for talking to the schedule server.

# Commands
@docs TODO
-}

import Erl
import Http
import TestingBoard.Json as Json
import TestingBoard.Model as Model
import TestingBoard.Msg as Msg


fetchScores : Model.Model -> Cmd Msg.Msg
fetchScores model =
    let
        base_url = Erl.parse model.apiRootUrl
        url = {base_url | path = base_url.path ++ ["results", model.gameId]}
              |> Erl.toString
        request =
            Http.get url Json.scoresDecoder
    in
        Http.send Msg.ScoresFetched request

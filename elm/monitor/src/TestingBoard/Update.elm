module TestingBoard.Update exposing (update)

import TestingBoard.Comms as Comms
import TestingBoard.Msg as Msg
import TestingBoard.Model exposing (Model)
import TestingBoard.Routing as Routing
import Material


update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
        Msg.ScoresFetched (Ok scores) ->
            { model | scores = scores } ! []

        Msg.NewDataAvailable _ ->
            model ! [Comms.fetchScores model]

        Msg.UrlChange location ->
            { model | location = Routing.parseLocation location } ! []

        Msg.Mdl mdlMsg ->
            Material.update Msg.Mdl mdlMsg model

        _ ->
            model ! []

module TestingBoard.Update exposing (update)

import TestingBoard.Msg as Msg
import TestingBoard.Model exposing (Model)
import TestingBoard.Routing as Routing
import Material


update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
        Msg.ScoresFetched (Ok scores) ->
            { model | scores = scores } ! []

        Msg.UrlChange location ->
            { model | location = Routing.parseLocation location } ! []

        Msg.Mdl mdlMsg ->
            Material.update Msg.Mdl mdlMsg model

        _ ->
            model ! []

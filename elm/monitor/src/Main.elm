module TestingBoard exposing (..)

import TestingBoard.Comms as Comms
import TestingBoard.Model exposing (..)
import TestingBoard.Msg exposing (..)
import TestingBoard.Types as Types
import TestingBoard.Update exposing (update)
import TestingBoard.View exposing (view)
import Material
import Navigation


type alias Flags =
    { gameId : Types.GameId
    }


main : Program Flags Model Msg
main =
    Navigation.programWithFlags UrlChange
        { init =
            \flags loc ->
                ( initialModel flags.gameId loc
                , Cmd.batch
                    [ Material.init Mdl
                    , Comms.fetchScores <| "http://127.0.0.1:8080/results/" ++ flags.gameId
                    ]
                )
        , view = view
        , update = update
        , subscriptions = Material.subscriptions Mdl
        }

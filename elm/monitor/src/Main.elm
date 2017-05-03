module TestingBoard exposing (..)

import TestingBoard.Comms as Comms
import TestingBoard.Model exposing (..)
import TestingBoard.Msg exposing (..)
import TestingBoard.Types as Types
import TestingBoard.Update exposing (update)
import TestingBoard.View exposing (view)
import Material
import Navigation
import Platform.Sub exposing (batch)
import WebSocket


type alias Flags =
    { gameId : Types.GameId
    , apiRootUrl : String
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    batch
        [ Material.subscriptions Mdl model
        , WebSocket.listen "ws://localhost:8080/notifications" NewScoresAvailable
        ]


main : Program Flags Model Msg
main =
    Navigation.programWithFlags UrlChange
        { init =
            \flags loc ->
                let
                    model =
                        initialModel flags.apiRootUrl flags.gameId loc
                in
                    ( model
                    , Cmd.batch
                        [ Material.init Mdl
                        , Comms.fetchScores model
                        ]
                    )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

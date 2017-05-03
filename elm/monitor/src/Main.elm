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
import Time


type alias Flags =
    { gameId : Types.GameId
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    batch
        [ Time.every Time.second (\_ -> Refresh)
        , Material.subscriptions Mdl model
        ]


main : Program Flags Model Msg
main =
    Navigation.programWithFlags UrlChange
        { init =
            \flags loc ->
                ( initialModel flags.gameId loc
                , Cmd.batch
                    [ Material.init Mdl
                    , Comms.fetchScores flags.gameId
                    ]
                )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

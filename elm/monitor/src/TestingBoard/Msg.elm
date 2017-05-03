module TestingBoard.Msg exposing (..)

import TestingBoard.Types as Types
import Http
import Material
import Navigation


type Msg
    = ScoresFetched (Result Http.Error Types.Scores)
    | Mdl (Material.Msg Msg)
    | UrlChange Navigation.Location

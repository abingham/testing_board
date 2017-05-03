module TestingBoard.Types exposing (..)

import Dict


type alias GameId =
    String


type alias PlayerId =
    String


type alias Score =
    { failures : Int
    , total : Int
    }


type alias Scores =
    Dict.Dict PlayerId Score

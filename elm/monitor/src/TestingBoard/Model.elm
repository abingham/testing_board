module TestingBoard.Model exposing (initialModel, Model)

{-| The overal application model.
-}

import Dict
import TestingBoard.Routing as Routing
import TestingBoard.Types as Types
import Material
import Navigation


type alias Model =
    { gameId : Types.GameId
    , scores : Types.Scores
    , mdl : Material.Model
    , location : Routing.RoutePath
    }


initialModel : Types.GameId -> Navigation.Location -> Model
initialModel gameId location =
    { gameId = gameId
    , scores = Dict.empty
    , location = Routing.parseLocation location
    , mdl = Material.model
    }

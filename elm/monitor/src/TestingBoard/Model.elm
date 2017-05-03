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
    , apiRootUrl : String
    , scores : Types.Scores
    , mdl : Material.Model
    , location : Routing.RoutePath
    }


initialModel : String -> Types.GameId -> Navigation.Location -> Model
initialModel apiRootUrl gameId location =
    { gameId = gameId
    , apiRootUrl = apiRootUrl
    , scores = Dict.empty
    , location = Routing.parseLocation location
    , mdl = Material.model
    }

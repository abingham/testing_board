module TestingBoard.Routing exposing (..)

import Http
import Navigation
import UrlParser exposing (..)


{-| All of the possible routes that we can display
-}
type RoutePath
    = Index
      -- | DeepLink Int
    | NotFound


matchers : Parser (RoutePath -> a) a
matchers =
    oneOf
        [ map Index top
          -- , map DeepLink (s "deep" </> int)
        ]


parseLocation : Navigation.Location -> RoutePath
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFound

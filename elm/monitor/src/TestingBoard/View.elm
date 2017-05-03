module TestingBoard.View exposing (view)

import Chart
import Dict
import TestingBoard.Model as Model
import TestingBoard.Msg as Msg
import TestingBoard.Routing as Routing


-- import TestingBoard.Types as Types

import Html exposing (a, br, div, h1, Html, img, p, text)
import Html.Attributes exposing (src)


-- import Material.Button as Button
-- import Material.Card as Card
-- import Material.Chip as Chip

import Material.Color as Color


-- import Material.Elevation as Elevation

import Material.Footer as Footer


-- import Material.Icon as Icon

import Material.Layout as Layout
import Material.Options as Options


-- import Material.Textfield as Textfield

import Material.Typography as Typo


footer : Html Msg.Msg
footer =
    Footer.mini []
        { left =
            Footer.left []
                [ Footer.logo [] [ Footer.html <| text "Testing Leaderboard" ]
                , Footer.links []
                    [ Footer.linkItem
                        [ Footer.href "https://github.com/abingham/testing-board.git" ]
                        [ Footer.html <| img [ src "./static/img/GitHub-Mark-Light-32px.png" ] [] ]
                    ]
                ]
        , right =
            Footer.right []
                [ Footer.links []
                    [ Footer.linkItem
                        [ Footer.href "" ]
                        [ Footer.html <| text "© 2017 Sixty North AS"
                        ]
                    ]
                ]
        }


bucket : Model.Model -> Float -> Float -> (Float, String)
bucket model bottom top =
    let
        rate s = 1.0 - (toFloat s.failures) / (toFloat s.total)
        inBucket r = (r > bottom) && (r <= top)
        matches = List.filter inBucket (Dict.values model.scores |> List.map rate)
    in
        (List.length matches |> toFloat, toString top)


histogram : Model.Model -> Html Msg.Msg
histogram model =
    let
        tops = [0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.00]
        bottoms = 0.0 :: tops
        buckets = List.map2 (bucket model) bottoms tops
    in
        Chart.vBar buckets
        |> Chart.title "% passing tests"
        |> Chart.toHtml


view : Model.Model -> Html Msg.Msg
view model =
    let
        main =
            case model.location of
                Routing.Index ->
                    histogram model

                -- Routing.DeepLink id ->
                --     text "deep link!"
                _ ->
                    text "not found!"
    in
        div
            []
            [ Layout.render Msg.Mdl
                model.mdl
                [ Layout.fixedHeader
                ]
                { header =
                    [ Layout.row
                        [ Color.background Color.primary ]
                        [  Layout.spacer
                        , Layout.title
                            [ Typo.title ]
                            [ text "Testing Leaderboard" ]
                        , Layout.spacer
                        ]
                    ]
                , tabs = ( [], [] )
                , drawer = []
                , main =
                    [ Options.styled div
                        [ Options.css "margin-left" "10px"
                        , Options.css "margin-top" "10px"
                        , Options.css "margin-bottom" "10px"
                        ]
                        [ main ]
                    , footer
                    ]
                }
            ]

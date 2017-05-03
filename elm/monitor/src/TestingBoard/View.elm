module TestingBoard.View exposing (view)

import Dict
import TestingBoard.Model as Model
import TestingBoard.Msg as Msg
import TestingBoard.Routing as Routing
import TestingBoard.Types as Types


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
                [ Footer.logo [] [ Footer.html <| text "ACCU 2017 Schedule" ]
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
                        [ Footer.html <| text "© 2017 austin@sixty-north.com"
                        ]
                    ]
                ]
        }


scoreView : Types.PlayerId -> Types.Score -> Html Msg.Msg
scoreView uid score =
    let
        sz =
            uid ++ " -> " ++ (toString score.failures) ++ " / " ++ (toString score.total)
    in
        text sz


view : Model.Model -> Html Msg.Msg
view model =
    let
        main =
            case model.location of
                Routing.Index ->
                    div [] <|
                        List.map (\( k, v ) -> div [] [scoreView k v]) <|
                            Dict.toList model.scores

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
                        [ Layout.title
                            [ Typo.title, Typo.left ]
                            [ text "monitor" ]
                        , Layout.spacer
                        , Layout.title
                            [ Typo.title ]
                            [ text "monitor" ]
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

module View exposing (..)

import Update
import Model
import Html
import Html.Events
import Html.Attributes
import EmojiConverter

translateText : Model.Model -> String
translateText model =
    if model.direction == Model.TextToEmoji then
        EmojiConverter.textToEmoji model.selectedKey model.currentText
    else
        EmojiConverter.emojiToText model.selectedKey model.currentText

renderKeys model =
    Html.div
        [ Html.Attributes.class "row" ]
        (List.map (\emoji -> renderKey emoji model) EmojiConverter.supportedEmojis)

renderKey emoji model =
    Html.div
        [ Html.Attributes.class "col s2 m1 emoji-size" ]
        [ Html.div
            [ Html.Attributes.classList
                [ ("key-selector", True)
                , ("is-selected", emoji == model.selectedKey)
                ]
            , Html.Events.onClick (Update.SetSelectedKey emoji)
            ]
            [ Html.text emoji]
        ]


view : Model.Model -> Html.Html Update.Msg
view model =
    Html.div
        []
        [ Html.node "link"
            [ Html.Attributes.rel "stylesheet"
            , Html.Attributes.href "stylesheets/main.css"
            ]
            []
        , Html.nav
            []
            [ Html.div
                [ Html.Attributes.class "nav-wrapper light-blue lighten-2" ]
                [ Html.div
                    [ Html.Attributes.class "brand-logo center" ]
                    [ Html.text "Elmoji Translator" ]
                ]
            ]
        , Html.section
            [ Html.Attributes.class "container" ]
            [ Html.div
                [ Html.Attributes.class "input-field" ]
                [ Html.input
                    [ Html.Attributes.type_ "text"
                    , Html.Attributes.class "center"
                    , Html.Attributes.placeholder "Let's Translate!"
                    , Html.Events.onInput Update.SetCurrentText
                    ]
                    []
                ]
            ]
        , Html.p
            [ Html.Attributes.class "center output-text emoji-size" ]
            [ Html.text (translateText model)]
        , Html.div
            [ Html.Attributes.class "switch center"]
            [ Html.label
                []
                [ Html.text "Translate Text"
                , Html.input
                    [ Html.Attributes.type_ "checkbox"]
                    []
                , Html.span
                    [ Html.Attributes.class "lever"
                    , Html.Events.onClick Update.ToggleDirection]
                    []
                , Html.text "Translate Emoji"
                ]
            ]
        , Html.div
            [ Html.Attributes.class "divider" ]
            []
        , Html.section
            [ Html.Attributes.class "container" ]
            [ Html.h4
                [ Html.Attributes.class "center" ]
                [ Html.text "Select Your Key" ]
            , renderKeys model
            ]
        ]

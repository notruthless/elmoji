module Main exposing (..)

import Html
import Html.Events
import Html.Attributes


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }

type Msg
    = ChangeText | ChangeColor

type Color
    = Red | Orange | Yellow | Green | Blue | Purple

colorToString : Color -> String
colorToString color =
    case color of
        Red -> "red"
        Orange -> "orange"
        Yellow -> "Yellow"
        Green -> "green"
        Blue -> "blue"
        Purple -> "purple"

nextColor : Color -> Color
nextColor color =
    case color of
        Red -> Orange
        Orange -> Yellow
        Yellow -> Green
        Green -> Blue
        Blue -> Purple
        Purple -> Red

type alias Model =
    { buttonLabel : String, color: Color }


init : Model
init =
    { buttonLabel = "hello world!", color = Green }

update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeText ->
            if model.buttonLabel == "hello world!" then
                { model | buttonLabel = "goodbye world!" }
            else
                { model | buttonLabel = "hello world!" }

        ChangeColor ->
            { model | color = nextColor model.color }




view : Model -> Html.Html Msg
view model =
    Html.div
        [ Html.Attributes.class "skeleton-elm-project" ]
        [ Html.node "link"
            [ Html.Attributes.rel "stylesheet"
            , Html.Attributes.href "stylesheets/main.css"
            ]
            []
        , Html.div
            [ Html.Attributes.class "waves-effect waves-light btn-large"
            , Html.Attributes.style [("backgroundColor", colorToString(model.color))]
            , Html.Events.onClick ChangeText
            ]
            [ Html.text model.buttonLabel ]
        , Html.div
            [ Html.Attributes.class "waves-effect waves-light btn-large"
            , Html.Events.onClick ChangeColor
            ]
            [ Html.text "Change Color" ]
        ]

module Model exposing (..)

type Direction
    = TextToEmoji | EmojiToText

type alias Model =
    { currentText : String, direction: Direction }

defaultKey : String
defaultKey =
    "😅"

init : Model
init =
    { currentText = "", direction = TextToEmoji }

module Main exposing (..)

import Html exposing (Html, text, p)

main : Program Never Model Msg
main = 
    Html.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }

--MODEL
type alias Model = 
    { count : Int
    }

initModel : Model
initModel = 
    { count = 0 
    }

type Msg
    = NoOp

--UPDATE
update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp -> 
            model

--VIEW
view : Model -> Html Msg
view model = 
    p []
        [ text "count: " 
        , text (toString model.count)
        ]
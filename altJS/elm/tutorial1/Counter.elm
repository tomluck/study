module Main exposing (..)

import Html exposing (Html, text, p, div, button)
import Html.Events exposing (onClick)

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
    | Increase

--UPDATE
update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp -> 
            model

        Increase ->
            { model | count = model.count + 1 }

--VIEW
view : Model -> Html Msg
view model = 
    div []
        [ counter model
        , increaseButton            
        ]

counter : Model -> Html Msg
counter model = 
    p []
        [ text "count: " 
        , text (toString model.count)
        ]

increaseButton : Html Msg
increaseButton = 
    div []
        [ button [ onClick Increase ]
            [ text "+1" ]
        ]
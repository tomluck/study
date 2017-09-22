module Main exposing (..)

import Html exposing (Html, text, p, div, button, form, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value, type_)
import String exposing (toInt)

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
    , countStepInput : String
    , countStepNum : Int
    }

initModel : Model
initModel = 
    { count = 0 
    , countStepInput = ""
    , countStepNum = 0
    }

type Msg
    = NoOp
    | Increase Int
    | UpdateCountStepInput String
    | UpdateCountStepNum Int

--UPDATE
update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp -> 
            model

        Increase num ->
            { model | count = model.count + num }

        UpdateCountStepInput s ->
            { model | countStepInput = s }

        UpdateCountStepNum num ->
            { model | countStepNum = num }

--VIEW
view : Model -> Html Msg
view model = 
    div []
        [ counter model
        , increaseButton model
        , stepInput model
        , text ("countStepInput = " ++ model.countStepInput)
        ]

counter : Model -> Html Msg
counter model = 
    p []
        [ text "count: " 
        , text (toString model.count)
        ]

increaseButton : Model -> Html Msg
increaseButton model = 
    div []
        [ button [ onClick (Increase 1) ] [ text "+1" ]
        , button [ onClick (Increase model.countStepNum) ] [ text ("Add " ++ (toString model.countStepNum)) ]
        ]

stepInput : Model -> Html Msg
stepInput model = 
    form []
        [ input [ onInput UpdateCountStepInput, value model.countStepInput ] []
        , input [ type_ "button", onClick (convertInputToMsg model.countStepInput), value "Update"] []
        ]
        
convertInputToMsg : String -> Msg
convertInputToMsg s = 
    case (toInt s) of
        Ok num ->
            UpdateCountStepNum num

        Err msg ->
            NoOp

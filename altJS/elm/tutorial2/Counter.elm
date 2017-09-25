module Main exposing (..)

import Html exposing (Html, text, p, div, button, form, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value, type_)
import String exposing (toInt)
import Task

main : Program Never Model Msg
main = 
    Html.program
        { init = initModel
        , update = update
        , view = view
        , subscriptions = subscriptions
        }

--MODEL
type alias Model = 
    { count : Int
    , countStepInput : String
    , countStepNum : Int
    }

initModel : (Model, Cmd Msg)
initModel = 
    { count = 0 
    , countStepInput = ""
    , countStepNum = 0
    }
    ! [ Task.perform UpdateCountStepInput (Task.succeed "5") ]

type Msg
    = NoOp
    | Increase Int
    | UpdateCountStepInput String
    | UpdateCountStepNum Int

--UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp -> 
            model ! []

        Increase num ->
            { model | count = model.count + num } ! []

        UpdateCountStepInput s ->
            { model | countStepInput = s } ! [ Task.perform convertInputToMsg (Task.succeed s) ]

        UpdateCountStepNum num ->
            { model | countStepNum = num } ! []

--VIEW
view : Model -> Html Msg
view model = 
    div []
        [ counter model
        , increaseButton model
        , stepInput model
        , text ("countStepInput = " ++ model.countStepInput)
        ]

--SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

--OTHERS
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
        ]
        
convertInputToMsg : String -> Msg
convertInputToMsg s = 
    case (toInt s) of
        Ok num ->
            UpdateCountStepNum num

        Err msg ->
            NoOp


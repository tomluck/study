module TodoCreator exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value, type_)

-- model
type alias Item = 
    String

type alias Model = 
    { inputStr : Item
    }

initialModel : Model
initialModel = 
    { inputStr = ""
    }

type Msg
    = NoOp
    | UpdateInput String

-- update
update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            model ! []

        UpdateInput s ->
            { model | inputStr = s } ! []

-- view
view : Model -> Html Msg
view model = 
    div []
        [ todoInput model
        ]

todoInput : Model -> Html Msg
todoInput model = 
    form []
        [ input [ onInput UpdateInput, value model.inputStr ] []
        ]

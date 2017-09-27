module TodoCreator exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value, type_)

-- model
type alias Item = 
    String

type alias Model = 
    { item : Item
    , inputStr : Item
    }

initialModel : Model
initialModel = 
    { item = ""
    , inputStr = ""
    }

type Msg
    = NoOp
    | UpdateInput String
    | AddNew

-- update
update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            model ! []

        UpdateInput s ->
            { model | inputStr = s } ! []

        AddNew -> 
            { model | item = model.inputStr } ! []

-- view
view : Model -> Html Msg
view model = 
    div []
        [ todoInput model
        , text ("todo = " ++ model.inputStr)
        ]

todoInput : Model -> Html Msg
todoInput model = 
    form []
        [ input [ onInput UpdateInput, value model.inputStr ] []
        , input [ type_ "button", onClick AddNew, value "Add"] []
        ]

module TodoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

-- model
type alias ToDo = 
    { done : Bool
    , item : String
    }

type alias Model = 
    { todoList : List ToDo
    }

initialModel : Model
initialModel = 
    { todoList = 
        [ ToDo False "item1" 
        , ToDo False "item2"
        , ToDo False "item3"
        ]
    }

type Msg
    = NoOp
    | AddNew

-- update
update : Msg -> ToDo -> Model -> ( Model, Cmd Msg )
update message todo model =
    case message of
        NoOp ->
            model ! []

        AddNew -> 
            { model | todoList = model.todoList ++ [todo] } ! []

-- view
view : Model -> Html Msg
view model = 
    div []
        [ viewList model.todoList
        ]

viewList : List ToDo -> Html Msg
viewList models = 
    div [ class "p2" ]
    [ updateButton models
    , viewItems models
    ]

viewItems : List ToDo -> Html Msg
viewItems models = 
    ul [] (List.map viewItem models)

viewItem : ToDo -> Html Msg
viewItem model = 
    li [] [
        text model.item
    ]

updateButton : List ToDo -> Html Msg
updateButton models = 
    div [] 
        [ button [ onClick AddNew ] [ text "Add" ] ]
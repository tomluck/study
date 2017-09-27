module TodoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

-- model
type alias ToDo = 
    { count : Int
    , item : String
    }

type alias Model = 
    { todoList : List ToDo
    }

initialModel : Model
initialModel = 
    { todoList = 
        [ ToDo 1 "item1" 
        , ToDo 2 "item2"
        ]
    }

type Msg
    = NoOp
    | AddNew ToDo

-- update
update : Msg -> ToDo -> Model -> ( Model, Cmd Msg )
update message todo model =
    case message of
        NoOp ->
            model ! []

        AddNew todo -> 
            ( { model | todoList = model.todoList ++ [todo] }, Cmd.none )

-- view
view : Model -> Html Msg
view model = 
    div []
        [ viewList model.todoList
        ]

viewList : List ToDo -> Html Msg
viewList models = 
    div [ class "p2" ]
    [ viewItems models
    , updateButton models
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
        [ button [ onClick (AddNew (ToDo 4 "item4")) ] [ text "Click" ] ]
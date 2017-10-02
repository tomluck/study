module TodoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Todo

-- model
type alias TodoModel = Todo.Model

type alias Model = 
    { todoList : List TodoModel
    }

initialModel : Model
initialModel = 
    { todoList = 
        [ Todo.new False "item1"
        , Todo.new False "item2"
        , Todo.new False "item3"
        ]
    }

type Msg
    = NoOp
    | AddNew
    | TodoMsg Todo.Msg

-- update
update : Msg -> TodoModel -> Model -> ( Model, Cmd Msg )
update message todo model =
    case message of
        NoOp ->
            model ! []

        AddNew -> 
            { model | todoList = model.todoList ++ [todo] } ! []

        TodoMsg subMsg ->
            let
                updatedTodoList = 
                    List.map (Todo.update subMsg) model.todoList
            in
                { model | todoList = updatedTodoList } ! []

-- view
view : Model -> Html Msg
view model = 
    div []
        [
        div [ class "p2" ]
            [ addButton
            , viewList model
            ]
        ]

addButton : Html Msg
addButton = 
    div [] 
        [ button [ onClick AddNew ] [ text "Add" ] ]

viewList : Model -> Html Msg
viewList model = 
    (ul [] 
        (List.map Todo.view model.todoList))
        |> Html.map TodoMsg

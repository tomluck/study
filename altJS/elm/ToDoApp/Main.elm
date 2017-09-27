module Main exposing (..)

import Html exposing (Html, program)
import TodoList

main : Program Never AppModel Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

-- model
type alias AppModel =
    { todoListModel : TodoList.Model
    }

initialModel : AppModel
initialModel = 
    { todoListModel = TodoList.initialModel
    }

init : ( AppModel, Cmd Msg)
init = 
    ( initialModel, Cmd.none)

type Msg
    = TodoListMsg TodoList.Msg

-- update
update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update message model = 
    case message of
        TodoListMsg subMsg ->
            let
                ( updatedTodoListModel, todoListCmd ) =
                    TodoList.update subMsg (TodoList.ToDo 3 "item3") model.todoListModel
--                    TodoList.update subMsg model.todoListModel
            in
                ( { model | todoListModel = updatedTodoListModel }, Cmd.map TodoListMsg todoListCmd )

-- subscription
subscriptions : AppModel -> Sub Msg
subscriptions model =
    Sub.none

-- view
view : AppModel -> Html Msg
view model =
    Html.div []
        [ Html.map TodoListMsg (TodoList.view model.todoListModel) 
        ]
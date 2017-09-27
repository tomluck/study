module Main exposing (..)

import Html exposing (Html, program)
import TodoCreator
import TodoList

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

-- model
type alias Model = 
    { creator : TodoCreator.Model
    , todoList : TodoList.Model
    }

initialModel : Model
initialModel = 
    { creator = TodoCreator.initialModel
    , todoList = TodoList.initialModel
    }

init : ( Model, Cmd Msg)
init = 
    ( initialModel, Cmd.none)

type Msg
    = TodoCreatorMsg TodoCreator.Msg
    | TodoListMsg TodoList.Msg

-- update
update : Msg -> Model -> ( Model, Cmd Msg )
update message model = 
    case message of
        TodoCreatorMsg subMsg ->
            model ! []

        TodoListMsg subMsg ->
            let
                ( updatedTodoListModel, todoListCmd ) =
                    TodoList.update subMsg (TodoList.ToDo 3 "item3") model.todoList
            in
                ( { model | todoList = updatedTodoListModel }, Cmd.map TodoListMsg todoListCmd )

-- subscription
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- view
view : Model -> Html Msg
view model =
    Html.div []
        [ Html.map TodoCreatorMsg (TodoCreator.view model.creator)
        , Html.map TodoListMsg (TodoList.view model.todoList) 
        ]
module Main exposing (..)

import Html exposing (..)
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
    { todoCreator : TodoCreator.Model
    , todoList : TodoList.Model
    }

initialModel : Model
initialModel = 
    { todoCreator = TodoCreator.initialModel
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
            let
                ( updatedCreator, todoCreatorCmd ) =
                    TodoCreator.update subMsg model.todoCreator
            in
                ( { model | todoCreator = updatedCreator }, Cmd.map TodoCreatorMsg todoCreatorCmd )

        TodoListMsg subMsg ->
            let
                ( updatedTodoListModel, todoListCmd ) =
                    TodoList.update subMsg model.todoCreator.inputStr model.todoList
            in
                ( { model | todoList = updatedTodoListModel }, Cmd.map TodoListMsg todoListCmd )

-- subscription
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- view
view : Model -> Html Msg
view model =
    body [] 
        [ h1 [] [ text "ToDo list" ]
        , div [] 
            [ map TodoCreatorMsg (TodoCreator.view model.todoCreator)
            , map TodoListMsg (TodoList.view model.todoList) 
            ]
    ]

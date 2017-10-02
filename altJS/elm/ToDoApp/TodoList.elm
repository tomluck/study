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
        [ Todo.new False "task1"
        , Todo.new False "task2"
        , Todo.new True "task3"
        , Todo.new False "task4"
        ]
    }

type Msg
    = NoOp
    | AddNew
    | DeleteFinished
    | TodoMsg Todo.Msg

-- update
update : Msg -> TodoModel -> Model -> ( Model, Cmd Msg )
update message todo model =
    case message of
        NoOp ->
            model ! []

        AddNew -> 
            { model | todoList = model.todoList ++ [todo] } ! []

        DeleteFinished -> 
            let
                itemIsNotFinished todoModel = not todoModel.done
            in
                { model | 
                    todoList =  List.filter itemIsNotFinished model.todoList } ! []

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
            , viewCounter model
            , deleteFinishedButton
            , viewList model
            ]
        ]

addButton : Html Msg
addButton = 
    div [] 
        [ button [ onClick AddNew ] [ text "Add" ] ]

deleteFinishedButton : Html Msg
deleteFinishedButton = 
    div [] 
        [ button [ onClick DeleteFinished ] [ text "Delete Finished" ] ]

viewCounter : Model -> Html Msg
viewCounter model = 
    div []
        [ text ("Finished Task: " 
            ++ toString ( countDoneItems model )
            ++ "/" 
            ++ toString ( List.length model.todoList ) ) 
        ]

countDoneItems : Model -> Int
countDoneItems model = 
    List.filter itemIsDone model.todoList
    |> List.length

itemIsDone : TodoModel -> Bool
itemIsDone todoModel = todoModel.done 

viewList : Model -> Html Msg
viewList model = 
    (ul [] 
        (List.map Todo.view model.todoList))
        |> Html.map TodoMsg

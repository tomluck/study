module TodoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Todo

-- model
type alias TodoModel = Todo.Model

type alias Model = 
    { todoList : List TodoModel
    , nextID : Int
    }

initialModel : Model
initialModel = 
    { todoList = 
        [ Todo.new 1 False "task1" False
        , Todo.new 2 False "task2" False
        , Todo.new 3 True  "task3" False
        , Todo.new 4 False "task4" False
        ]
    , nextID = 5
    }

type Msg
    = NoOp
    | AddNew
    | DeleteFinished
    | TodoMsg Todo.Msg

-- update
update : Msg -> String -> Model -> ( Model, Cmd Msg )
update message item model =
    case message of
        NoOp ->
            model ! []

        AddNew -> 
            let
                todo = 
                    Todo.new model.nextID False item False
            in
                { model | 
                    todoList = model.todoList ++ [todo] 
                    , nextID = model.nextID + 1
                } ! []

        DeleteFinished -> 
            let
                itemIsNotFinished todoModel = not todoModel.done
            in
                { model | 
                    todoList =  List.filter itemIsNotFinished model.todoList } ! []

        TodoMsg subMsg ->
            let
                itemIsNotDeleted todoModel = 
                    not todoModel.del
                    
                updatedTodoList = 
                    List.map (Todo.update subMsg) model.todoList
            in
                { model | 
                    todoList = List.filter itemIsNotDeleted updatedTodoList } ! []

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

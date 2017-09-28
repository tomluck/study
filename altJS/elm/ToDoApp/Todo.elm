module Todo exposing (..)

import Html exposing (..)

-- model
type alias Model = 
    { done : Bool
    , item : String
    }

initialModel : Model
initialModel = 
    { done = False
    , item = ""
    }

new : Bool -> String -> Model
new b s = 
    { done = b
    , item = s
    }
    
type Msg
    = NoOp
    | ToggleDone

-- update
update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            model ! []

        ToggleDone -> 
            model ! []
--            { model | done = not todo.done } ! []

-- view
view : Model -> Html Msg
view model = 
    li [] [
        text model.item
    ]
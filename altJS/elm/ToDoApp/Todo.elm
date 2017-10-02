module Todo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style, type_)
import Html.Events exposing (onClick)

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
    | ToggleDone String

-- update
update : Msg -> Model -> Model
update message model =
    case message of
        NoOp ->
            model

        ToggleDone s -> 
            if s == model.item then
                { model | done = not model.done }
            else
                model

-- view
view : Model -> Html Msg
view model = 
    li [] 
        [ 
            checkbox (ToggleDone model.item) model
        ]

checkbox : msg -> Model -> Html msg
checkbox msg model = 
    label []
        [ input [ type_ "checkbox", onClick msg ] []
        , viewItem model
        ]

viewItem : Model -> Html msg
viewItem model =
    if model.done == False then
        text model.item
    else
        s [] 
            [ span [ style [ ("color", "gray") ] ]
                    [ text model.item ]
            ]

module Todo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style, type_, checked)
import Html.Events exposing (onClick)

-- model
type alias Model = 
    { itemID : Int
    , done : Bool
    , item : String
    , del  : Bool
    }

new : Int -> Bool -> String -> Bool -> Model
new itemID do s de = 
    { itemID = itemID
    , done = do
    , item = s
    , del = de
    }
    
type Msg
    = NoOp
    | ToggleDone Int
    | OnDelete Int

-- update
update : Msg -> Model -> Model
update message model =
    case message of
        NoOp ->
            model

        ToggleDone itemID -> 
            if itemID == model.itemID then
                { model | done = not model.done }
            else
                model

        OnDelete itemID -> 
            if itemID == model.itemID then
                { model | del = True }
            else
                model

-- view
view : Model -> Html Msg
view model = 
    li [] 
        [ 
            checkbox (ToggleDone model.itemID) model
        ]

checkbox : Msg -> Model -> Html Msg
checkbox msg model = 
    label []
        [ input [ type_ "checkbox", checked model.done, onClick msg ] []
        , viewItem model
        , viewDeleteButton model
        ]

viewItem : Model -> Html Msg
viewItem model =
    if model.done == False then
        text model.item
    else
        s [] 
            [ span [ style [ ("color", "gray") ] ]
                    [ text model.item ]
            ]

viewDeleteButton : Model -> Html Msg
viewDeleteButton model =
    span []
        [ button [ onClick (OnDelete model.itemID) ] [ text "x" ]
        ]
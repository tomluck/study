module TodoCreator exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

-- model
type alias Item = 
    String

type alias Model = 
    { item : Item
    , current : Item
    }

initialModel : Model
initialModel = 
    { item = ""
    , current = ""
    }

type Msg
    = NoOp
    | AddNew String

-- update
update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            model ! []

        AddNew s -> 
            { model | current = s } ! []

-- view
view : Model -> Html Msg
view model = 
    div [] [ Html.text "sample" ]
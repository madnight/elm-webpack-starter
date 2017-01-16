module Main exposing (..)
import Html exposing (..)
import Components.ApiData exposing (..)

main : Program Never Model Msg
main = Html.program
    {
      init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

init : (Model, Cmd Msg)
init = (Model [], getProgrammingLanguages)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NewLang (Ok apiUrl) ->
      (Model apiUrl, Cmd.none)
    NewLang (Err _) ->
      (model, Cmd.none)

toTable : List ProgrammingLanguage -> Html msg
toTable strings =
  table []
    [
      thead []
        [
          th [] [text "Product"],
          th [] [text "Amount"]
        ],
      tbody [] (List.map row (strings))
    ]

row : ProgrammingLanguage -> Html msg
row x = tr []
  [
    td [] [text x.name],
    td [] [text (toString x.count)]
  ]

view : Model -> Html Msg
view model = toTable model.languageList

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

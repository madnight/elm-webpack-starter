port module Main exposing (..)
-- module Main exposing (..)
import Html exposing (..)
import Components.ApiData exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick )

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

    Check ->
      ( model, check (ProgrammingLanguage "Hello World" 1 2 3))

    NewLang (Err _) ->
      (model, Cmd.none)

toTable : List ProgrammingLanguage -> Html Msg
toTable strings =
  div [ class  "container", style [("margin-top", "30px"), ( "text-align", "center" )] ]
  [
  p [] [ text ( "Elm Webpack Starter" ) ]
  , button [ class "btn btn-primary btn-lg", onClick Check ] [                  -- click handler
  span[ class "glyphicon glyphicon-star" ][]                                      -- glyphicon
  , span[][ text "FTW!" ]
  ],
  table []
    [
      thead []
        [
          th [] [text "Product"],
          th [] [text "Amount"]
        ],
      tbody [] (List.map row (strings))
    ]
  -- , button [ class "btn btn-primary btn-lg", onClick Check ]
  ]


-- port reset : Signal ()

port check : ProgrammingLanguage -> Cmd msg

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

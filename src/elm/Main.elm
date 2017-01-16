import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode exposing (..)
import Json.Decode.Extra exposing (..)

type alias ProgrammingLanguage = {
  name : String,
  year : Int,
  quarter: Int,
  count : Int
}

type alias Model = { languageList : List ProgrammingLanguage }

type Msg = NewLang (Result Http.Error (List ProgrammingLanguage))

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

header : Html msg -> Html msg
header content = th [ scope "col" ] [ content ]

toHtmlList : List ProgrammingLanguage -> Html msg
toHtmlList strings =
  table []
    [
      thead []
        [
          th [] [text "Product"],
          th [] [text "Amount"]
        ],
      tbody [] (List.map row (sort strings))
    ]

row :  ProgrammingLanguage -> Html msg
row x = tr []
  [
    td [] [text x.name],
    td [] [text (toString x.count)]
  ]

sort : List ProgrammingLanguage -> List ProgrammingLanguage
sort xs =
  xs
    |> filterYear 2015
    |> List.sortBy .count
    |> List.reverse

filterYear : Int -> List ProgrammingLanguage -> List ProgrammingLanguage
filterYear s = List.filterMap (\p -> isYear p s)

isYear : ProgrammingLanguage -> Int -> Maybe ProgrammingLanguage
isYear x y = if x.year == y then Just x else Nothing

toLi : ProgrammingLanguage -> Html msg
toLi lang = li [] [ text (
  lang.name ++ " " ++
  toString lang.year ++ " " ++
  toString lang.quarter ++ " " ++
  toString lang.count
  )]

view : Model -> Html Msg
view model = toHtmlList model.languageList


subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

getProgrammingLanguages : Cmd Msg
getProgrammingLanguages =
  let url = "gh-star-event.json"
  in Http.send NewLang (Http.get url langListDecoder)

stringAsInt : Decoder Int
stringAsInt = string |> andThen (String.toInt >> fromResult)

langDecoder : Decoder ProgrammingLanguage
langDecoder =
  map4 ProgrammingLanguage
    (field "name" string)
    (field "year" stringAsInt)
    (field "quarter" stringAsInt)
    (field "count" stringAsInt)
    -- string |> andThen (String.toInt >> fromResult))

langListDecoder : Decoder (List ProgrammingLanguage)
langListDecoder = Json.Decode.list langDecoder

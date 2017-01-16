module Components.ApiData exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Extra exposing (..)
import String
import Http

type alias Model = { languageList : List ProgrammingLanguage }
type Msg = NewLang (Result Http.Error (List ProgrammingLanguage)) | Check

type alias ProgrammingLanguage = {
  name : String,
  year : Int,
  quarter: Int,
  count : Int
}

getProgrammingLanguages : Cmd Msg
getProgrammingLanguages =
  let url = "gh-star-event.json"
  in Http.send NewLang (Http.get url langListDecoder)

stringAsInt : Decoder Int
stringAsInt = andThen (\n -> fromResult(String.toInt(n))) string

langDecoder : Decoder ProgrammingLanguage
langDecoder =
  map4 ProgrammingLanguage
    (field "name" string)
    (field "year" stringAsInt)
    (field "quarter" stringAsInt)
    (field "count" stringAsInt)

langListDecoder : Decoder (List ProgrammingLanguage)
langListDecoder = Json.Decode.list langDecoder

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

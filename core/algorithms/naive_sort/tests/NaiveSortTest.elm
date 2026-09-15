module NaiveSortTest exposing (tests)

{-| Pruebas del módulo `naive_sort` para la especificación 05_Naive_Sort.md.

Caso nulo: Elm no tiene `null`/`nil` y `List Int` no puede representar una
entrada inválida, por lo que el caso nulo de la especificación se omite: no
existe tal entrada y Elm tampoco lanza excepciones.

-}

import Expect
import NaiveSort exposing (bubbleSort, insertionSort, selectionSort)
import Test exposing (Test, describe, test)


standardInput : List Int
standardInput =
    [ 5, 2, 9, 1, 5, 6 ]


standardOutput : List Int
standardOutput =
    [ 1, 2, 5, 5, 6, 9 ]


sortedInput : List Int
sortedInput =
    [ 1, 2, 3, 4, 5 ]


sortedOutput : List Int
sortedOutput =
    [ 1, 2, 3, 4, 5 ]


reverseInput : List Int
reverseInput =
    [ 5, 4, 3, 2, 1 ]


reverseOutput : List Int
reverseOutput =
    [ 1, 2, 3, 4, 5 ]


identicalInput : List Int
identicalInput =
    [ 7, 7, 7, 7 ]


identicalOutput : List Int
identicalOutput =
    [ 7, 7, 7, 7 ]


negativeInput : List Int
negativeInput =
    [ 3, -1, 4, -5, 0 ]


negativeOutput : List Int
negativeOutput =
    [ -5, -1, 0, 3, 4 ]


singleInput : List Int
singleInput =
    [ 42 ]


singleOutput : List Int
singleOutput =
    [ 42 ]


emptyInput : List Int
emptyInput =
    []


emptyOutput : List Int
emptyOutput =
    []


cases : List ( String, List Int, List Int )
cases =
    [ ( "an unsorted array", standardInput, standardOutput )
    , ( "an already sorted array", sortedInput, sortedOutput )
    , ( "a reverse ordered array", reverseInput, reverseOutput )
    , ( "an array of identical elements", identicalInput, identicalOutput )
    , ( "an array with negative numbers", negativeInput, negativeOutput )
    , ( "a single element array", singleInput, singleOutput )
    , ( "an empty array", emptyInput, emptyOutput )
    ]


{-| Las listas de Elm son inmutables: no hace falta copiar los fixtures porque
ninguna función puede mutarlos entre casos.
-}
assertSortsAllCases : (List Int -> List Int) -> String -> Test
assertSortsAllCases sortFunction algorithm =
    describe algorithm
        (List.map
            (\( description, input, expected ) ->
                test (algorithm ++ " should sort " ++ description) <|
                    \_ -> Expect.equal expected (sortFunction input)
            )
            cases
        )


tests : Test
tests =
    describe "NaiveSort"
        [ assertSortsAllCases selectionSort "selection_sort"
        , assertSortsAllCases bubbleSort "bubble_sort"
        , assertSortsAllCases insertionSort "insertion_sort"
        ]

module NaiveSort exposing (
    selectionSort,
    bubbleSort,
    insertionSort
)

{-| Selection sort algorithm.
Input: A list of integers.
Output: A list of integers sorted in ascending order.
-}
selectionSort : List Int -> List Int
selectionSort list =
    case list of
        [] ->
            []

        first :: rest ->
            let
                (minIdx, remaining) = pickMin first rest
            in
            minIdx :: selectionSort remaining

{-| Pick the minimum element from a list.
Input: The current minimum value and the rest of the list.
Output: A tuple containing the minimum value and the remaining list after removing the minimum.
-}
pickMin : Int -> List Int -> (Int, List Int)
pickMin minVal list =
    case list of
        [] ->
            (minVal, [])

        first :: rest ->
            if first < minVal then
                let
                    (newMin, remaining) = pickMin first rest
                in
                (newMin, minVal :: remaining)
            else
                let
                    (newMin, remaining) = pickMin minVal rest
                in
                (newMin, first :: remaining)

{-| Bubble sort algorithm.
Input: A list of integers.
Output: A list of integers sorted in ascending order.
-}
bubbleSort : List Int -> List Int
bubbleSort list =
    case list of
        [] ->
            []

        first :: rest ->
            let
                (sorted, swapped) = bubblePass (first :: rest)
            in
            if swapped then
                bubbleSort sorted
            else
                sorted

{-| Perform a single pass of bubble sort.
Input: A list of integers.
Output: A tuple containing the list after one pass and a boolean indicating if any swaps were made.
-}
bubblePass : List Int -> (List Int, Bool)
bubblePass list =
    case list of
        [] ->
            ([], False)

        [x] ->
            ([x], False)

        first :: second :: rest ->
            if first > second then
                let
                    (newRest, swapped) = bubblePass (first :: rest)
                in
                (second :: newRest, True)
            else
                let
                    (newRest, swapped) = bubblePass (second :: rest)
                in
                (first :: newRest, swapped)

{-| Insertion sort algorithm.
Input: A list of integers.
Output: A list of integers sorted in ascending order.
-}
insertionSort : List Int -> List Int
insertionSort list =
    case list of
        [] ->
            []

        first :: rest ->
            insert first (insertionSort rest)

{-| Insert an element into a sorted list.
Input: An integer and a sorted list of integers.
Output: A new sorted list with the integer inserted.
-}
insert : Int -> List Int -> List Int
insert x list =
    case list of
        [] ->
            [x]

        first :: rest ->
            if x <= first then
                x :: first :: rest
            else
                first :: insert x rest
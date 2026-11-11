module DataStructuresAdvancedTest exposing (tests)

{-| Pruebas del módulo `data_structures_advanced` para la especificación
07_Data_Structures_Advanced.md: 23 casos (TreeNode 6, BinaryTree 7, Graph 10)
en tres grupos por abstracción.

Caso nulo: Elm no tiene `null`; la ausencia es `Nothing`. Los enlaces ausentes
son `Nothing` y el fallo de `graphAddEdge`/`graphGetNeighbors` es `Nothing`,
distinto de `Just []`. Las estructuras son inmutables: cada escenario
continúa con el valor que devuelve la operación anterior, y el caso
«Adaptación inmutable» aplica porque Elm es inmutable.

-}

import DataStructuresAdvanced exposing
    ( BinaryTree
    , Graph
    , TreeNode
    , binaryTreeContains
    , binaryTreeInsert
    , binaryTreeIsEmpty
    , binaryTreeSize
    , emptyBinaryTree
    , emptyGraph
    , graphAddEdge
    , graphAddVertex
    , graphEdgeCount
    , graphGetNeighbors
    , graphHasEdge
    , graphIsEmpty
    , graphVertexCount
    , treeNodeInit
    , treeNodeLeft
    , treeNodeRight
    , treeNodeValue
    , treeNodeWithLeft
    , treeNodeWithRight
    )
import Expect exposing (Expectation)
import Test exposing (Test, describe, test)


{-| Ejecuta los pasos de un escenario en orden; el primer fallo lleva su mensaje.
-}
steps : List Expectation -> Expectation
steps expectations =
    Expect.all (List.map (\e _ -> e) expectations) ()


check : String -> a -> a -> Expectation
check message expected actual =
    Expect.equal expected actual |> Expect.onFail message


-- TreeNode


parentValue : Int
parentValue =
    10


leftValue : Int
leftValue =
    20


rightValue : Int
rightValue =
    30


leftChild : TreeNode
leftChild =
    treeNodeInit leftValue


rightChild : TreeNode
rightChild =
    treeNodeInit rightValue


linkedParent : TreeNode
linkedParent =
    treeNodeInit parentValue
        |> treeNodeWithLeft (Just leftChild)
        |> treeNodeWithRight (Just rightChild)


valueOf : Maybe TreeNode -> Maybe Int
valueOf =
    Maybe.map treeNodeValue


treeNodeTests : Test
treeNodeTests =
    describe "TreeNode"
        [ test "Create a tree node" <|
            \_ ->
                check "treeNodeValue should be 10 for treeNodeInit 10"
                    10
                    (treeNodeValue (treeNodeInit parentValue))
        , test "Absent initial links" <|
            \_ ->
                steps
                    [ check "treeNodeLeft of a new node should be Nothing" Nothing (valueOf (treeNodeLeft (treeNodeInit parentValue)))
                    , check "treeNodeRight of a new node should be Nothing" Nothing (valueOf (treeNodeRight (treeNodeInit parentValue)))
                    ]
        , test "Link two children" <|
            \_ ->
                steps
                    [ check "left child value should be 20" (Just leftValue) (valueOf (treeNodeLeft linkedParent))
                    , check "right child value should be 30" (Just rightValue) (valueOf (treeNodeRight linkedParent))
                    ]
        , test "Traverse each link" <|
            \_ ->
                let
                    left =
                        treeNodeLeft linkedParent

                    right =
                        treeNodeRight linkedParent
                in
                steps
                    [ check "following left should lead to 20" (Just leftValue) (valueOf left)
                    , check "following right should lead to 30" (Just rightValue) (valueOf right)
                    , check "left child's left link should be absent" Nothing (left |> Maybe.andThen treeNodeLeft |> valueOf)
                    , check "left child's right link should be absent" Nothing (left |> Maybe.andThen treeNodeRight |> valueOf)
                    , check "right child's left link should be absent" Nothing (right |> Maybe.andThen treeNodeLeft |> valueOf)
                    , check "right child's right link should be absent" Nothing (right |> Maybe.andThen treeNodeRight |> valueOf)
                    ]
        , test "Unlink children" <|
            \_ ->
                let
                    withoutLeft =
                        treeNodeWithLeft Nothing linkedParent

                    withoutBoth =
                        treeNodeWithRight Nothing withoutLeft
                in
                steps
                    [ check "clearing left should keep value 10" parentValue (treeNodeValue withoutLeft)
                    , check "clearing left should leave left absent" Nothing (valueOf (treeNodeLeft withoutLeft))
                    , check "clearing left should keep right child 30" (Just rightValue) (valueOf (treeNodeRight withoutLeft))
                    , check "clearing right should leave left absent" Nothing (valueOf (treeNodeLeft withoutBoth))
                    , check "clearing right should leave right absent" Nothing (valueOf (treeNodeRight withoutBoth))
                    , check "clearing right should keep value 10" parentValue (treeNodeValue withoutBoth)
                    ]
        , test "Immutable adaptation" <|
            \_ ->
                let
                    original =
                        treeNodeInit parentValue

                    updated =
                        treeNodeWithLeft (Just leftChild) original
                in
                steps
                    [ check "set left should return a node with the link" (Just leftValue) (valueOf (treeNodeLeft updated))
                    , check "the original node should keep its left link absent" Nothing (valueOf (treeNodeLeft original))
                    ]
        ]



-- BinaryTree


insertAll : List Int -> BinaryTree
insertAll =
    List.foldl binaryTreeInsert emptyBinaryTree


presentAll : List Int -> BinaryTree -> Expectation
presentAll values tree =
    steps
        (List.map
            (\v -> check ("contains " ++ String.fromInt v ++ " should succeed") True (binaryTreeContains v tree))
            values
        )


binaryTreeTests : Test
binaryTreeTests =
    describe "BinaryTree"
        [ test "Create empty" <|
            \_ ->
                steps
                    [ check "is_empty should be true" True (binaryTreeIsEmpty emptyBinaryTree)
                    , check "size should be 0" 0 (binaryTreeSize emptyBinaryTree)
                    , check "contains 50 should fail" False (binaryTreeContains 50 emptyBinaryTree)
                    ]
        , test "Insert the root" <|
            \_ ->
                let
                    tree =
                        insertAll [ 50 ]
                in
                steps
                    [ check "size should be 1" 1 (binaryTreeSize tree)
                    , check "is_empty should be false" False (binaryTreeIsEmpty tree)
                    , check "contains 50 should succeed" True (binaryTreeContains 50 tree)
                    ]
        , test "Insert lower and higher" <|
            \_ ->
                let
                    tree =
                        insertAll [ 50, 30, 70 ]
                in
                steps
                    [ check "size should be 3" 3 (binaryTreeSize tree)
                    , presentAll [ 50, 30, 70 ] tree
                    ]
        , test "Multilevel branches" <|
            \_ ->
                let
                    tree =
                        insertAll [ 50, 30, 70, 20, 40 ]
                in
                steps
                    [ presentAll [ 50, 30, 70, 20, 40 ] tree
                    , check "size should be 5" 5 (binaryTreeSize tree)
                    ]
        , test "Missing value in nonempty tree" <|
            \_ ->
                let
                    tree =
                        insertAll [ 50 ]
                in
                steps
                    [ check "contains 99 should fail" False (binaryTreeContains 99 tree)
                    , check "size should stay 1" 1 (binaryTreeSize tree)
                    , check "contains 50 should still succeed" True (binaryTreeContains 50 tree)
                    ]
        , test "Idempotent duplicate" <|
            \_ ->
                let
                    tree =
                        insertAll [ 50, 30, 70, 30 ]
                in
                steps
                    [ check "size should be 3 after the duplicate" 3 (binaryTreeSize tree)
                    , presentAll [ 50, 30, 70 ] tree
                    ]
        , test "Ordered insertions" <|
            \_ ->
                let
                    tree =
                        insertAll [ 20, 30, 40, 50, 70 ]
                in
                steps
                    [ check "size should be 5" 5 (binaryTreeSize tree)
                    , presentAll [ 20, 30, 40, 50, 70 ] tree
                    , check "contains 99 should fail" False (binaryTreeContains 99 tree)
                    ]
        ]



-- Graph


addVertices : List Int -> Graph
addVertices =
    List.foldl graphAddVertex emptyGraph


addEdges : List ( Int, Int ) -> Graph -> Maybe Graph
addEdges edges graph =
    List.foldl (\( u, v ) acc -> Maybe.andThen (graphAddEdge u v) acc) (Just graph) edges


counts : Int -> Int -> Maybe Graph -> Expectation
counts vertices edges maybeGraph =
    case maybeGraph of
        Nothing ->
            Expect.fail "every operation should succeed"

        Just graph ->
            steps
                [ check ("vertex_count should be " ++ String.fromInt vertices) vertices (graphVertexCount graph)
                , check ("edge_count should be " ++ String.fromInt edges) edges (graphEdgeCount graph)
                ]


neighborsOf : Int -> Maybe Graph -> Maybe (List Int)
neighborsOf vertex =
    Maybe.andThen (graphGetNeighbors vertex)


graphTests : Test
graphTests =
    describe "Graph"
        [ test "Create empty" <|
            \_ ->
                steps
                    [ check "is_empty should be true" True (graphIsEmpty emptyGraph)
                    , check "vertex_count should be 0" 0 (graphVertexCount emptyGraph)
                    , check "edge_count should be 0" 0 (graphEdgeCount emptyGraph)
                    , check "has_edge 10 30 should fail" False (graphHasEdge 10 30 emptyGraph)
                    , check "get_neighbors 10 should fail" Nothing (graphGetNeighbors 10 emptyGraph)
                    ]
        , test "Isolated vertex" <|
            \_ ->
                let
                    graph =
                        graphAddVertex 10 emptyGraph
                in
                steps
                    [ check "graph should not be empty" False (graphIsEmpty graph)
                    , counts 1 0 (Just graph)
                    , check "neighbours of 10 should be empty" (Just []) (graphGetNeighbors 10 graph)
                    ]
        , test "Nonconsecutive labels and directed edge" <|
            \_ ->
                let
                    result =
                        addEdges [ ( 10, 70 ) ] (addVertices [ 10, 70 ])
                in
                steps
                    [ check "has_edge 10 70 should succeed" (Just True) (Maybe.map (graphHasEdge 10 70) result)
                    , check "has_edge 70 10 should fail" (Just False) (Maybe.map (graphHasEdge 70 10) result)
                    , counts 2 1 result
                    ]
        , test "Duplicate vertex preserves adjacency" <|
            \_ ->
                let
                    result =
                        addEdges [ ( 10, 30 ) ] (addVertices [ 10, 30 ])
                            |> Maybe.map (graphAddVertex 10)
                in
                steps
                    [ counts 2 1 result
                    , check "neighbours of 10 should be [30]" (Just [ 30 ]) (neighborsOf 10 result)
                    ]
        , test "Duplicate edge" <|
            \_ ->
                let
                    result =
                        addEdges [ ( 10, 30 ), ( 10, 30 ) ] (addVertices [ 10, 30 ])
                in
                steps
                    [ counts 2 1 result
                    , check "neighbours of 10 should be [30]" (Just [ 30 ]) (neighborsOf 10 result)
                    ]
        , test "Missing endpoint without mutation" <|
            \_ ->
                let
                    base =
                        addEdges [ ( 10, 30 ) ] (addVertices [ 10, 30 ])
                            |> Maybe.withDefault emptyGraph

                    attempt u v =
                        graphAddEdge u v base
                in
                steps
                    [ check "add_edge 10 99 should fail" Nothing (attempt 10 99)
                    , check "add_edge 99 10 should fail" Nothing (attempt 99 10)
                    , check "add_edge 98 99 should fail" Nothing (attempt 98 99)
                    , check "add_edge 99 99 should fail" Nothing (attempt 99 99)
                    , counts 2 1 (Just base)
                    , check "neighbours of 10 should stay [30]" (Just [ 30 ]) (graphGetNeighbors 10 base)
                    , check "neighbours of 30 should be empty" (Just []) (graphGetNeighbors 30 base)
                    , check "has_edge 10 99 should fail" False (graphHasEdge 10 99 base)
                    , check "has_edge 99 10 should fail" False (graphHasEdge 99 10 base)
                    , check "has_edge 98 99 should fail" False (graphHasEdge 98 99 base)
                    , check "has_edge 99 99 should fail" False (graphHasEdge 99 99 base)
                    , check "get_neighbors 98 should fail" Nothing (graphGetNeighbors 98 base)
                    , check "get_neighbors 99 should fail" Nothing (graphGetNeighbors 99 base)
                    ]
        , test "Sorted neighbours and counts" <|
            \_ ->
                let
                    result =
                        addEdges [ ( 10, 70 ), ( 10, 30 ), ( 10, 50 ), ( 30, 50 ) ] (addVertices [ 10, 30, 50, 70 ])
                in
                steps
                    [ check "neighbours of 10 should be [30,50,70]" (Just [ 30, 50, 70 ]) (neighborsOf 10 result)
                    , check "neighbours of 30 should be [50]" (Just [ 50 ]) (neighborsOf 30 result)
                    , check "neighbours of 50 should be empty" (Just []) (neighborsOf 50 result)
                    , check "neighbours of 70 should be empty" (Just []) (neighborsOf 70 result)
                    , counts 4 4 result
                    ]
        , test "Missing-edge query" <|
            \_ ->
                let
                    graph =
                        addVertices [ 10, 30 ]
                in
                steps
                    [ check "has_edge 10 30 should fail" False (graphHasEdge 10 30 graph)
                    , counts 2 0 (Just graph)
                    , check "graph should not be empty" False (graphIsEmpty graph)
                    ]
        , test "Neighbours of missing vertex" <|
            \_ ->
                let
                    graph =
                        graphAddVertex 10 emptyGraph
                in
                steps
                    [ check "get_neighbors 99 should fail" Nothing (graphGetNeighbors 99 graph)
                    , check "failure should differ from empty neighbours of 10" (Just []) (graphGetNeighbors 10 graph)
                    , counts 1 0 (Just graph)
                    ]
        , test "Self-loop and duplicate" <|
            \_ ->
                let
                    result =
                        addEdges [ ( 10, 10 ), ( 10, 10 ) ] (graphAddVertex 10 emptyGraph)
                in
                steps
                    [ check "has_edge 10 10 should succeed" (Just True) (Maybe.map (graphHasEdge 10 10) result)
                    , check "neighbours of 10 should be [10]" (Just [ 10 ]) (neighborsOf 10 result)
                    , counts 1 1 result
                    ]
        ]


tests : Test
tests =
    describe "DataStructuresAdvanced"
        [ treeNodeTests
        , binaryTreeTests
        , graphTests
        ]

module DataStructuresAdvanced exposing
    ( Node(..)
    , TreeNode
    , BinaryTree
    , GraphNode
    , Graph
    , nodeValue
    , treeNodeInit
    , treeNodeValue
    , treeNodeLeft
    , treeNodeRight
    , treeNodeWithLeft
    , treeNodeWithRight
    , emptyBinaryTree
    , binaryTreeInsert
    , binaryTreeContains
    , binaryTreeIsEmpty
    , binaryTreeSize
    , emptyGraph
    , graphAddVertex
    , graphAddEdge
    , graphHasEdge
    , graphGetNeighbors
    , graphIsEmpty
    , graphVertexCount
    , graphEdgeCount
    )

{-| Contrato del módulo `data_structures_advanced` (especificación
07_Data_Structures_Advanced.md): nodo con solo el valor, árbol binario de
búsqueda y grafo dirigido.

Elm es V2 (inmutable): cada operación devuelve un valor nuevo. La ausencia es
`Nothing : Maybe a`, que la convención V2 admite como representación nativa y
la guía de adaptaciones no prohíbe: los enlaces opcionales internos y los
opcionales nativos están permitidos. Por eso los enlaces son
`Maybe TreeNode` y `graphGetNeighbors` distingue el vértice inexistente
(`Nothing`) del vértice aislado (`Just []`).

-}


{-| Valor compartido del módulo: solo el valor, sin enlaces ni instancias
propias del tipo base.
-}
type Node
    = Node Int


{-| Nodo del ABB: valor y dos enlaces opcionales. Un enlace ausente es
`Nothing`.
-}
type TreeNode
    = TreeNode Node (Maybe TreeNode) (Maybe TreeNode)


{-| Árbol binario de búsqueda: raíz opcional y contador de valores distintos.
-}
type BinaryTree
    = BinaryTree (Maybe TreeNode) Int


{-| Vértice del grafo: valor, adyacencia ordenada y enlace al siguiente
vértice del registro canónico. Interno a `Graph`.
-}
type GraphNode
    = GraphNode Node (List Int) (Maybe GraphNode)


{-| Grafo dirigido: registro enlazado de vértices y contadores propios.
-}
type Graph
    = Graph (Maybe GraphNode) Int Int


{-| Valor del nodo base.
-}
nodeValue : Node -> Int
nodeValue (Node value) =
    value


{-| Nodo de árbol con el valor indicado y ambos enlaces ausentes.
-}
treeNodeInit : Int -> TreeNode
treeNodeInit value =
    TreeNode (Node value) Nothing Nothing


{-| Valor del nodo de árbol.
-}
treeNodeValue : TreeNode -> Int
treeNodeValue (TreeNode (Node value) _ _) =
    value


{-| Enlace izquierdo; `Nothing` si el subárbol está vacío.
-}
treeNodeLeft : TreeNode -> Maybe TreeNode
treeNodeLeft (TreeNode _ left _) =
    left


{-| Enlace derecho; `Nothing` si el subárbol está vacío.
-}
treeNodeRight : TreeNode -> Maybe TreeNode
treeNodeRight (TreeNode _ _ right) =
    right


{-| Copia del nodo con el enlace izquierdo reemplazado.
-}
treeNodeWithLeft : Maybe TreeNode -> TreeNode -> TreeNode
treeNodeWithLeft left (TreeNode value _ right) =
    TreeNode value left right


{-| Copia del nodo con el enlace derecho reemplazado.
-}
treeNodeWithRight : Maybe TreeNode -> TreeNode -> TreeNode
treeNodeWithRight right (TreeNode value left _) =
    TreeNode value left right


{-| Árbol vacío utilizable.
-}
emptyBinaryTree : BinaryTree
emptyBinaryTree =
    BinaryTree Nothing 0


{-| Inserta el valor; un duplicado también es éxito y no crece el tamaño.
-}
binaryTreeInsert : Int -> BinaryTree -> BinaryTree
binaryTreeInsert value (BinaryTree root count) =
    let
        ( newRoot, inserted ) =
            insertNode value root
    in
    BinaryTree newRoot
        (if inserted then
            count + 1

         else
            count
        )


insertNode : Int -> Maybe TreeNode -> ( Maybe TreeNode, Bool )
insertNode value maybeNode =
    case maybeNode of
        Nothing ->
            ( Just (treeNodeInit value), True )

        Just node ->
            let
                nodeValueNow =
                    treeNodeValue node
            in
            if value < nodeValueNow then
                let
                    ( newLeft, inserted ) =
                        insertNode value (treeNodeLeft node)
                in
                ( Just (treeNodeWithLeft newLeft node), inserted )

            else if value > nodeValueNow then
                let
                    ( newRight, inserted ) =
                        insertNode value (treeNodeRight node)
                in
                ( Just (treeNodeWithRight newRight node), inserted )

            else
                ( Just node, False )


{-| Pertenencia según la invariante del ABB.
-}
binaryTreeContains : Int -> BinaryTree -> Bool
binaryTreeContains value (BinaryTree root _) =
    containsNode value root

containsNode : Int -> Maybe TreeNode -> Bool
containsNode value maybeNode =
    case maybeNode of
        Nothing ->
            False

        Just node ->
            let
                nodeValueNow =
                    treeNodeValue node
            in
            if value < nodeValueNow then
                containsNode value (treeNodeLeft node)

            else if value > nodeValueNow then
                containsNode value (treeNodeRight node)

            else
                True


{-| Verdadero si el árbol no tiene valores.
-}
binaryTreeIsEmpty : BinaryTree -> Bool
binaryTreeIsEmpty (BinaryTree _ count) =
    count == 0


{-| Número de valores distintos del árbol.
-}
binaryTreeSize : BinaryTree -> Int
binaryTreeSize (BinaryTree _ count) =
    count


{-| Grafo vacío utilizable.
-}
emptyGraph : Graph
emptyGraph =
    Graph Nothing 0 0


graphNodeValue : GraphNode -> Int
graphNodeValue (GraphNode (Node value) _ _) =
    value


graphNodeNeighbors : GraphNode -> List Int
graphNodeNeighbors (GraphNode _ neighbors _) =
    neighbors


graphNodeNext : GraphNode -> Maybe GraphNode
graphNodeNext (GraphNode _ _ next) =
    next


findVertex : Int -> Maybe GraphNode -> Maybe GraphNode
findVertex label maybeNode =
    case maybeNode of
        Nothing ->
            Nothing

        Just node ->
            if graphNodeValue node == label then
                Just node

            else
                findVertex label (graphNodeNext node)


updateVertexNeighbors : Int -> List Int -> Maybe GraphNode -> Maybe GraphNode
updateVertexNeighbors label newNeighbors maybeNode =
    case maybeNode of
        Nothing ->
            Nothing

        Just ((GraphNode value _ next) as node) ->
            if nodeValue value == label then
                Just (GraphNode value newNeighbors next)

            else
                Just
                    (GraphNode value
                        (graphNodeNeighbors node)
                        (updateVertexNeighbors label newNeighbors next)
                    )


{-| Registra el vértice; un duplicado también es éxito y conserva la
adyacencia.
-}
graphAddVertex : Int -> Graph -> Graph
graphAddVertex label ((Graph vertices vertexTotal edgeTotal) as graph) =
    case findVertex label vertices of
        Just _ ->
            graph

        Nothing ->
            Graph
                (Just (GraphNode (Node label) [] vertices))
                (vertexTotal + 1)
                edgeTotal


{-| Añade la arista dirigida `u -> v`. `Nothing` si falta alguno de los dos
extremos; una arista repetida también es éxito.
-}
graphAddEdge : Int -> Int -> Graph -> Maybe Graph
graphAddEdge u v ((Graph vertices vertexTotal edgeTotal) as graph) =
    case ( findVertex u vertices, findVertex v vertices ) of
        ( Just uNode, Just _ ) ->
            let
                currentNeighbors =
                    graphNodeNeighbors uNode
            in
            if List.member v currentNeighbors then
                Just graph

            else
                Just
                    (Graph
                        (updateVertexNeighbors u
                            (insertSorted v currentNeighbors)
                            vertices
                        )
                        vertexTotal
                        (edgeTotal + 1)
                    )

        _ ->
            Nothing


{-| Verdadero si existe la arista dirigida `u -> v`.
-}
graphHasEdge : Int -> Int -> Graph -> Bool
graphHasEdge u v (Graph vertices _ _) =
    case findVertex u vertices of
        Just uNode ->
            List.member v (graphNodeNeighbors uNode)
        Nothing ->
            False

insertSorted : Int -> List Int -> List Int
insertSorted value list =
    case list of
        [] ->
            [ value ]
        x :: xs ->
            if value < x then
                value :: list
            else if value > x then
                x :: insertSorted value xs
            else
                list

{-| Vecinos ordenados del vértice: `Nothing` si el vértice no está registrado,
`Just []` si está aislado.
-}
graphGetNeighbors : Int -> Graph -> Maybe (List Int)
graphGetNeighbors label (Graph vertices _ _) =
    case findVertex label vertices of
        Just node ->
            Just (graphNodeNeighbors node)
        Nothing ->
            Nothing


{-| Verdadero si el grafo no tiene vértices.
-}
graphIsEmpty : Graph -> Bool
graphIsEmpty (Graph _ vertexTotal _) =
    vertexTotal == 0


{-| Número de vértices registrados.
-}
graphVertexCount : Graph -> Int
graphVertexCount (Graph _ vertexTotal _) =
    vertexTotal


{-| Número de aristas registradas.
-}
graphEdgeCount : Graph -> Int
graphEdgeCount (Graph _ _ edges) =
    edges

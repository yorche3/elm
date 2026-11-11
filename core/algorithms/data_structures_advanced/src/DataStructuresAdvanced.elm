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

Cuerpo pendiente: este fichero declara el contrato; la implementación llega en
el paso siguiente.

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
nodeValue _ =
    -1


{-| Nodo de árbol con el valor indicado y ambos enlaces ausentes.
-}
treeNodeInit : Int -> TreeNode
treeNodeInit _ =
    TreeNode (Node -1) Nothing Nothing


{-| Valor del nodo de árbol.
-}
treeNodeValue : TreeNode -> Int
treeNodeValue _ =
    -1


{-| Enlace izquierdo; `Nothing` si el subárbol está vacío.
-}
treeNodeLeft : TreeNode -> Maybe TreeNode
treeNodeLeft _ =
    Nothing


{-| Enlace derecho; `Nothing` si el subárbol está vacío.
-}
treeNodeRight : TreeNode -> Maybe TreeNode
treeNodeRight _ =
    Nothing


{-| Copia del nodo con el enlace izquierdo reemplazado.
-}
treeNodeWithLeft : Maybe TreeNode -> TreeNode -> TreeNode
treeNodeWithLeft _ node =
    node


{-| Copia del nodo con el enlace derecho reemplazado.
-}
treeNodeWithRight : Maybe TreeNode -> TreeNode -> TreeNode
treeNodeWithRight _ node =
    node


{-| Árbol vacío utilizable.
-}
emptyBinaryTree : BinaryTree
emptyBinaryTree =
    BinaryTree Nothing 0


{-| Inserta el valor; un duplicado también es éxito y no crece el tamaño.
-}
binaryTreeInsert : Int -> BinaryTree -> BinaryTree
binaryTreeInsert _ tree =
    tree


{-| Pertenencia según la invariante del ABB.
-}
binaryTreeContains : Int -> BinaryTree -> Bool
binaryTreeContains _ _ =
    False


{-| Verdadero si el árbol no tiene valores.
-}
binaryTreeIsEmpty : BinaryTree -> Bool
binaryTreeIsEmpty _ =
    False


{-| Número de valores distintos del árbol.
-}
binaryTreeSize : BinaryTree -> Int
binaryTreeSize _ =
    -1


{-| Grafo vacío utilizable.
-}
emptyGraph : Graph
emptyGraph =
    Graph Nothing 0 0


{-| Registra el vértice; un duplicado también es éxito y conserva la
adyacencia.
-}
graphAddVertex : Int -> Graph -> Graph
graphAddVertex _ graph =
    graph


{-| Añade la arista dirigida `u -> v`. `Nothing` si falta alguno de los dos
extremos; una arista repetida también es éxito.
-}
graphAddEdge : Int -> Int -> Graph -> Maybe Graph
graphAddEdge _ _ _ =
    Nothing


{-| Verdadero si existe la arista dirigida `u -> v`.
-}
graphHasEdge : Int -> Int -> Graph -> Bool
graphHasEdge _ _ _ =
    False


{-| Vecinos ordenados del vértice: `Nothing` si el vértice no está registrado,
`Just []` si está aislado.
-}
graphGetNeighbors : Int -> Graph -> Maybe (List Int)
graphGetNeighbors _ _ =
    Nothing


{-| Verdadero si el grafo no tiene vértices.
-}
graphIsEmpty : Graph -> Bool
graphIsEmpty _ =
    False


{-| Número de vértices registrados.
-}
graphVertexCount : Graph -> Int
graphVertexCount _ =
    -1


{-| Número de aristas registradas.
-}
graphEdgeCount : Graph -> Int
graphEdgeCount _ =
    -1

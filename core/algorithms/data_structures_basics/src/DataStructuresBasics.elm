module DataStructuresBasics exposing
    ( Node(..)
    , LinkedList(..)
    , Stack(..)
    , Queue(..)
    , emptyLinkedList
    , linkedListHead
    , linkedListInsertHead
    , linkedListInsertTail
    , linkedListDelete
    , linkedListIsEmpty
    , linkedListSize
    , emptyStack
    , stackPush
    , stackPop
    , stackPeek
    , stackIsEmpty
    , stackSize
    , emptyQueue
    , queueEnqueue
    , queueDequeue
    , queuePeek
    , queueIsEmpty
    , queueSize
    )

type Node
    = Node Int (Maybe Node)

type LinkedList
    = LinkedList (Maybe Node) (Maybe Node) Int

type Stack
    = Stack (Maybe Node) Int

type Queue
    = Queue (Maybe Node) (Maybe Node) Int

emptyLinkedList : LinkedList
emptyLinkedList =
    LinkedList Nothing Nothing 0

linkedListHead : LinkedList -> Int
linkedListHead (LinkedList head _ _) =
    case head of
        Nothing ->
            -1
        Just (Node value _) ->
            value

linkedListInsertHead : Int -> LinkedList -> LinkedList
linkedListInsertHead value (LinkedList head tail count) =
    let
        newNode = Node value head
        newTail =
            case tail of
                Nothing ->
                    Just newNode

                Just _ ->
                    tail
    in
    LinkedList (Just newNode) newTail (count + 1)

linkedListInsertTail : Int -> LinkedList -> LinkedList
linkedListInsertTail value (LinkedList head _ count) =
    let
        newNode = Node value Nothing
    in
    case head of
        Nothing ->
            LinkedList (Just newNode) (Just newNode) (count + 1)

        Just first ->
            LinkedList (Just (appendLast first newNode)) (Just newNode) (count + 1)


{-| Enlaza `newNode` al final de la cadena. Con nodos inmutables el enlace del
último nodo no se puede modificar: hay que devolver una copia nueva de cada nodo
del tramo hasta la cola, y por eso la inserción por el final es O(n).
-}
appendLast : Node -> Node -> Node
appendLast node newNode =
    case node of
        Node nodeValue Nothing ->
            Node nodeValue (Just newNode)

        Node nodeValue (Just next) ->
            Node nodeValue (Just (appendLast next newNode))

linkedListDelete : Int -> LinkedList -> Maybe LinkedList
linkedListDelete value (LinkedList head _ count) =
    case removeFirst value head of
        Nothing ->
            Nothing

        Just newHead ->
            Just (LinkedList newHead (lastNode newHead) (count - 1))


{-| Quita la primera aparición y devuelve la cabeza nueva —que puede quedar
vacía—; `Nothing` cuando el valor no está en la lista.
-}
removeFirst : Int -> Maybe Node -> Maybe (Maybe Node)
removeFirst value node =
    case node of
        Nothing ->
            Nothing

        Just (Node nodeValue next) ->
            if nodeValue == value then
                Just next

            else
                case removeFirst value next of
                    Nothing ->
                        Nothing

                    Just newNext ->
                        Just (Just (Node nodeValue newNext))


{-| Última celda de la cadena; `Nothing` si no queda ninguna.
-}
lastNode : Maybe Node -> Maybe Node
lastNode node =
    case node of
        Nothing ->
            Nothing

        Just (Node _ Nothing) ->
            node

        Just (Node _ next) ->
            lastNode next


linkedListIsEmpty : LinkedList -> Bool
linkedListIsEmpty (LinkedList _ _ count) =
    count == 0


linkedListSize : LinkedList -> Int
linkedListSize (LinkedList _ _ count) =
    count


emptyStack : Stack
emptyStack =
    Stack Nothing 0


stackPush : Int -> Stack -> Stack
stackPush value (Stack head count) =
    Stack (Just (Node value head)) (count + 1)

stackPop : Stack -> Maybe ( Int, Stack )
stackPop (Stack top count) =
    case top of
        Nothing ->
            Nothing

        Just (Node value next) ->
            Just ( value, Stack next (count - 1) )

stackPeek : Stack -> Int
stackPeek (Stack top _) =
    case top of
        Nothing ->
            -1
        Just (Node value _) ->
            value

stackIsEmpty : Stack -> Bool
stackIsEmpty (Stack _ count) =
    count == 0

stackSize : Stack -> Int
stackSize (Stack _ count) =
    count

emptyQueue : Queue
emptyQueue =
    Queue Nothing Nothing 0

queueEnqueue : Int -> Queue -> Queue
queueEnqueue value (Queue front _ count) =
    let
        newNode = Node value Nothing
    in
    case front of
        Nothing ->
            Queue (Just newNode) (Just newNode) (count + 1)

        Just first ->
            Queue (Just (appendLast first newNode)) (Just newNode) (count + 1)

queueDequeue : Queue -> Maybe ( Int, Queue )
queueDequeue (Queue front tail count) =
    case front of
        Nothing ->
            Nothing
        Just (Node value next) ->
            Just ( value, Queue next (if next == Nothing then Nothing else tail) (count - 1) )

queuePeek : Queue -> Int
queuePeek (Queue front _ _) =
    case front of
        Nothing ->
            -1
        Just (Node value _) ->
            value

queueIsEmpty : Queue -> Bool
queueIsEmpty (Queue _ _ count) =
    count == 0

queueSize : Queue -> Int
queueSize (Queue _ _ count) =
    count

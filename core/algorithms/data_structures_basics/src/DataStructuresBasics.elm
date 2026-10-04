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


-- LINKED LIST --------------------------------------------------------------

{-| Empty list; this is `init()` in the specification.
-}
emptyLinkedList : LinkedList
emptyLinkedList =
    LinkedList Nothing Nothing 0


{-| Head value, or `Nothing` on an empty list.
-}
linkedListHead : LinkedList -> Int
linkedListHead _ =
    0


{-| Insert at the front.
-}
linkedListInsertHead : Int -> LinkedList -> LinkedList
linkedListInsertHead _ list =
    list


{-| Insert at the back.
-}
linkedListInsertTail : Int -> LinkedList -> LinkedList
linkedListInsertTail _ list =
    list


{-| Remove the first occurrence; `Nothing` when the value is absent.
-}
linkedListDelete : Int -> LinkedList -> Maybe LinkedList
linkedListDelete _ _ =
    Nothing


linkedListIsEmpty : LinkedList -> Bool
linkedListIsEmpty _ =
    False


linkedListSize : LinkedList -> Int
linkedListSize _ =
    0


-- STACK --------------------------------------------------------------------

{-| Empty stack; this is `init()` in the specification.
-}
emptyStack : Stack
emptyStack =
    Stack Nothing 0


stackPush : Int -> Stack -> Stack
stackPush _ stack =
    stack


{-| Remove and return the top; `Nothing` on an empty stack.
-}
stackPop : Stack -> Maybe ( Int, Stack )
stackPop _ =
    Nothing


{-| Observe the top without removing it; `Nothing` on an empty stack.
-}
stackPeek : Stack -> Int
stackPeek _ =
    0


stackIsEmpty : Stack -> Bool
stackIsEmpty _ =
    False


stackSize : Stack -> Int
stackSize _ =
    0


-- QUEUE --------------------------------------------------------------------

{-| Empty queue; this is `init()` in the specification.
-}
emptyQueue : Queue
emptyQueue =
    Queue Nothing Nothing 0


queueEnqueue : Int -> Queue -> Queue
queueEnqueue _ queue =
    queue


{-| Remove and return the front; `Nothing` on an empty queue.
-}
queueDequeue : Queue -> Maybe ( Int, Queue )
queueDequeue _ =
    Nothing


{-| Observe the front without removing it; `Nothing` on an empty queue.
-}
queuePeek : Queue -> Int
queuePeek _ =
    0


queueIsEmpty : Queue -> Bool
queueIsEmpty _ =
    False


queueSize : Queue -> Int
queueSize _ =
    0

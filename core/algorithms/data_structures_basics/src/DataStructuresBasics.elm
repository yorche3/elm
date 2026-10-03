module DataStructuresBasics exposing
    ( Node
    , LinkedList
    , Stack
    , Queue
    , nodeInit
    , nodeGetValue
    , nodeGetNext
    , nodeSetNext
    , linkedListInit
    , linkedListGetHead
    , linkedListInsertHead
    , linkedListInsertTail
    , linkedListDelete
    , linkedListIsEmpty
    , linkedListSize
    , stackInit
    , stackPush
    , stackPop
    , stackPeek
    , stackIsEmpty
    , stackSize
    , queueInit
    , queueEnqueue
    , queueDequeue
    , queuePeek
    , queueIsEmpty
    , queueSize
    )


type Node
    = Node


type LinkedList
    = LinkedList


type Stack
    = Stack


type Queue
    = Queue


nodeInit : Int -> Node
nodeInit _ =
    Node


nodeGetValue : Node -> Int
nodeGetValue _ =
    -1


nodeGetNext : Node -> Node
nodeGetNext _ =
    Node


nodeSetNext : Node -> Node -> Node
nodeSetNext _ _ =
    Node


linkedListInit : LinkedList
linkedListInit =
    LinkedList


linkedListGetHead : LinkedList -> Int
linkedListGetHead _ =
    -1


linkedListInsertHead : Int -> LinkedList -> LinkedList
linkedListInsertHead _ _ =
    LinkedList


linkedListInsertTail : Int -> LinkedList -> LinkedList
linkedListInsertTail _ _ =
    LinkedList


linkedListDelete : Int -> LinkedList -> ( LinkedList, Bool )
linkedListDelete _ _ =
    ( LinkedList, False )


linkedListIsEmpty : LinkedList -> Bool
linkedListIsEmpty _ =
    False


linkedListSize : LinkedList -> Int
linkedListSize _ =
    -1


stackInit : Stack
stackInit =
    Stack


stackPush : Int -> Stack -> Stack
stackPush _ _ =
    Stack


stackPop : Stack -> ( Stack, Int )
stackPop _ =
    ( Stack, -1 )


stackPeek : Stack -> Int
stackPeek _ =
    -1


stackIsEmpty : Stack -> Bool
stackIsEmpty _ =
    False


stackSize : Stack -> Int
stackSize _ =
    -1


queueInit : Queue
queueInit =
    Queue


queueEnqueue : Int -> Queue -> Queue
queueEnqueue _ _ =
    Queue


queueDequeue : Queue -> ( Queue, Int )
queueDequeue _ =
    ( Queue, -1 )


queuePeek : Queue -> Int
queuePeek _ =
    -1


queueIsEmpty : Queue -> Bool
queueIsEmpty _ =
    False


queueSize : Queue -> Int
queueSize _ =
    -1

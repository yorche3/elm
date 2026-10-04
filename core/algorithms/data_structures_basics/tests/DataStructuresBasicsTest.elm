module DataStructuresBasicsTest exposing (tests)

{-| Pruebas del módulo `data_structures_basics` para la especificación
06_Data_Structures_Basics.md: 15 casos (Node 2, LinkedList 5, Stack 4, Queue 4)
en cuatro escenarios.

Caso nulo: Elm no tiene `null`/`nil` y las operaciones reciben `Int`, así que la
especificación no define ninguna entrada nula para este módulo: el caso se omite
y no se lanza ninguna excepción. Las estructuras son inmutables, así que cada
escenario continúa con la estructura que devuelve la operación anterior.

-}

import DataStructuresBasics exposing
    ( LinkedList(..)
    , Node(..)
    , Queue
    , Stack
    , emptyLinkedList
    , emptyQueue
    , emptyStack
    , linkedListDelete
    , linkedListHead
    , linkedListInsertHead
    , linkedListInsertTail
    , linkedListIsEmpty
    , linkedListSize
    , queueDequeue
    , queueEnqueue
    , queueIsEmpty
    , queuePeek
    , queueSize
    , stackIsEmpty
    , stackPeek
    , stackPop
    , stackPush
    , stackSize
    )
import Expect exposing (Expectation)
import Test exposing (Test, describe, test)


{-| Valores de prueba: enteros positivos, fuera del dominio del indicador de
fallo (`-1`).
-}
firstValue : Int
firstValue =
    10


secondValue : Int
secondValue =
    20


thirdValue : Int
thirdValue =
    30


headValue : Int
headValue =
    5


absentValue : Int
absentValue =
    99


reusedValue : Int
reusedValue =
    40


{-| Indicador de fallo del contrato, el que devuelven `linkedListHead`,
`stackPeek` y `queuePeek` cuando la estructura está vacía.
-}
failureValue : Int
failureValue =
    -1


{-| Recorrido esperado tras insertar 10, 20 por la cola y 5 por la cabeza y 10
por la cola.
-}
listAfterBothEnds : List Int
listAfterBothEnds =
    [ 5, 10, 20, 10 ]


{-| Recorrido esperado tras eliminar la primera aparición de 10.
-}
listAfterDelete : List Int
listAfterDelete =
    [ 5, 20, 10 ]


{-| Compara el valor observado con el esperado y nombra el caso si difieren.
-}
expectEqual : String -> a -> a -> Expectation
expectEqual message expected actual =
    Expect.onFail message (Expect.equal expected actual)


{-| `True` cuando la operación encontró el valor que tenía que eliminar.
-}
removed : Maybe a -> Bool
removed result =
    case result of
        Just _ ->
            True

        Nothing ->
            False


{-| Continúa con la estructura que produjo una eliminación con éxito, o con la
misma cuando el valor no estaba.
-}
continuing : Maybe a -> a -> a
continuing result fallback =
    case result of
        Just structure ->
            structure

        Nothing ->
            fallback


{-| Extrae una vez, compara el valor con el caso y devuelve la estructura que
queda, para seguir el escenario sin reiniciarlo.
-}
removesTo : String -> Int -> Maybe ( Int, s ) -> s -> ( Expectation, s )
removesTo message expected result fallback =
    case result of
        Just ( value, structure ) ->
            ( expectEqual message expected value, structure )

        Nothing ->
            ( Expect.fail (message ++ " (nothing was removed)"), fallback )


{-| `get_value()` del contrato, leído por el constructor expuesto `Node`.
-}
nodeValue : Node -> Int
nodeValue (Node value _) =
    value


{-| `get_next()` del contrato, leído por el constructor expuesto `Node`.
-}
nodeNext : Node -> Maybe Node
nodeNext (Node _ next) =
    next


{-| Recorrido de los enlaces del contrato, desde la cabeza de la lista.
-}
traverse : LinkedList -> List Int
traverse (LinkedList head _ _) =
    traverseNode head


traverseNode : Maybe Node -> List Int
traverseNode maybeNode =
    case maybeNode of
        Nothing ->
            []

        Just node ->
            nodeValue node :: traverseNode (nodeNext node)


nodeCase : () -> Expectation
nodeCase _ =
    let
        a =
            Node firstValue Nothing

        b =
            Node secondValue Nothing

        linked =
            Node firstValue (Just b)
    in
    Expect.all
        [ \_ -> expectEqual "Node init should assign the value" firstValue (nodeValue a)
        , \_ -> expectEqual "Node init should leave the next link absent" Nothing (nodeNext a)
        , \_ -> expectEqual "Node set_next should link the next node" (Just secondValue) (Maybe.map nodeValue (nodeNext linked))
        , \_ -> expectEqual "a linked node should keep its next link absent" Nothing (nodeNext b)
        ]
        ()


linkedListCase : () -> Expectation
linkedListCase _ =
    let
        list0 =
            emptyLinkedList

        list1 =
            list0
                |> linkedListInsertTail firstValue
                |> linkedListInsertTail secondValue
                |> linkedListInsertHead headValue
                |> linkedListInsertTail firstValue

        deletedFirst =
            linkedListDelete firstValue list1

        list2 =
            continuing deletedFirst list1

        deletedAbsent =
            linkedListDelete absentValue list2

        list3 =
            continuing deletedAbsent list2

        emptiedHead =
            linkedListDelete headValue list3

        list4 =
            continuing emptiedHead list3

        emptiedSecond =
            linkedListDelete secondValue list4

        list5 =
            continuing emptiedSecond list4

        emptiedLast =
            linkedListDelete firstValue list5

        list6 =
            continuing emptiedLast list5
    in
    Expect.all
        [ \_ -> expectEqual "LinkedList should be empty after init" True (linkedListIsEmpty list0)
        , \_ -> expectEqual "LinkedList should start with size 0" 0 (linkedListSize list0)
        , \_ -> expectEqual "LinkedList get_head should return the failure indicator on an empty list" failureValue (linkedListHead list0)
        , \_ -> expectEqual "LinkedList should count one element per insertion" 4 (linkedListSize list1)
        , \_ -> expectEqual "LinkedList should traverse 5, 10, 20, 10 from the head" listAfterBothEnds (traverse list1)
        , \_ -> expectEqual "LinkedList delete should succeed on the first occurrence" True (removed deletedFirst)
        , \_ -> expectEqual "LinkedList delete should remove only the first occurrence" listAfterDelete (traverse list2)
        , \_ -> expectEqual "LinkedList delete should decrement the size on success" 3 (linkedListSize list2)
        , \_ -> expectEqual "LinkedList delete should fail on an absent value" False (removed deletedAbsent)
        , \_ -> expectEqual "a failed LinkedList delete should keep the elements" listAfterDelete (traverse list3)
        , \_ -> expectEqual "a failed LinkedList delete should keep the size" 3 (linkedListSize list3)
        , \_ -> expectEqual "LinkedList delete should remove the remaining head" True (removed emptiedHead)
        , \_ -> expectEqual "LinkedList delete should remove the remaining second value" True (removed emptiedSecond)
        , \_ -> expectEqual "LinkedList delete should remove the remaining last value" True (removed emptiedLast)
        , \_ -> expectEqual "LinkedList should be empty after deleting every element" True (linkedListIsEmpty list6)
        , \_ -> expectEqual "LinkedList should report size 0 after deleting every element" 0 (linkedListSize list6)
        , \_ -> expectEqual "LinkedList get_head should return the failure indicator once empty" failureValue (linkedListHead list6)
        ]
        ()


stackCase : () -> Expectation
stackCase _ =
    let
        stack0 =
            emptyStack

        stack1 =
            stack0
                |> stackPush firstValue
                |> stackPush secondValue
                |> stackPush thirdValue

        ( popFirst, stack2 ) =
            removesTo "Stack pop should remove the most recent value first" thirdValue (stackPop stack1) stack1

        stack3 =
            stackPush reusedValue stack2

        ( popReused, stack4 ) =
            removesTo "Stack pop should remove the reused value next" reusedValue (stackPop stack3) stack3

        ( popSecond, stack5 ) =
            removesTo "Stack pop should continue in LIFO order" secondValue (stackPop stack4) stack4

        ( popLast, stack6 ) =
            removesTo "Stack pop should remove the oldest value last" firstValue (stackPop stack5) stack5
    in
    Expect.all
        [ \_ -> expectEqual "Stack should be empty after init" True (stackIsEmpty stack0)
        , \_ -> expectEqual "Stack should start with size 0" 0 (stackSize stack0)
        , \_ -> expectEqual "Stack peek should return the failure indicator on an empty stack" failureValue (stackPeek stack0)
        , \_ -> expectEqual "Stack pop should return the failure indicator on an empty stack" Nothing (stackPop stack0)
        , \_ -> expectEqual "Stack peek should observe the most recent value without removing it" thirdValue (stackPeek stack1)
        , \_ -> expectEqual "Stack peek should not change the size" 3 (stackSize stack1)
        , \_ -> popFirst
        , \_ -> popReused
        , \_ -> popSecond
        , \_ -> popLast
        , \_ -> expectEqual "Stack should be empty after popping every value" True (stackIsEmpty stack6)
        , \_ -> expectEqual "Stack should report size 0 after popping every value" 0 (stackSize stack6)
        , \_ -> expectEqual "Stack pop should keep failing once empty" Nothing (stackPop stack6)
        , \_ -> expectEqual "Stack should stay empty after a failed pop" True (stackIsEmpty stack6)
        ]
        ()


queueCase : () -> Expectation
queueCase _ =
    let
        queue0 =
            emptyQueue

        queue1 =
            queue0
                |> queueEnqueue firstValue
                |> queueEnqueue secondValue
                |> queueEnqueue thirdValue

        ( dequeueFirst, queue2 ) =
            removesTo "Queue dequeue should remove the oldest value first" firstValue (queueDequeue queue1) queue1

        queue3 =
            queueEnqueue reusedValue queue2

        ( dequeueSecond, queue4 ) =
            removesTo "Queue dequeue should continue in FIFO order" secondValue (queueDequeue queue3) queue3

        ( dequeueThird, queue5 ) =
            removesTo "Queue dequeue should return the third value next" thirdValue (queueDequeue queue4) queue4

        ( dequeueReused, queue6 ) =
            removesTo "Queue dequeue should return the reused value last" reusedValue (queueDequeue queue5) queue5
    in
    Expect.all
        [ \_ -> expectEqual "Queue should be empty after init" True (queueIsEmpty queue0)
        , \_ -> expectEqual "Queue should start with size 0" 0 (queueSize queue0)
        , \_ -> expectEqual "Queue peek should return the failure indicator on an empty queue" failureValue (queuePeek queue0)
        , \_ -> expectEqual "Queue dequeue should return the failure indicator on an empty queue" Nothing (queueDequeue queue0)
        , \_ -> expectEqual "Queue peek should observe the oldest value without removing it" firstValue (queuePeek queue1)
        , \_ -> expectEqual "Queue peek should not change the size" 3 (queueSize queue1)
        , \_ -> dequeueFirst
        , \_ -> dequeueSecond
        , \_ -> dequeueThird
        , \_ -> dequeueReused
        , \_ -> expectEqual "Queue should be empty after dequeuing every value" True (queueIsEmpty queue6)
        , \_ -> expectEqual "Queue should report size 0 after dequeuing every value" 0 (queueSize queue6)
        , \_ -> expectEqual "Queue dequeue should keep failing once empty" Nothing (queueDequeue queue6)
        , \_ -> expectEqual "Queue should stay empty after a failed dequeue" True (queueIsEmpty queue6)
        ]
        ()


{-| Un test por estructura, como en el módulo homologado: los casos de la
especificación son pasos sucesivos sobre la misma instancia lógica.
-}
tests : Test
tests =
    describe "DataStructuresBasics"
        [ test "Node" nodeCase
        , test "LinkedList" linkedListCase
        , test "Stack" stackCase
        , test "Queue" queueCase
        ]

module Numbers exposing (sumFirstNRec, factorialRec, fibonacciRec,
        greatestCommonDivisorRec, leastCommonMultipleRec,
        sumFirstNAcc, factorialAcc, fibonacciAcc,
        greatestCommonDivisorAcc, leastCommonMultipleAcc,
        sumFirstNIte, factorialIte, fibonacciIte,
        greatestCommonDivisorIte, leastCommonMultipleIte)

sumFirstNRec : Int -> Int
sumFirstNRec n =
    if n <= 0 then
        0
    else
        n + sumFirstNRec (n - 1)

factorialRec : Int -> Int
factorialRec n =
    if n <= 1 then
        1
    else
        n * factorialRec (n - 1)

fibonacciRec : Int -> Int
fibonacciRec n =
    if n <= 1 then
        n
    else
        fibonacciRec (n - 1) + fibonacciRec (n - 2)

greatestCommonDivisorRec : Int -> Int -> Int
greatestCommonDivisorRec a b =
    if b == 0 then
        a
    else
        greatestCommonDivisorRec b (modBy b a)

leastCommonMultipleRec : Int -> Int -> Int
leastCommonMultipleRec a b =
    let
        g = greatestCommonDivisorRec a b
    in
    a * b // g

sumFirstNAcc : Int -> Int
sumFirstNAcc n = sumFirstNHelp n 0

sumFirstNHelp : Int -> Int -> Int
sumFirstNHelp n acc =
    if n <= 0 then
        acc
    else
        sumFirstNHelp (n - 1) (n + acc)

factorialAcc : Int -> Int
factorialAcc n = factorialHelp n 1

factorialHelp : Int -> Int -> Int
factorialHelp n acc =
    if n <= 1 then
        acc
    else
        factorialHelp (n - 1) (n * acc)

fibonacciAcc : Int -> Int
fibonacciAcc n = fibonacciHelp n 0 1

fibonacciHelp : Int -> Int -> Int -> Int
fibonacciHelp n acc1 acc2 =
    if n <= 0 then
        acc1
    else
        fibonacciHelp (n - 1) acc2 (acc1 + acc2)

greatestCommonDivisorAcc : Int -> Int -> Int
greatestCommonDivisorAcc a b =
    if b == 0 then
        a
    else
        greatestCommonDivisorAcc b (modBy b a)

leastCommonMultipleAcc : Int -> Int -> Int
leastCommonMultipleAcc a b =
    let
        g = greatestCommonDivisorAcc a b
    in
    a * b // g

sumFirstNIte : Int -> Int
sumFirstNIte n =
    let
        loop : Int -> Int -> Int
        loop count acc =
            if count <= 0 then
                acc
            else
                loop (count - 1) (count + acc)
    in
    loop n 0

factorialIte : Int -> Int
factorialIte n =
    let
        loop : Int -> Int -> Int
        loop count acc =
            if count <= 1 then
                acc
            else
                loop (count - 1) (count * acc)
    in
    loop n 1


fibonacciIte : Int -> Int
fibonacciIte n =
    let
        loop : Int -> Int -> Int -> Int
        loop count acc1 acc2 =
            if count <= 0 then
                acc1
            else
                loop (count - 1) acc2 (acc1 + acc2)
    in
    loop n 0 1


greatestCommonDivisorIte : Int -> Int -> Int
greatestCommonDivisorIte a b =
    let
        loop : Int -> Int -> Int
        loop x y =
            if y == 0 then
                x
            else
                loop y (modBy y x)
    in
    loop a b


leastCommonMultipleIte : Int -> Int -> Int
leastCommonMultipleIte a b =
    let
        g = greatestCommonDivisorIte a b
    in
    a * b // g

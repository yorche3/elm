module NumbersRecTest exposing (tests)

import Expect
import Test exposing (..)
import Numbers exposing (sumFirstNRec, factorialRec, fibonacciRec,
        greatestCommonDivisorRec, leastCommonMultipleRec)


tests : Test
tests =
    describe "Testing Numbers Recursive"
        [ -- list of tests or describes
          describe "Sum of first n recursive" 
            [ test "sum of first 0" <| \_ -> Expect.equal (sumFirstNRec 0) 0
            , test "sum of first 3" <| \_ -> Expect.equal (sumFirstNRec 3) 6 ]
          
        , describe "Factorial Recursive"
            [ test "factorial of 0" <| \_ -> Expect.equal (factorialRec 0) 1
            , test "factorial of 4" <| \_ -> Expect.equal (factorialRec 4) 24 ]
          
        , describe "Fibonacci Recursive"
            [ test "fibonacci of 0" <| \_ -> Expect.equal (fibonacciRec 0) 0
            , test "fibonacci of 1" <| \_ -> Expect.equal (fibonacciRec 1) 1
            , test "fibonacci of 6" <| \_ -> Expect.equal (fibonacciRec 6) 8 ]
          
        , describe "greatest Common Divisor Recursive"
            [ test "lcd of 12 and 8" <| \_ -> Expect.equal (greatestCommonDivisorRec 12 8) 4
            , test "lcd of 7 and 5" <| \_ -> Expect.equal (greatestCommonDivisorRec 7 5) 1 ]
          
        , describe "Least Common Multiple Recursive"
            [ test "lcm of 8 and 6" <| \_ -> Expect.equal (leastCommonMultipleRec 8 6) 24
            , test "lcm of 4 and 6" <| \_ -> Expect.equal (leastCommonMultipleRec 6 4) 12 ]
        ]
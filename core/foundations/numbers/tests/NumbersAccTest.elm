module NumbersAccTest exposing (tests)

import Expect
import Test exposing (..)
import Numbers exposing (sumFirstNAcc, factorialAcc, fibonacciAcc,
        greatestCommonDivisorAcc, leastCommonMultipleAcc)


tests : Test
tests =
    describe "Testing Numbers Accumulator"
        [ -- list of tests or describes
          describe "Sum of first n Accumulator" 
            [ test "sum of first 0" <| \_ -> Expect.equal (sumFirstNAcc 0) 0
            , test "sum of first 3" <| \_ -> Expect.equal (sumFirstNAcc 3) 6 ]
          
        , describe "Factorial Accumulator"
            [ test "factorial of 0" <| \_ -> Expect.equal (factorialAcc 0) 1
            , test "factorial of 4" <| \_ -> Expect.equal (factorialAcc 4) 24 ]
          
        , describe "Fibonacci Accumulator"
            [ test "fibonacci of 0" <| \_ -> Expect.equal (fibonacciAcc 0) 0
            , test "fibonacci of 1" <| \_ -> Expect.equal (fibonacciAcc 1) 1
            , test "fibonacci of 6" <| \_ -> Expect.equal (fibonacciAcc 6) 8 ]
          
        , describe "greatest Common Divisor Accumulator"
            [ test "lcd of 12 and 8" <| \_ -> Expect.equal (greatestCommonDivisorAcc 12 8) 4
            , test "lcd of 7 and 5" <| \_ -> Expect.equal (greatestCommonDivisorAcc 7 5) 1 ]
          
        , describe "Least Common Multiple Accumulator"
            [ test "lcm of 8 and 6" <| \_ -> Expect.equal (leastCommonMultipleAcc 8 6) 24
            , test "lcm of 4 and 6" <| \_ -> Expect.equal (leastCommonMultipleAcc 6 4) 12 ]
        ]
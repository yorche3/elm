module NumbersIteTest exposing (tests)

import Expect
import Test exposing (..)
import Numbers exposing (sumFirstNIte, factorialIte, fibonacciIte,
        greatestCommonDivisorIte, leastCommonMultipleIte)


tests : Test
tests =
    describe "Testing Numbers Iteursive"
        [ -- list of tests or describes
          describe "Sum of first n Iteursive" 
            [ test "sum of first 0" <| \_ -> Expect.equal (sumFirstNIte 0) 0
            , test "sum of first 3" <| \_ -> Expect.equal (sumFirstNIte 3) 6 ]
          
        , describe "Factorial Iteursive"
            [ test "factorial of 0" <| \_ -> Expect.equal (factorialIte 0) 1
            , test "factorial of 4" <| \_ -> Expect.equal (factorialIte 4) 24 ]
          
        , describe "Fibonacci Iteursive"
            [ test "fibonacci of 0" <| \_ -> Expect.equal (fibonacciIte 0) 0
            , test "fibonacci of 1" <| \_ -> Expect.equal (fibonacciIte 1) 1
            , test "fibonacci of 6" <| \_ -> Expect.equal (fibonacciIte 6) 8 ]
          
        , describe "greatest Common Divisor Iteursive"
            [ test "lcd of 12 and 8" <| \_ -> Expect.equal (greatestCommonDivisorIte 12 8) 4
            , test "lcd of 7 and 5" <| \_ -> Expect.equal (greatestCommonDivisorIte 7 5) 1 ]
          
        , describe "Least Common Multiple Iteursive"
            [ test "lcm of 8 and 6" <| \_ -> Expect.equal (leastCommonMultipleIte 8 6) 24
            , test "lcm of 4 and 6" <| \_ -> Expect.equal (leastCommonMultipleIte 6 4) 12 ]
        ]
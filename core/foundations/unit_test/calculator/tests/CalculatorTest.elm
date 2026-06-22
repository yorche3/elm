module CalculatorTest exposing (tests)

import Expect
import Test exposing (..)
import Calculator exposing (addition, subtraction, multiplication, division, modulus)


tests : Test
tests =
    describe "Testing Calculator"
        [ -- list of tests or describes
          describe "Addition" 
            [ test "2 + 3" <| \_ -> Expect.equal (addition 2 3) 5 ]
          
        , describe "Subtraction"
            [ test "5 - 2" <| \_ -> Expect.equal (subtraction 5 2) 3 ]
          
        , describe "Multiplication"
            [ test "3 * 4" <| \_ -> Expect.equal (multiplication 4 3) 12 ]
          
        , describe "Division"
            [ test "10 / 3" <| \_ -> Expect.equal (division 10 3) 3 ]
          
        , describe "Modulus"
            [ test "10 % 3" <| \_ -> Expect.equal (modulus 10 3) 1 ]
        ]
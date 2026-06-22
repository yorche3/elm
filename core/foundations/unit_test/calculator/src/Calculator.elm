module Calculator exposing (addition, subtraction, multiplication, division, modulus)

addition : Int -> Int -> Int
addition a b = a + b

subtraction : Int -> Int -> Int
subtraction a b = a - b

multiplication : Int -> Int -> Int
multiplication a b =
    let
        loop : Int -> Int -> Int
        loop acc count =
            if count <= 0 then
                acc
            else
                loop (addition acc a) (subtraction count 1)
    in
    loop 0 b

division : Int -> Int -> Int
division a b =
    let
        loop : Int -> Int -> Int
        loop dividend quotient =
            if dividend < b then
                quotient
            else
                loop (subtraction dividend b) (addition quotient 1)
    in
    loop a 0

modulus : Int -> Int -> Int
modulus a b =
    let
        quotient = division a b
        product = multiplication quotient b
    in
    subtraction a product
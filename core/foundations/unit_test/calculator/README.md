# Calculator — Elm

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Elm 0.19.1**, usando **elm-test** como framework de pruebas unitarias.

Implementa las 5 operaciones aritméticas (`addition`, `subtraction`, `multiplication`, `division`, `modulus`) usando únicamente `+` y `-` como operaciones primitivas directas, con fines educativos.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`elm.json`](elm.json) | Manifiesto del proyecto Elm (dependencias, versión). |
| [`src/Calculator.elm`](src/Calculator.elm) | Implementación de las 5 operaciones aritméticas. |
| [`tests/CalculatorTest.elm`](tests/CalculatorTest.elm) | 5 pruebas unitarias con `elm-test`. |

**Estructura de directorios esperada:**

```text
calculator/
├── elm.json                      # Manifiesto del proyecto
├── src/
│   └── Calculator.elm            # 5 operaciones aritméticas
├── tests/
│   └── CalculatorTest.elm        # 5 tests
├── elm-stuff/                    # Dependencias compiladas (generado)
└── README.md                     # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **Elm 0.19.1** con **elm-test** como framework de testing.

Características:
- **5 operaciones**: `addition`, `subtraction`, `multiplication`, `division`, `modulus`.
- **Implementación minimalista**: `multiplication`, `division` y `modulus` se construyen usando solo `+` y `-` como operaciones primitivas.
- **Recursión con acumulador**: tanto `multiplication` como `division` usan funciones helper internas (`loop`) que acumulan el resultado mediante recursión, evitando la mutación de estado.
- **Framework de tests**: `elm-test` proporciona los módulos `Test`, `Expect` y `describe/test` para estructurar las pruebas.

**EN:** This project uses **Elm 0.19.1** with **elm-test** as the test framework.

Features:
- **5 operations**: `addition`, `subtraction`, `multiplication`, `division`, `modulus`.
- **Minimalist implementation**: `multiplication`, `division` and `modulus` are built using only `+` and `-` as primitive operations.
- **Recursion with accumulator**: both `multiplication` and `division` use internal helper functions (`loop`) that accumulate the result via recursion, avoiding state mutation.
- **Test framework**: `elm-test` provides the `Test`, `Expect` and `describe/test` modules for structuring tests.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `elm.json` — Manifiesto del proyecto

**ES:** Define el tipo de proyecto (application), versión de Elm, directorios fuente y dependencias. Incluye `elm-explorations/test` como dependencia directa para las pruebas.

**EN:** Defines the project type (application), Elm version, source directories and dependencies. Includes `elm-explorations/test` as a direct dependency for testing.

```json
{
    "type": "application",
    "source-directories": ["src"],
    "elm-version": "0.19.1",
    "dependencies": {
        "direct": {
            "elm/browser": "1.0.2",
            "elm/core": "1.0.5",
            "elm/html": "1.0.1",
            "elm-explorations/test": "2.2.0"
        },
        "indirect": {
            "elm/json": "1.1.4",
            "elm/time": "1.0.0",
            "elm/url": "1.0.0",
            "elm/virtual-dom": "1.0.5"
        }
    },
    "test-dependencies": {
        "direct": {},
        "indirect": {}
    }
}
```

### `src/Calculator.elm` — Implementación

**ES:** Las 5 operaciones como funciones del módulo `Calculator`. `multiplication` usa una función helper recursiva `loop` que suma `a` repetidamente mientras un contador decrece desde `b` hasta 0. `division` usa otra función `loop` que resta `b` de `a` repetidamente mientras incrementa el cociente. `modulus` se define componiendo `division` y `multiplication`.

**EN:** The 5 operations as functions of the `Calculator` module. `multiplication` uses a recursive helper `loop` that repeatedly adds `a` while a counter decreases from `b` to 0. `division` uses another `loop` that subtracts `b` from `a` repeatedly while incrementing the quotient. `modulus` is defined by composing `division` and `multiplication`.

```elm
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
```

### `tests/CalculatorTest.elm` — Pruebas unitarias

**ES:** 5 grupos de tests con `elm-test`. Cada operación tiene su propio `describe` con un caso de prueba usando `Expect.equal`.

**EN:** 5 test groups with `elm-test`. Each operation has its own `describe` with a test case using `Expect.equal`.

```elm
module CalculatorTest exposing (tests)

import Expect
import Test exposing (..)
import Calculator exposing (addition, subtraction, multiplication, division, modulus)


tests : Test
tests =
    describe "Testing Calculator"
        [ describe "Addition"
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
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Elm y elm-test instalados

```bash
# Instalar Elm (vía npm)
npm install -g elm

# Instalar elm-test (vía npm)
npm install -g elm-test
```

### Ejecutar pruebas unitarias

```bash
cd core/foundations/unit_test/calculator
elm-test
```

**Salida esperada / Expected output:**

```text
elm-test 0.19.1-revision17
------------
TEST RUN PASSED

Duration: 0.01 s
Passed: 5
Failed: 0
```

---

## 🧠 Algoritmos / operaciones

| Operación | Implementación | Primitivas usadas |
|-----------|---------------|-------------------|
| `addition(a, b)` | `a + b` | `+` |
| `subtraction(a, b)` | `a - b` | `-` |
| `multiplication(a, b)` | Suma repetitiva de `a`, `b` veces con recursión | `+`, `-` |
| `division(a, b)` | Resta repetitiva de `b` de `a`, cuenta cociente | `+`, `-` |
| `modulus(a, b)` | `a - (cociente * b)` | `+`, `-` |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Elm es un lenguaje puramente funcional sin estado mutable. Los bucles se implementan con recursión usando funciones helper locales (`let ... in`).
- **EN:** Elm is a purely functional language without mutable state. Loops are implemented via recursion using local helper functions (`let ... in`).
- **ES:** La función helper `loop` en `multiplication` usa un acumulador (`acc`) que se incrementa con `addition` en cada paso recursivo, mientras el contador (`count`) decrece con `subtraction` hasta llegar a 0.
- **EN:** The `loop` helper in `multiplication` uses an accumulator (`acc`) that is incremented with `addition` on each recursive step, while the counter (`count`) is decremented with `subtraction` until it reaches 0.
- **ES:** En `division`, la función `loop` va restando `b` del dividendo y acumulando el cociente hasta que el dividendo es menor que `b`.
- **EN:** In `division`, the `loop` function repeatedly subtracts `b` from the dividend and accumulates the quotient until the dividend is less than `b`.
- **ES:** Todas las funciones tienen tipos explícitos (`Int -> Int -> Int`), siguiendo las buenas prácticas de Elm.
- **EN:** All functions have explicit type annotations (`Int -> Int -> Int`), following Elm best practices.
- **ES:** `elm-test` usa el módulo `Expect` para aserciones y `Test` para estructurar los casos en `describe`/`test`.
- **EN:** `elm-test` uses the `Expect` module for assertions and `Test` for structuring cases in `describe`/`test`.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

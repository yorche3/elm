# Naive Sort — Elm

> **Core Algorithms · 05_Naive_Sort · Elm 0.19.1**

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **Elm**, ejecutado con **elm-test**.

Implementa los tres algoritmos elementales de ordenamiento ($O(n^2)$) — **Selection Sort**, **Bubble Sort** e **Insertion Sort** — con recursión y pattern matching, sin invocar `List.sort` ni ninguna función de ordenamiento del sistema.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`elm.json`](elm.json) | Manifiesto del proyecto Elm: `source-directories` y dependencias, incluida `elm-explorations/test`. |
| [`src/NaiveSort.elm`](src/NaiveSort.elm) | Las 3 funciones públicas + 3 helpers privados. |
| [`tests/NaiveSortTest.elm`](tests/NaiveSortTest.elm) | 3 grupos de test (7 casos cada uno) = 21 tests. |
| `.gitignore` (raíz del submódulo) | `elm-stuff` y `repl-temp-*`. |

**Estructura del proyecto / Project layout:**

```text
naive_sort/
├── elm.json                  # Configuración del proyecto Elm
├── src/
│   └── NaiveSort.elm         # 3 funciones públicas + pickMin, bubblePass, insert
├── tests/
│   └── NaiveSortTest.elm     # 21 tests (3 algoritmos × 7 casos)
└── README.md                 # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó con `elm init`, que genera el `elm.json` y el directorio `src/` vacío. Elm es un lenguaje puramente funcional y **no tiene bucles imperativos ni estructuras mutables**: los tres algoritmos se expresan con **recursión y pattern matching**, y cada uno devuelve una lista nueva en lugar de ordenar *in-place*.

**EN:** The project was created with `elm init`, which generates `elm.json` and an empty `src/` directory. Elm is a purely functional language with **no imperative loops and no mutable structures**: all three algorithms are expressed with **recursion and pattern matching**, and each returns a new list instead of sorting in place.

```bash
elm init
```

---

## 📄 Configuración clave / Key Configuration

### `elm.json` — Manifiesto del proyecto

**ES:** Declara el tipo de proyecto (`application`), el directorio de fuentes (`src`) y las dependencias. Las pruebas usan `elm-explorations/test`, declarado en `test-dependencies`, no en `dependencies`: así el código de producción no depende del framework de tests.

**EN:** Declares the project type (`application`), the source directory (`src`) and the dependencies. Tests use `elm-explorations/test`, declared under `test-dependencies` rather than `dependencies`, so production code does not depend on the test framework.

```json
{
    "type": "application",
    "source-directories": [
        "src"
    ],
    "elm-version": "0.19.1",
    "test-dependencies": {
        "direct": {
            "elm-explorations/test": "2.2.1"
        },
        "indirect": {
            "elm/bytes": "1.0.8",
            "elm/random": "1.0.0"
        }
    }
}
```

### `src/NaiveSort.elm` — Implementación

**ES:** El módulo exporta únicamente las tres funciones del contrato. Los helpers `pickMin`, `bubblePass` e `insert` quedan **privados al módulo** porque no aparecen en el listado `exposing` — en Elm la visibilidad se controla desde la cabecera del módulo, no con una palabra clave en la función.

**EN:** The module exports only the three contract functions. The helpers `pickMin`, `bubblePass` and `insert` remain **module-private** because they are not listed in `exposing` — in Elm visibility is controlled from the module header, not with a keyword on the function.

```elm
module NaiveSort exposing (
    selectionSort,
    bubbleSort,
    insertionSort)

selectionSort : List Int -> List Int
selectionSort list =
    case list of
        [] ->
            []

        first :: rest ->
            let
                (minIdx, remaining) = pickMin first rest
            in
            minIdx :: selectionSort remaining


bubbleSort : List Int -> List Int
bubbleSort list =
    case list of
        [] ->
            []

        first :: rest ->
            let
                (sorted, swapped) = bubblePass (first :: rest)
            in
            if swapped then
                bubbleSort sorted
            else
                sorted
```

### `tests/NaiveSortTest.elm` — Pruebas

**ES:** Los siete casos de la especificación se declaran como **constantes con nombre** y se agrupan en una lista de tuplas `(descripción, entrada, esperada)`. Un único helper `assertSortsAllCases` genera los siete tests para cualquier algoritmo, de modo que añadir un algoritmo nuevo cuesta una línea.

**EN:** The seven specification cases are declared as **named constants** and grouped into a list of `(description, input, expected)` tuples. A single `assertSortsAllCases` helper generates the seven tests for any algorithm, so adding a new algorithm costs one line.

```elm
assertSortsAllCases : (List Int -> List Int) -> String -> Test
assertSortsAllCases sortFunction algorithm =
    describe algorithm
        (List.map
            (\( description, input, expected ) ->
                test (algorithm ++ " should sort " ++ description) <|
                    \_ -> Expect.equal expected (sortFunction input)
            )
            cases
        )


tests : Test
tests =
    describe "NaiveSort"
        [ assertSortsAllCases selectionSort "selection_sort"
        , assertSortsAllCases bubbleSort "bubble_sort"
        , assertSortsAllCases insertionSort "insertion_sort"
        ]
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: tener Elm y elm-test instalados

```bash
npm install -g elm elm-test
```

### Compilar y ejecutar pruebas

```bash
cd core/algorithms/naive_sort
elm make src/NaiveSort.elm --output=/dev/null
elm-test
```

**Salida real de `elm make` / Actual output:**

```text
Success! Compiled 1 module.
```

**Salida real de `elm-test` / Actual output:**

```text
Compiling > Starting tests

elm-test 0.19.1-revision17
--------------------------

Running 21 tests. To reproduce these results, run: elm-test --fuzz 100 --seed 151193755783559


TEST RUN PASSED

Duration: 117 ms
Passed:   21
Failed:   0
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Función | Estrategia | Complejidad | In-place | Tests |
|---------|-----------|-------------|:--------:|:-----:|
| `selectionSort` | `pickMin` extrae el mínimo y lo antepone al resultado de ordenar el resto | $O(n^2)$ siempre | ❌ (lista nueva) | 7 |
| `bubbleSort` | Repite `bubblePass`; se detiene cuando una pasada no intercambia nada | $O(n^2)$ peor/promedio, $O(n)$ mejor | ❌ (lista nueva) | 7 |
| `insertionSort` | Ordena la cola y luego inserta la cabeza con `insert` | $O(n^2)$ peor/promedio, $O(n)$ mejor | ❌ (lista nueva) | 7 |

| Helper privado | Firma | Papel |
|----------------|-------|-------|
| `pickMin` | `Int -> List Int -> (Int, List Int)` | Devuelve el mínimo y la lista sin él. |
| `bubblePass` | `List Int -> (List Int, Bool)` | Una pasada de burbuja; el `Bool` es la bandera `swapped`. |
| `insert` | `Int -> List Int -> List Int` | Inserta un entero en una lista ya ordenada. |

**Casos cubiertos / Covered cases:** lista desordenada, ya ordenada, en orden inverso, elementos idénticos, con negativos, un solo elemento y lista vacía.

---

## 📝 Notas de implementación / Implementation Notes

### 🔁 Divergencias idiomáticas respecto al pseudocódigo / Idiomatic divergences from the pseudocode

| Pseudocódigo | Elm | Motivo / Reason |
|--------------|-----|-----------------|
| `swap(arr, i, min_idx)` *in-place* | Se construye una lista nueva | Las listas de Elm son inmutables / Elm lists are immutable |
| Bucles `for` / `while` | Recursión con `case` y pattern matching | Elm no tiene bucles imperativos / Elm has no imperative loops |
| `swapped = false` mutado durante la pasada | `bubblePass` devuelve `(List Int, Bool)` | Equivalente funcional de la bandera; conserva la salida temprana / Functional equivalent of the flag; keeps the early exit |
| `if n <= 1` | Cláusulas `[]` y `[x]` | Pattern matching idiomático / Idiomatic pattern matching |
| `if min_idx != i` (evita el swap) | `selectionSort` no desciende a listas de tamaño ≤ 1 | El ahorro es implícito en el patrón / The saving is implicit in the pattern |
| `selection_sort(arr)` | `selectionSort` | Elm usa `camelCase` / Elm uses `camelCase` |

**ES:** `pickMin` reconstruye la lista de elementos restantes en un orden distinto al original. Es un detalle interno sin efecto observable: esa lista se vuelve a ordenar de inmediato, y el mínimo devuelto sí es el correcto.

**EN:** `pickMin` rebuilds the list of remaining elements in a different order than the original. It is an internal detail with no observable effect: that list is immediately re-sorted, and the returned minimum is correct.

### 🚫 Caso nulo / Null case

**ES:** El caso nulo de la especificación **se omite** porque Elm no tiene `null`/`nil` y `List Int` no puede representar una entrada inválida: no existe tal entrada. Tampoco hay excepciones en Elm, así que el criterio de aceptación «sin lanzar excepciones» se cumple de forma trivial. La justificación está documentada en el encabezado de `tests/NaiveSortTest.elm`.

**EN:** The specification's null case **is omitted** because Elm has no `null`/`nil` and `List Int` cannot represent an invalid input: no such input exists. Elm has no exceptions either, so the «without throwing exceptions» acceptance criterion holds trivially. The rationale is documented in the header of `tests/NaiveSortTest.elm`.

### 📁 Desviación de ubicación y nombres / Location and naming deviation

**ES:** La especificación espera `src/naive_sort.ext` y un `run_tests.ext`. Elm exige que el archivo del módulo se llame igual que el módulo (`NaiveSort.elm`, `PascalCase`), el directorio de pruebas es `tests/` en plural, y **no hay archivo de ejecución**: `elm-test` descubre y ejecuta automáticamente todo lo que haya en `tests/`. La separación `src/` ↔ `tests/` sí se respeta.

**EN:** The specification expects `src/naive_sort.ext` and a `run_tests.ext`. Elm requires the module file to be named after the module (`NaiveSort.elm`, `PascalCase`), the test directory is `tests/` in plural, and there is **no execution file**: `elm-test` automatically discovers and runs everything under `tests/`. The `src/` ↔ `tests/` separation is preserved.

---

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

## 📚 Referencias / References

- [Elm — Syntax](https://elm-lang.org/docs/syntax)
- [elm-explorations/test](https://package.elm-lang.org/packages/elm-explorations/test/latest/)
- [elm-test CLI](https://github.com/elm-explorations/test)

---

*[← Volver a Algorithms Pure](README.md) | [↑ Volver a Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

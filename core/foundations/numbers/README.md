# Numbers — Elm

> **Core Foundations · Unit Test · Numbers**

Implementación en **Elm** de funciones matemáticas clásicas usando tres paradigmas distintos: **recursivo puro**, **acumulador (tail recursion)** e **iterativo con funciones internas** (`let ... in`).

---

## 📦 Módulo `Numbers`

Exporta **15 funciones** públicas organizadas en 3 familias (5 funciones × 3 versiones).

### Funciones implementadas

| Función | Descripción | Firma |
|---------|-------------|-------|
| `sumFirstN` | Suma los primeros `n` números naturales | `Int → Int` |
| `factorial` | Factorial de `n` (`n!`) | `Int → Int` |
| `fibonacci` | Enésimo número de Fibonacci | `Int → Int` |
| `greatestCommonDivisor` | Máximo común divisor (Euclides) | `Int → Int → Int` |
| `leastCommonMultiple` | Mínimo común múltiplo | `Int → Int → Int` |

### Versiones (sufijos)

| Sufijo | Paradigma | Característica |
|--------|-----------|----------------|
| `*Rec` | **Recursivo** (rec) | Llamada recursiva directa, sin estado auxiliar |
| `*Acc` | **Acumulador** (acc) | Tail recursion con parámetro acumulador |
| `*Ite` | **Iterativo** (ite) | Función helper interna con `let … in …` |

---

## 🛠️ Enfoque y construcción / Approach & Build

### 1. `*Rec` — Recursivo puro

La función se llama a sí misma sin mantener estado externo:

```elm
factorialRec : Int -> Int
factorialRec n =
    if n <= 1 then
        1
    else
        n * factorialRec (n - 1)
```

- **Ventaja**: Código legible, refleja la definición matemática.
- **Desventaja**: No es tail-recursive (la pila crece con `n`).

### 2. `*Acc` — Acumulador (tail recursion)

Usa un parámetro extra (`acc`) que acumula el resultado, permitiendo que el compilador optimice la recursión de cola:

```elm
factorialAcc : Int -> Int
factorialAcc n =
    factorialHelp n 1


factorialHelp : Int -> Int -> Int
factorialHelp n acc =
    if n <= 1 then
        acc
    else
        factorialHelp (n - 1) (n * acc)
```

- **Ventaja**: Tail-call optimization (TCO), no crece la pila.
- **Desventaja**: Requiere una función helper separada.

### 3. `*Ite` — Iterativo con función interna (`let ... in`)

La función helper se define **dentro** de la función principal usando `let … in …`, encapsulando completamente el detalle de implementación:

```elm
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
```

- **Ventaja**: Encapsulación total — la función helper no es visible desde fuera del módulo ni siquiera como exportación. Es la forma más cercana a tener un "bloque interno" como `let` en Haskell o funciones anidadas.
- **Desventaja**: No puede exportarse la helper; todo queda autónomo en una sola función.

---

## ⚖️ Comparativa entre versiones

| Aspecto | `*Rec` | `*Acc` | `*Ite` |
|---------|--------|--------|--------|
| Tail recursion | ❌ No | ✅ Sí | ✅ Sí |
| Helper externa | ❌ No | ✅ Sí (`*Help`) | ❌ No (interna) |
| Encapsulación | ⭐ | ⭐⭐ | ⭐⭐⭐ |
| Legibilidad | ⭐⭐⭐ | ⭐⭐ | ⭐⭐ |
| Rendimiento (stack) | ❌ Crece | ✅ Constante | ✅ Constante |

### Caso especial: `gcd`

El algoritmo de Euclides es **naturalmente tail-recursive**, por lo que las tres versiones son casi idénticas:

```elm
-- Rec
gcdRec a b = if b == 0 then a else gcdRec b (modBy b a)

-- Acc (misma lógica, solo cambia el nombre)
gcdAcc a b = if b == 0 then a else gcdAcc b (modBy b a)

-- Ite (función interna con let)
gcdIte a b =
    let loop x y = if y == 0 then x else loop y (modBy y x)
    in loop a b
```

---

## 🧪 Tests

### Archivos de test

| Archivo | Funciones que prueba |
|---------|----------------------|
| `tests/NumbersRecTest.elm` | `sumFirstNRec`, `factorialRec`, `fibonacciRec`, `greatestCommonDivisorRec`, `leastCommonMultipleRec` |
| `tests/NumbersAccTest.elm` | `sumFirstNAcc`, `factorialAcc`, `fibonacciAcc`, `greatestCommonDivisorAcc`, `leastCommonMultipleAcc` |
| `tests/NumbersIteTest.elm` | `sumFirstNIte`, `factorialIte`, `fibonacciIte`, `greatestCommonDivisorIte`, `leastCommonMultipleIte` |

### Ejecutar tests

```bash
cd elm/core/foundations/numbers
elm-test
```

### Tests incluidos (33 totales)

| Función | Casos |
|---------|-------|
| `sumFirstN` | `n = 0` → `0`, `n = 3` → `6` |
| `factorial` | `n = 0` → `1`, `n = 4` → `24` |
| `fibonacci` | `n = 0` → `0`, `n = 1` → `1`, `n = 6` → `8` |
| `greatestCommonDivisor` | `(12, 8)` → `4`, `(7, 5)` → `1` |
| `leastCommonMultiple` | `(8, 6)` → `24`, `(6, 4)` → `12` |

---

## 🚀 Compilación y ejecución / Build & Run

```elm
import Numbers exposing (..)

sumFirstNRec 10       -- 55
factorialAcc 5        -- 120
fibonacciIte 7        -- 13
greatestCommonDivisorRec 48 18  -- 6
leastCommonMultipleAcc 12 15    -- 60
```

---

## � Archivos y estructura / Files & Structure

```
numbers/
├── elm.json              # Configuración del proyecto Elm
├── README.md             # Este archivo
├── src/
│   └── Numbers.elm       # Implementación principal
└── tests/
    ├── NumbersRecTest.elm   # Tests para versión recursiva
    ├── NumbersAccTest.elm   # Tests para versión acumulador
    └── NumbersIteTest.elm   # Tests para versión iterativa
```

---

## 🏗️ Conceptos clave de Elm demostrados

- **Pattern matching** en parámetros (`if … then … else …`)
- **Tail recursion** con acumuladores
- **Funciones internas** con `let … in …`
- **Módulos y exportaciones** (`module … exposing (…)`)
- **Anotaciones de tipo** (`: Int -> Int`)
- **Tests** con `elm-explorations/test`

---

## � Notas de implementación / Implementation Notes

**ES:** La comparativa entre las tres versiones y la sección de conceptos de Elm cierran las decisiones de este módulo: `Rec` sigue la definición matemática, `Acc` lleva acumulador para la recursión de cola —que Elm no garantiza— e `Ite` resuelve con funciones internas `let ... in` sin crecer la pila. Las suites por enfoque y la combinación que aplica están documentadas en la sección de pruebas.

**EN:** The comparison between the three versions and the Elm concepts section close this module's decisions: `Rec` follows the mathematical definition, `Acc` carries an accumulator for tail recursion —which Elm does not guarantee— and `Ite` resolves with internal `let ... in` functions without growing the stack. The per-approach suites and the combination that applies are documented in the tests section.

---

## 📚 Referencias / References

- [Elm — Functions](https://elm-lang.org/docs/syntax#functions)
- [Elm — let expressions](https://elm-lang.org/docs/syntax#let-expressions)
- [elm-explorations/test](https://package.elm-lang.org/packages/elm-explorations/test/latest/)

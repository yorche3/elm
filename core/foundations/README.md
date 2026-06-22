# Foundations — Elm

> **Core Foundations · Elm 0.19.1**

Conjunto de proyectos fundamentales en **Elm** que exploran los conceptos básicos del lenguaje: desde un "Hello, World!" minimalista hasta implementaciones de funciones matemáticas con múltiples paradigmas de recursión y pruebas unitarias.

---

## 📂 Proyectos

| Proyecto | Especificación | Conceptos clave |
|----------|---------------|-----------------|
| [`helloworld/`](helloworld/) | [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | `Platform.worker`, `Debug.log`, compilación a JS |
| [`hellouser/`](hellouser/) | [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | Puertos (`port module`), E/S con Node.js, `Platform.worker` |
| [`unit_test/calculator/`](unit_test/calculator/) | [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | `elm-test`, funciones internas `let ... in`, aritmética con solo `+` y `-` |
| [`numbers/`](numbers/) | — | 3 paradigmas de recursion: `*Rec`, `*Acc`, `*Ite`; 15 funciones matemáticas |

---

## 🧭 Mapa de aprendizaje

```mermaid
graph LR
    A[helloworld] -->|"Platform.worker + Debug.log"| B[hellouser]
    B -->|"Ports + Node.js I/O"| C[unit_test/calculator]
    C -->|"elm-test + let...in"| D[numbers]
    D -->|"Rec / Acc / Ite"| E[...]
```

| Paso | Proyecto | Aprendes |
|------|----------|----------|
| **1** | `helloworld` | Compilar Elm a JS, ejecutar con Node.js, `Platform.worker`, `Debug.log` |
| **2** | `hellouser` | Puertos (`port module`), comunicación bidireccional Elm ↔ JS, `readline` |
| **3** | `unit_test/calculator` | `elm-test`, funciones helper con `let ... in`, operaciones recursivas |
| **4** | `numbers` | Recursión pura, tail recursion con acumulador, funciones internas anidadas, GCD y LCM |

---

## 🛠️ Requisitos comunes

```bash
# Elm CLI
npm install -g elm

# elm-test (para unit_test/calculator y numbers)
npm install -g elm-test
```

---

## 🏗️ Conceptos de Elm demostrados

| Concepto | Proyecto | Descripción |
|----------|----------|-------------|
| `Platform.worker` | `helloworld`, `hellouser` | Programa Elm sin interfaz gráfica (solo lógica) |
| `Debug.log` | `helloworld` | Depuración e impresión en consola |
| `port module` | `hellouser` | Comunicación bidireccional con JavaScript |
| `Cmd` / `Sub` | `hellouser` | Envío y recepción de mensajes asíncronos |
| `let ... in` | `unit_test/calculator`, `numbers` | Funciones helper internas y expresiones locales |
| Tail recursion | `numbers` | Optimización de llamada de cola con acumuladores |
| `elm-test` | `unit_test/calculator`, `numbers` | Pruebas unitarias con `Test`, `Expect`, `describe` |
| `modBy` | `numbers` | Operación módulo para el algoritmo de Euclides |
| Anotaciones de tipo | Todos | `Int -> Int -> Int`, etc. |

---

## 📁 Estructura general

```
foundations/
├── README.md                    # Este archivo
├── helloworld/                  # Hello, World!
│   ├── elm.json
│   ├── src/HelloWorld.elm
│   └── run.js
├── hellouser/                   # Hello, User! (puertos)
│   ├── elm.json
│   ├── src/HelloUser.elm
│   ├── src/Greeting.elm
│   └── run.js
├── unit_test/
│   └── calculator/              # Calculadora con tests
│       ├── elm.json
│       ├── src/Calculator.elm
│       └── tests/CalculatorTest.elm
└── numbers/                     # Funciones matemáticas (3 paradigmas)
    ├── elm.json
    ├── src/Numbers.elm
    └── tests/
        ├── NumbersRecTest.elm
        ├── NumbersAccTest.elm
        └── NumbersIteTest.elm
```

---

## 🚀 Cómo usar cada proyecto

### 1. helloworld — Hello, World!

```bash
cd elm/core/foundations/helloworld
elm make src/HelloWorld.elm --output=hello.js
node run.js
# → Hello, World! from Elm
```

### 2. hellouser — Hello, User! (con puertos)

```bash
cd elm/core/foundations/hellouser
elm make src/HelloUser.elm --output=hello_user.js
node run.js
# → Enter your name: Ada
# → Hello, Ada!
```

### 3. unit_test/calculator — Calculadora con tests

```bash
cd elm/core/foundations/unit_test/calculator
elm-test
# → TEST RUN PASSED  |  Passed: 5
```

### 4. numbers — Funciones matemáticas

```bash
cd elm/core/foundations/numbers
elm-test
# → TEST RUN PASSED  |  Passed: 33
```

---

## 📝 Notas generales sobre Elm

- **Pureza**: Elm es un lenguaje puramente funcional. No hay efectos secundarios directos; todo efecto (E/S, console, DOM) se maneja a través de la arquitectura Elm (`Platform` / `Browser` / `Ports`).
- **Tipado estático**: Todas las funciones tienen tipos inferidos, pero se recomienda anotarlos explícitamente.
- **No hay loops imperativos**: La iteración se logra con recursión, normalmente con funciones helper internas (`let ... in`).
- **Compilación a JS**: `elm make` genera JavaScript que puede ejecutarse en Node.js o en un navegador.
- **`elm-test`**: Framework de testing que usa los módulos `Test`, `Expect`, `describe` y `test`.

---

## 🔗 Referencias

- [Elm Language — Official Guide](https://elm-lang.org/docs)
- [Elm — Platform.worker](https://package.elm-lang.org/packages/elm/core/latest/Platform#worker)
- [Elm — Ports](https://guide.elm-lang.org/interop/ports.html)
- [elm-explorations/test](https://package.elm-lang.org/packages/elm-explorations/test/latest/)

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

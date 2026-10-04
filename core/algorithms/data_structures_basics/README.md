# Data Structures Basics — Elm

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics) en **Elm**, con un enfoque manual y minimalista.

**ES:** Un único `Node` compartido y tres estructuras enlazadas (`LinkedList`, `Stack`, `Queue`) construidas a mano sobre tipos algebraicos inmutables, sin usar `List` ni `Dict` de la biblioteca estándar. Se ejecuta con `elm-test` (`elm-explorations/test`). Elm no tiene verificador de estilo en el catálogo de pruebas.

**EN:** A single shared `Node` and three hand-built linked structures (`LinkedList`, `Stack`, `Queue`) over immutable algebraic data types, without using the standard library's `List` or `Dict`. Run with `elm-test` (`elm-explorations/test`). Elm has no style verifier in the catalogue.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`src/DataStructuresBasics.elm`](src/DataStructuresBasics.elm) | Un módulo con los cuatro tipos (`Node`, `LinkedList`, `Stack`, `Queue`), sus constructores expuestos y sus operaciones / One module with the four types, its exposed constructors and operations |
| [`tests/DataStructuresBasicsTest.elm`](tests/DataStructuresBasicsTest.elm) | Suite de `elm-test`: 4 tests (uno por estructura), 15 casos / `elm-test` suite: 4 tests (one per structure), 15 cases |
| [`elm.json`](elm.json) | Manifiesto del proyecto; `elm-explorations/test` en `test-dependencies` / Project manifest; `elm-explorations/test` under `test-dependencies` |
| `elm-stuff/` | Caché de compilación, excluida por el `.gitignore` del submódulo / Build cache, excluded by the submodule's `.gitignore` |

**Estructura de directorios / Directory layout:**

```text
data_structures_basics/
├── elm.json                              # Manifiesto del proyecto
├── src/
│   └── DataStructuresBasics.elm          # Node, LinkedList, Stack, Queue y sus operaciones
├── tests/
│   └── DataStructuresBasicsTest.elm      # 4 tests (15 casos)
└── README.md                             # Este archivo
```

**Nota de desviación / Deviation note:**

**ES:** la especificación espera `src/data_structures_basics.ext` y, en `test/`, un fichero de casos y un `run_tests.ext`. Aquí el módulo vive en `src/DataStructuresBasics.elm` —`src/` coincide, y el nombre del fichero es el del módulo, como exige Elm— y la suite en `tests/DataStructuresBasicsTest.elm`: Elm descubre `tests/**/*.elm` y **`elm-test` es el runner**, así que no hay `run_tests`.

**EN:** the specification expects `src/data_structures_basics.ext` and, under `test/`, a cases file plus a `run_tests.ext`. Here the module lives in `src/DataStructuresBasics.elm` —`src/` matches, and the file name is the module name, as Elm requires— and the suite in `tests/DataStructuresBasicsTest.elm`: Elm discovers `tests/**/*.elm` and **`elm-test` is the runner**, so there is no `run_tests`.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó con `elm init` y se completó a mano. Elm es inmutable y sin `null`: los enlaces son `Maybe Node`, las operaciones que pueden fallar devuelven `Maybe` y el resto se escribe con **pattern matching** sobre los constructores, no con asignaciones.

**EN:** The project was created with `elm init` and completed by hand. Elm is immutable and null-free: links are `Maybe Node`, fallible operations return `Maybe` and everything else is written with **pattern matching** over the constructors rather than assignments.

```bash
printf 'y\n' | elm init
```

---

## 📄 Configuración clave / Key Configuration

- `elm.json`: aplicación con `src` como único `source-directories`, Elm `0.19.1` y `elm/core` entre las dependencias directas; `elm-explorations/test` `2.2.1` (con `elm/bytes` y `elm/random` como indirectas) en `test-dependencies`, que es lo que permite a `elm-test` arrancar / application with `src` as the only `source-directories`, Elm `0.19.1` and `elm/core` among the direct dependencies; `elm-explorations/test` `2.2.1` (plus `elm/bytes` and `elm/random` indirect) under `test-dependencies`, which is what lets `elm-test` start.
- No hay dependencias de ejecución más allá de la biblioteca estándar / no runtime dependencies beyond the standard library.

---

## 🚀 Compilación y ejecución / Build & Run

```bash
elm make src/DataStructuresBasics.elm --output=/dev/null   # comprobación de tipos / type check
elm-test
```

**Salida real / Actual output:**

```text
$ elm make src/DataStructuresBasics.elm --output=/dev/null
Success!

$ elm-test
TEST RUN PASSED

Duration: 123 ms
Passed:   4
Failed:   0
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Node` (constructor expuesto) | `Int → Maybe Node → Node` | `O(1)` | Es el `init` del contrato; el enlace ausente es `Nothing` / the contract's `init`; absent link is `Nothing` |
| `emptyLinkedList`, `linkedListIsEmpty`, `linkedListSize`, `linkedListHead` | `LinkedList → LinkedList / Bool / Int / Int` | `O(1)` | `init()` es la constante `emptyLinkedList`; `linkedListHead` → `-1` si está vacía / `linkedListHead` → `-1` when empty |
| `linkedListInsertHead` | `Int → LinkedList → LinkedList` | `O(1)` | Antepone una celda / prepends a cell |
| `linkedListInsertTail` | `Int → LinkedList → LinkedList` | **`O(n)`** | Reconstruye el tramo hasta la cola (`appendLast`) / rebuilds the path to the tail |
| `linkedListDelete` | `Int → LinkedList → Maybe LinkedList` | `O(n)` | Elimina la primera aparición; `Nothing` si no está / removes the first occurrence |
| `emptyStack`, `stackIsEmpty`, `stackSize`, `stackPeek` | `Stack → Stack / Bool / Int / Int` | `O(1)` | LIFO sobre el primer campo; `stackPeek` → `-1` si está vacía / LIFO over the first field |
| `stackPush` | `Int → Stack → Stack` | `O(1)` | Apila una celda nueva / pushes a new cell |
| `stackPop` | `Stack → Maybe ( Int, Stack )` | `O(1)` | Devuelve el valor con la pila que queda / returns the value with the remaining stack |
| `emptyQueue`, `queueIsEmpty`, `queueSize`, `queuePeek` | `Queue → Queue / Bool / Int / Int` | `O(1)` | FIFO sobre frente y cola; `queuePeek` → `-1` si está vacía / FIFO over front and rear |
| `queueEnqueue` | `Int → Queue → Queue` | **`O(n)`** | Reconstruye el tramo hasta la cola (`appendLast`) / rebuilds the path to the tail |
| `queueDequeue` | `Queue → Maybe ( Int, Queue )` | `O(1)` | Devuelve el valor con la cola que queda / returns the value with the remaining queue |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Los cuatro tipos en un módulo, con los **constructores expuestos** | Cuatro módulos con tipos opacos y funciones accesoras | Elm agrupa los tipos de un mismo dominio en un módulo, y el constructor es lo que da el `init`, la lectura del valor y del enlace sin añadir funciones / Elm groups a domain's types in one module, and the constructor provides `init` plus value and link reading with no extra functions |
| `Maybe` en las operaciones que extraen y `Int` con `-1` en las que solo observan | `Maybe` en todas | `stackPeek`/`queuePeek`/`linkedListHead` no devuelven ninguna estructura nueva, así que un centinela documentado basta; las que extraen llevan el valor junto a la estructura / the observing operations carry no new structure, so a documented sentinel suffices; the removing ones carry the value with the structure |
| `tail`/`rear` se mantienen, pero la inserción por el final **no** se apoya en ellos | Enlazar desde el último nodo | Con nodos inmutables la copia con el enlace nuevo queda inalcanzable desde la cabeza: hay que reconstruir el tramo / with immutable nodes the copy with the new link is unreachable from the head, so the path must be rebuilt |
| Un test por estructura | Un test por caso | Los casos de la especificación son pasos sucesivos sobre la misma instancia lógica / the spec's cases are successive steps on one logical instance |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `Node.init(value)` y `init()` tras declarar | El constructor expuesto (`Node value Nothing`) y las constantes `emptyLinkedList`, `emptyStack`, `emptyQueue` | Elm no tiene instancias sin construir, y el valor vacío de una estructura es una constante, no una función / Elm has no unbuilt instances, and an empty structure is a constant, not a function |
| `get_value()`, `get_next()`, `set_next()` | Pattern matching sobre `Node value next` y construcción de `Node value (Just next)` | El tipo es un ADT: sus constructores forman parte de la API y no hacen falta accesores / the type is an ADT: its constructors are part of the API and accessors are unnecessary |
| Ausencia de enlace | `Maybe Node` (`Nothing`) | Representación nativa del lenguaje, la que la especificación permite / native language representation, as the specification allows |
| `insert_tail` y `enqueue` en **`O(1)`** | **`O(n)`**: reconstruyen el tramo hasta la cola (`appendLast`) | El enlace del último nodo no se puede modificar; se devuelve una copia nueva de cada nodo del tramo / the last node's link cannot be modified; a new copy of each node on the path is returned |
| `delete`, `pop`, `dequeue` exponen el resultado por `out` | Devuelven `Maybe` con el valor y la estructura nueva | En un lenguaje inmutable el resultado viaja con la estructura nueva / in an immutable language the result travels with the new structure |
| `get_head`, `is_empty`, `insert_head` (`snake_case`) | `linkedListHead`, `linkedListIsEmpty`, `linkedListInsertHead` (`camelCase`) | Convención de Elm, y el prefijo distingue la estructura que se maneja / Elm convention, and the prefix states which structure is handled |
| `test/data_structures_basics_test.ext` y `test/run_tests.ext` | `tests/DataStructuresBasicsTest.elm`; `elm-test` es el runner | Convención de Elm: carpeta `tests/` y un módulo por suite; ver la nota de desviación / Elm convention: `tests/` folder and one module per suite; see the deviation note |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `linkedListHead` | Lista vacía / empty list | `-1` | `linkedListHead emptyLinkedList` → `-1` |
| `linkedListDelete` | Valor ausente / absent value | `Nothing` (éxito / success: `Just` con la lista nueva / with the new list) | `linkedListDelete 99 lista` → `Nothing` |
| `stackPeek`, `queuePeek` | Estructura vacía / empty structure | `-1` | `stackPeek emptyStack` → `-1` |
| `stackPop`, `queueDequeue` | Estructura vacía / empty structure | `Nothing` | `stackPop emptyStack` → `Nothing` |
| `Node` (enlace ausente / absent link) | Último nodo / last node | `Nothing` | `Node 10 Nothing` |
| Inserciones / insertions | Sin límite de capacidad / no capacity limit | No aplica / Not applicable | — |
| Entrada nula / null input | Las operaciones reciben `Int` / operations take `Int` | No representable / Not representable | Caso omitido: Elm no tiene `null` y la especificación no define entradas nulas / omitted: Elm has no `null` and the spec defines no null inputs |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Node: inicializar y observar valor/enlace / initialize and observe value/link | Sí | `Node` (`DataStructuresBasicsTest.elm`) | |
| Node: enlazar y recorrer / link and traverse | Sí | `Node` | |
| LinkedList: estado vacío / empty state | Sí | `LinkedList` | `True`, `0`, `-1` |
| LinkedList: insertar por ambos extremos / insert at both ends | Sí | `LinkedList` | `5, 10, 20, 10` |
| LinkedList: eliminar la primera aparición / delete first occurrence | Sí | `LinkedList` | `5, 20, 10`; tamaño `3` |
| LinkedList: valor ausente / absent value | Sí | `LinkedList` | |
| LinkedList: vaciar / empty the list | Sí | `LinkedList` | |
| Stack: estado vacío y extracción fallida / empty state and failed removal | Sí | `Stack` | |
| Stack: LIFO y `peek` no mutante / LIFO and non-mutating `peek` | Sí | `Stack` | |
| Stack: extracción y reutilización / removal and reuse | Sí | `Stack` | `30, 40, 20, 10` |
| Stack: vacío tras extracción / empty after removal | Sí | `Stack` | |
| Queue: estado vacío y extracción fallida / empty state and failed removal | Sí | `Queue` | |
| Queue: FIFO y `peek` no mutante / FIFO and non-mutating `peek` | Sí | `Queue` | |
| Queue: extracción y reutilización / removal and reuse | Sí | `Queue` | `10, 20, 30, 40` |
| Queue: vacío tras extracción / empty after removal | Sí | `Queue` | |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| `linkedListInsertTail` y `queueEnqueue` son `O(n)`; la especificación promete `O(1)` / `O(n)` instead of the promised `O(1)` | La cota de inserción por el final no se cumple / the tail-insertion bound is not met | Declarado en _Adaptaciones idiomáticas_. Con el `Node` inmutable que exige la especificación no hay mutación del enlace anterior; una cola de dos listas daría `O(1)` amortizado, pero la especificación prohíbe sustituir la estructura por colecciones estándar / declared above; a two-list queue would be `O(1)` amortised, but the spec forbids replacing the structure |
| `appendLast`, `removeFirst` y `lastNode` no están en posición de cola / not in tail position | Pila de llamadas `O(n)` en listas largas / `O(n)` call stack on long lists | La especificación no fija cota de pila y la reconstrucción es recursiva por necesidad; se puede reescribir con acumulador / the spec sets no stack bound and the rebuild is recursive by necessity; it can be rewritten with an accumulator |
| Solo `Int` (sin parámetros de tipo) / `Int` only, no type parameters | `-1` no es almacenable sin confundirse con el fallo / `-1` cannot be stored without clashing with the indicator | Los valores de prueba son enteros positivos, como fija la especificación / tests use positive integers per the spec |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Un único `Node` lo comparten las tres estructuras; `Stack` guarda su tope y `Queue` su frente y su cola, sin delegar en `LinkedList` ni en `List`. **EN:** The three structures share a single `Node`; `Stack` keeps its top and `Queue` keeps its front and rear, with no delegation to `LinkedList` or `List`.
- **ES:** Elm no tiene excepciones: el fallo es un valor, `Nothing` o `-1`, y ninguna operación lo lanza. El caso nulo no existe porque las operaciones reciben `Int`. **EN:** Elm has no exceptions: failure is a value, `Nothing` or `-1`, and no operation throws. There is no null case because operations take `Int`.
- **ES:** `tail` y `rear` se mantienen para que el contrato conserve su estado, pero la inserción por el final reconstruye el tramo desde la cabeza, que es la única forma de enlazar con nodos inmutables. **EN:** `tail` and `rear` are kept so the contract preserves its state, but tail insertion rebuilds the path from the head, the only way to link with immutable nodes.
- **ES:** Tras un borrado, `linkedListDelete` recalcula la cola con `lastNode` para no dejar el puntero en una celda retirada. **EN:** After a removal, `linkedListDelete` recomputes the tail with `lastNode` so the pointer never stays on a removed cell.
- **ES:** `Expect.all` de `elm-test` informa solo del primer caso que falla de cada estructura. **EN:** `elm-test`'s `Expect.all` reports only the first failing case per structure.
- **ES:** Sin imports hacia otros módulos del roadmap. **EN:** No imports from other roadmap modules.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README. / The native suite ran and its real output is copied here.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_. / Every spec case has its row in _Test coverage_.
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_. / Every deviation from the pseudocode or expected location is under _Idiomatic adaptations_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_. / Every operation with a possible failure is under _Failure indicators_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas. / No author absolute paths, credentials or invented output.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe. / Relative links resolve inside the repository and the document is bilingual.
- [x] Ninguna sección repite lo que ya dice la especificación. / No section repeats what the specification already says.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`06_Data_Structures_Basics.md`](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics) |
| Módulo homologado del lenguaje / Homologated module | [`elm/core/algorithms/naive_sort/`](../naive_sort/) |
| Documentación oficial del lenguaje / Language official docs | [Elm — guía oficial / official guide](https://guide.elm-lang.org/) |

---

*[← Volver a Algoritmos Puros](../README.md) | [↑ Volver a Core](../../README.md)*

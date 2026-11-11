# Data Structures Advanced — Elm

Implementación de la especificación [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced) en **Elm**, con un enfoque manual y minimalista.

**ES:** Nodo con solo el valor (`Node`), nodo derivado para árbol binario (`TreeNode`), árbol binario de búsqueda (`BinaryTree`), nodo de vértice interno (`GraphNode`) y grafo dirigido (`Graph`) con registro enlazado canónico e inserción ordenada de adyacencias sin delegar en estructuras hash o diccionarios de biblioteca. Se ejecuta con `elm-test` (`elm-explorations/test`).

**EN:** Value-only base node (`Node`), derived tree node (`TreeNode`), binary search tree (`BinaryTree`), internal vertex node (`GraphNode`) and directed graph (`Graph`) with a canonical linked registry and manual sorted adjacency insertion without delegating to standard library hash maps or sets. Run with `elm-test` (`elm-explorations/test`).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`src/DataStructuresAdvanced.elm`](src/DataStructuresAdvanced.elm) | Módulo principal con los tipos (`Node`, `TreeNode`, `BinaryTree`, `GraphNode`, `Graph`) y sus operaciones / Main module defining all types and contract operations |
| [`tests/DataStructuresAdvancedTest.elm`](tests/DataStructuresAdvancedTest.elm) | Suite de pruebas con `elm-test`: 3 grupos (`TreeNode`, `BinaryTree`, `Graph`), 23 tests / Test suite with `elm-test`: 3 groups (`TreeNode`, `BinaryTree`, `Graph`), 23 tests |
| [`elm.json`](elm.json) | Manifiesto del proyecto; `elm-explorations/test` en `test-dependencies` / Project manifest; `elm-explorations/test` under `test-dependencies` |
| `elm-stuff/` | Caché de compilación excluida por el `.gitignore` del submódulo / Build cache excluded by submodule `.gitignore` |

**Estructura de directorios / Directory layout:**

```text
data_structures_advanced/
├── elm.json                              # Manifiesto del proyecto / Project manifest
├── src/
│   └── DataStructuresAdvanced.elm        # Node, TreeNode, BinaryTree, GraphNode, Graph
├── tests/
│   └── DataStructuresAdvancedTest.elm    # 3 tests suites (23 tests)
└── README.md                             # Este archivo / This file
```

**Nota de desviación / Deviation note:**

**ES:** La especificación espera `src/data_structures_advanced.ext` y, en `test/`, un archivo de casos más `run_tests.ext`. En Elm, el módulo reside en `src/DataStructuresAdvanced.elm` (en `PascalCase`, matching the module declaration) y las pruebas en `tests/DataStructuresAdvancedTest.elm`. `elm-test` es el test runner estándar que auto-descubre las pruebas bajo `tests/`, por lo que no se requiere `run_tests.ext`.

**EN:** The specification expects `src/data_structures_advanced.ext` and, under `test/`, a cases file plus `run_tests.ext`. In Elm, the module lives at `src/DataStructuresAdvanced.elm` (in `PascalCase`, matching the module declaration) and the suite at `tests/DataStructuresAdvancedTest.elm`. `elm-test` is the standard runner auto-discovering tests under `tests/`, making a separate `run_tests.ext` unnecessary.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se configuró con `elm init` y dependencias de prueba mínimas (`elm-explorations/test`). En Elm, todas las estructuras son inmutables y no existe `null`. Las referencias ausentes se modelan con `Maybe`, y la herencia del nodo base se realiza mediante composición (valor embebido `Node`), sin validaciones en la base.

**EN:** The project was configured with `elm init` and minimal test dependencies (`elm-explorations/test`). In Elm, all data structures are immutable and `null` does not exist. Absent links are modeled using `Maybe`, and base node reuse is achieved through composition (embedded `Node` value), keeping the base free of validations.

---

## 📄 Configuración clave / Key Configuration

- `elm.json`: aplicación Elm 0.19.1 con `src` en `source-directories`; dependencias directas mínimas (`elm/core`) y dependencias de prueba (`elm-explorations/test` 2.2.1 junto con `elm/bytes` y `elm/random`).
- Sin dependencias de terceros en tiempo de ejecución.

---

## 🚀 Compilación y ejecución / Build & Run

```bash
elm make src/DataStructuresAdvanced.elm --output=/dev/null
elm-test
```

**Salida real / Actual output:**

```text
$ elm make src/DataStructuresAdvanced.elm --output=/dev/null
Compiling ...             Success!

$ elm-test
CompilingCompiling > Starting tests

elm-test 0.19.1-revision17
--------------------------

Running 23 tests. To reproduce these results, run: elm-test --fuzz 100 --seed 277986165981216


TEST RUN PASSED

Duration: 124 ms
Passed:   23
Failed:   0
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `nodeValue` | `Node → Int` | `O(1)` | Extrae el valor de la base local `Node` / Extracts value from local base `Node` |
| `treeNodeInit` | `Int → TreeNode` | `O(1)` | Crea un nodo con valor embebido y ambos enlaces en `Nothing` / Creates tree node with embedded value and both links absent |
| `treeNodeValue` | `TreeNode → Int` | `O(1)` | Accede al valor del nodo / Reads node value |
| `treeNodeLeft`, `treeNodeRight` | `TreeNode → Maybe TreeNode` | `O(1)` | Observa el hijo izquierdo/derecho (`Nothing` si ausente) / Observes left/right child |
| `treeNodeWithLeft`, `treeNodeWithRight` | `Maybe TreeNode → TreeNode → TreeNode` | `O(1)` | Retorna copia inmutable con el enlace actualizado / Returns immutable copy with updated child link |
| `emptyBinaryTree` | `BinaryTree` | `O(1)` | Árbol vacío utilizable (`root = Nothing`, `count = 0`) / Usable empty BST |
| `binaryTreeInsert` | `Int → BinaryTree → BinaryTree` | `O(h)` | Inserta preservando invariante ABB; duplicado no incrementa tamaño / BST insert; duplicates do not grow size |
| `binaryTreeContains` | `Int → BinaryTree → Bool` | `O(h)` | Búsqueda por ramas del ABB; no recorre linealmente / BST traversal lookup |
| `binaryTreeIsEmpty` | `BinaryTree → Bool` | `O(1)` | Comprueba si `count == 0` / Checks if empty |
| `binaryTreeSize` | `BinaryTree → Int` | `O(1)` | Retorna el número de elementos únicos / Returns distinct value count |
| `emptyGraph` | `Graph` | `O(1)` | Grafo vacío utilizable (`vertices = Nothing`, contadores en 0) / Usable empty directed graph |
| `graphAddVertex` | `Int → Graph → Graph` | `O(V)` | Inserta vértice si no existe en el registro enlazado; duplicado es idempotente / Registers vertex in linked list if missing |
| `graphAddEdge` | `Int → Int → Graph → Maybe Graph` | `O(V + d(u))` | Verifica ambos vértices; inserta vecino ordenado; `Nothing` si falta extremo / Checks endpoints, inserts sorted neighbor; `Nothing` if missing |
| `graphHasEdge` | `Int → Int → Graph → Bool` | `O(V + d(u))` | Búsqueda de `u` y escaneo lineal de adyacencia ordenada / Looks up `u` and checks ordered neighbor list |
| `graphGetNeighbors` | `Int → Graph → Maybe (List Int)` | `O(V)` | Retorna copia inmutable compartida de la adyacencia; `Nothing` si falta vértice / Returns neighbors or `Nothing` if missing |
| `graphIsEmpty` | `Graph → Bool` | `O(1)` | Comprueba si `vertex_total == 0` / Checks if graph has no vertices |
| `graphVertexCount` | `Graph → Int` | `O(1)` | Retorna cantidad de vértices / Returns vertex count |
| `graphEdgeCount` | `Graph → Int` | `O(1)` | Retorna cantidad de aristas / Returns edge count |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Composición con tipo `Node` embebido | Tipos desacoplados sin tipo `Node` compartido | Satisface el contrato de reutilizar la base `Node(value)` sin enlaces ni validaciones en un lenguaje sin herencia / Meets contract of reusing base `Node(value)` without links or validations in a language without OOP inheritance |
| Registro canónico de vértices enlazado (`GraphNode` con `Maybe GraphNode`) | Usar `Dict` o `Set` de la biblioteca estándar | La especificación prohíbe delegar el registro en diccionarios o árboles de biblioteca; el registro manual preserva la cota `O(V)` / Manual linked registry adheres to explicit manual implementation requirement |
| Inserción ordenada manual con función `insertSorted` | Usar `List.sort` tras inserción | Mantiene los vecinos ordenados en `O(d(u))` directamente al insertar aristas, sin incurrir en `O(d(u) log d(u))` ni ordenar en lectura / Maintains sorted adjacency in `O(d(u))` without sorting on reads |
| `graphAddEdge` devuelve `Maybe Graph` | Devolver el mismo grafo sin cambios al fallar | Permite distinguir claramente éxito de fallo por extremos faltantes sin recurrir a excepciones o estados inconsistentes / Clearly distinguishes failure from success when endpoints are missing |
| Retorno de `List Int` compartida en `graphGetNeighbors` | Copia defensiva explícita | En Elm las listas son inmutables y persistentes por diseño, por lo que compartir la lista no compromete el aislamiento / Immutable persistent lists make sharing inherently safe without extra copies |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `Node` como clase base abstracta y herencia (`extends Node`) | Composición: `Node Int` embebido dentro de `TreeNode` y `GraphNode` | Elm no tiene orientación a objetos ni clases herederas; la composición con tipos algebraicos es la forma idiomática / Elm lacks OOP classes; algebraic data type composition is standard |
| Métodos mutantes `set_left`, `set_right` | `treeNodeWithLeft`, `treeNodeWithRight` retornan un nuevo `TreeNode` | En un entorno funcional puro los tipos son inmutables; las actualizaciones devuelven nuevas copias / Pure functional immutability requires returning updated copies |
| Mutabilidad de `BinaryTree.insert` y `Graph.add_vertex` | Retornan una nueva instancia de `BinaryTree` / `Graph` | Preserva la inmutabilidad y la persistencia estructural del lenguaje / Preserves immutability and structural persistence |
| Métodos mutantes `add_edge` con retorno de código de error/booleano | `graphAddEdge` devuelve `Maybe Graph` (`Nothing` ante extremo ausente) | Modela la falla en ausencia de excepciones y combina el nuevo estado con el indicador de éxito / Idiomatic Elm error modeling with `Maybe` |
| Entrada nula / Null inputs | No representable / Not representable | Elm no tiene `null` ni `nil`; el sistema de tipos garantiza que los enteros sean siempre válidos / Elm has no null values; type system guarantees non-null Int |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `treeNodeLeft`, `treeNodeRight` | Hijo ausente / Absent child | `Nothing` | `treeNodeLeft (treeNodeInit 10)` → `Nothing` |
| `binaryTreeContains` | Valor no presente / Absent value | `False` | `binaryTreeContains 99 emptyBinaryTree` → `False` |
| `graphAddEdge` | Extremo `u` o `v` inexistente / Missing endpoint | `Nothing` | `graphAddEdge 10 99 graph` → `Nothing` |
| `graphHasEdge` | Arista ausente o extremos inexistentes / Missing edge or endpoint | `False` | `graphHasEdge 10 99 graph` → `False` |
| `graphGetNeighbors` | Vértice inexistente / Missing vertex | `Nothing` | `graphGetNeighbors 99 graph` → `Nothing` |
| Entrada nula / Null input | No aplica / Not applicable | No representable / Not representable | Tipos garantizados en compilación; Elm no posee `null` / Compile-time guarantee; Elm lacks `null` |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| TreeNode: Crear un nodo de árbol / Create a tree node | Sí | `TreeNode: Create a tree node` | Verifica `treeNodeValue` = 10 / Verifies value 10 |
| TreeNode: Enlaces iniciales ausentes / Absent initial links | Sí | `TreeNode: Absent initial links` | Verifica `treeNodeLeft` y `treeNodeRight` = `Nothing` |
| TreeNode: Enlazar dos hijos / Link two children | Sí | `TreeNode: Link two children` | Conecta hijos 20 y 30 con `treeNodeWithLeft` / `WithRight` |
| TreeNode: Recorrer cada enlace / Traverse each link | Sí | `TreeNode: Traverse each link` | Verifica enlaces de los hijos en `Nothing` |
| TreeNode: Desenlazar hijos / Unlink children | Sí | `TreeNode: Unlink children` | Desvincula hijo izquierdo y luego derecho con `Nothing` |
| TreeNode: Adaptación inmutable / Immutable adaptation | Sí | `TreeNode: Immutable adaptation` | Confirma que actualizar el nodo produce una copia y no muta el original |
| BinaryTree: Crear vacío / Create empty | Sí | `BinaryTree: Create empty` | `is_empty` True, `size` 0, `contains 50` False |
| BinaryTree: Insertar la raíz / Insert the root | Sí | `BinaryTree: Insert the root` | `size` 1, no vacío, `contains 50` True |
| BinaryTree: Insertar menor y mayor / Insert lower and higher | Sí | `BinaryTree: Insert lower and higher` | Inserta 50, 30, 70; tamaño 3 y los 3 presentes |
| BinaryTree: Ramas de varios niveles / Multilevel branches | Sí | `BinaryTree: Multilevel branches` | Inserta 50, 30, 70, 20, 40; tamaño 5 y todos presentes |
| BinaryTree: Valor ausente en árbol no vacío / Missing value in nonempty tree | Sí | `BinaryTree: Missing value in nonempty tree` | `contains 99` False, tamaño 1 |
| BinaryTree: Duplicado idempotente / Idempotent duplicate | Sí | `BinaryTree: Idempotent duplicate` | Inserta 30 duplicado; tamaño permanece en 3 |
| BinaryTree: Inserciones ordenadas / Ordered insertions | Sí | `BinaryTree: Ordered insertions` | Inserta 20..70 en orden; tamaño 5 y todos presentes |
| Graph: Crear vacío / Create empty | Sí | `Graph: Create empty` | `is_empty` True, 0 vértices, 0 aristas, `has_edge` y `get_neighbors` fallan |
| Graph: Vértice aislado / Isolated vertex | Sí | `Graph: Isolated vertex` | 1 vértice, 0 aristas, `get_neighbors` = `Just []` |
| Graph: Etiquetas no consecutivas y arista dirigida / Nonconsecutive labels and directed edge | Sí | `Graph: Nonconsecutive labels and directed edge` | Registra 10, 70; arista (10,70); reversa falla; 2 vértices, 1 arista |
| Graph: Vértice duplicado conserva adyacencia / Duplicate vertex preserves adjacency | Sí | `Graph: Duplicate vertex preserves adjacency` | Re-añade 10 tras arista; vecinos siguen `[30]` |
| Graph: Arista duplicada / Duplicate edge | Sí | `Graph: Duplicate edge` | Añade (10,30) dos veces; conteo aristas 1 y vecinos `[30]` |
| Graph: Extremo inexistente sin mutación / Missing endpoint without mutation | Sí | `Graph: Missing endpoint without mutation` | Fallos en 4 combinaciones con 98/99; estado inalterado |
| Graph: Vecinos ordenados y contadores / Sorted neighbours and counts | Sí | `Graph: Sorted neighbours and counts` | Vecinos ordenados crecientes `[30,50,70]` y conteos exactos |
| Graph: Consulta de arista ausente / Missing-edge query | Sí | `Graph: Missing-edge query` | Vértices 10 y 30 sin arista; `has_edge` False |
| Graph: Vecinos de vértice inexistente / Neighbours of missing vertex | Sí | `Graph: Neighbours of missing vertex` | `get_neighbors 99` devuelve `Nothing` (distinto de `Just []`) |
| Graph: Bucle y duplicado / Self-loop and duplicate | Sí | `Graph: Self-loop and duplicate` | Arista bucle (10,10) duplicada; 1 vértice, 1 arista, vecinos `[10]` |
| Graph: Aislamiento del resultado de vecinos / Neighbour-result isolation | Omitido | `Graph` | Omitido: En Elm las listas son inmutables; no es posible mutar la secuencia devuelta exteriormente |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Búsqueda de vértices y actualización en `O(V)` / `O(V)` vertex lookup & update | Inserción de aristas escala linealmente con el número de vértices | Exigencia contractual del módulo para evitar colecciones hash o indexadas de biblioteca |
| Inmutabilidad total de secuencias / Total sequence immutability | Mutación externa de vecinos devueltos no es testeable | Representación nativa inmutable garantiza aislamiento sin copias manuales defensivas |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** La base `Node` almacena únicamente el valor entero `Node Int`. `TreeNode` y `GraphNode` lo contienen por composición pura, sin validaciones en la base.
- **ES:** Inexistencia de `null`: Elm no posee referencias nulas. Las ausencias se manejan idiomáticamente con el tipo `Maybe`. En `Graph`, un vértice sin conexiones tiene vecinos `Just []`, mientras que un vértice inexistente retorna `Nothing`.
- **ES:** `BinaryTree` mantiene su invariante de búsqueda en inserción recursiva y pertenencia; los duplicados no incrementan el tamaño del árbol.
- **ES:** El grafo implementa su propio registro canónico de vértices mediante una lista enlazada manual (`GraphNode` referenciando opcionalmente al siguiente `GraphNode`), y la adyacencia se inserta ordenada ascendentemente mediante `insertSorted` sin recurrir a ordenación en tiempo de consulta.
- **ES:** Trazabilidad de pruebas: La suite en `tests/DataStructuresAdvancedTest.elm` cubre las 3 abstracciones con 23 casos individuales ejecutados sobre `elm-test`.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README. / The native suite ran and its real output is copied here.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón). / Every spec case has its row in _Test coverage_.
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_. / Every deviation from the pseudocode or expected location is under _Idiomatic adaptations_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_. / Every operation with a possible failure is under _Failure indicators_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas. / No author absolute paths, credentials or invented output.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe. / Relative links resolve inside the repository and the document is bilingual.
- [x] Ninguna sección repite lo que ya dice la especificación. / No section repeats what the specification already says.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`elm/core/algorithms/data_structures_basics/`](../data_structures_basics/) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`elm/core/foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [Elm — guía oficial / official guide](https://guide.elm-lang.org/) |

---

*[← Volver a Algoritmos Puros](../README.md) | [↑ Volver a Core](../../README.md)*

# Hello, User! — Elm

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **Elm**, compilado con **elm make** y ejecutado con **Node.js**.

Lee un nombre desde la entrada estándar y saluda al usuario, usando **puertos (ports)** para la comunicación bidireccional entre Elm y JavaScript.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`elm.json`](elm.json) | Manifiesto del proyecto Elm. |
| [`src/HelloUser.elm`](src/HelloUser.elm) | Programa Elm con puertos para E/S. |
| [`src/Greeting.elm`](src/Greeting.elm) | Módulo auxiliar con función `greet`. |
| [`run.js`](run.js) | Script Node.js que conecta la terminal con los puertos de Elm. |

**Estructura de directorios esperada:**

```text
hellouser/
├── elm.json                   # Manifiesto del proyecto
├── src/
│   ├── HelloUser.elm          # Programa principal con puertos
│   └── Greeting.elm           # Módulo auxiliar
├── run.js                     # Script de ejecución (Node.js)
└── README.md                  # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce conceptos avanzados de Elm:

1. **Puertos (ports)** — mecanismo de Elm para comunicarse con JavaScript. Se definen con `port module` y permiten enviar (`Cmd`) y recibir (`Sub`) datos.
2. **Arquitectura Elm** — `init`, `update`, `subscriptions` como programa `Platform.worker` (sin HTML).
3. **Módulos separados** — la función `greet` está en un módulo independiente `Greeting`.

El flujo es:
1. `run.js` muestra el prompt y lee el nombre con `readline`.
2. Envía el nombre a Elm vía `app.ports.receiveName.send(name)`.
3. Elm recibe el nombre, genera el saludo con `greet`, y lo envía de vuelta vía `port sendGreeting`.
4. `run.js` recibe el saludo y lo imprime en la consola.

**EN:** This program introduces advanced Elm concepts:

1. **Ports** — Elm's mechanism to communicate with JavaScript. Declared with `port module`, they allow sending (`Cmd`) and receiving (`Sub`) data.
2. **Elm Architecture** — `init`, `update`, `subscriptions` as a `Platform.worker` program (no HTML).
3. **Separate modules** — the `greet` function is in an independent `Greeting` module.

The flow is:
1. `run.js` shows the prompt and reads the name with `readline`.
2. Sends the name to Elm via `app.ports.receiveName.send(name)`.
3. Elm receives the name, generates the greeting with `greet`, and sends it back via `port sendGreeting`.
4. `run.js` receives the greeting and prints it to the console.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `src/Greeting.elm` — Módulo auxiliar

**ES:** Función pura `greet` que concatena el nombre con el saludo usando `++`.

**EN:** Pure function `greet` that concatenates the name with the greeting using `++`.

```elm
module Greeting exposing (greet)

greet : String -> String
greet name =
    "Hello, " ++ name ++ "!"
```

### `src/HelloUser.elm` — Programa principal

**ES:** Módulo con puertos (`port module`) que define la comunicación bidireccional con JavaScript.

**EN:** Port module (`port module`) that defines bidirectional communication with JavaScript.

```elm
port module HelloUser exposing (main)

import Platform
import Greeting exposing (greet)

port sendGreeting : String -> Cmd msg
port receiveName : (String -> msg) -> Sub msg

type alias Model = { name : Maybe String, greeting : Maybe String }
type Msg = NameReceived String | SendGreeting

-- ... init, update, subscriptions con Platform.worker
```

### `run.js` — Script de ejecución

**ES:** Conecta Node.js con Elm usando `readline` para la terminal y los puertos de Elm para la comunicación.

**EN:** Connects Node.js with Elm using `readline` for the terminal and Elm ports for communication.

```javascript
const app = Elm.HelloUser.init();

app.ports.sendGreeting.subscribe(function(greeting) {
    console.log(greeting);
    rl.close();
});

rl.question('Enter your name: ', function(name) {
    app.ports.receiveName.send(name);
});
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Elm y Node.js instalados

```bash
npm install -g elm
```

### Compilar y ejecutar

```bash
cd core/foundations/hellouser

# Compilar Elm a JavaScript
elm make src/HelloUser.elm --output=hello_user.js

# Ejecutar con Node.js
node run.js
```

**Salida esperada / Expected output:**

```text
Enter your name: Ada
Hello, Ada!
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Los puertos (`port`) son el único mecanismo de Elm para efectos secundarios. Todo el código Elm sigue siendo puro; la E/S real ocurre en JavaScript.
- **EN:** Ports are Elm's only mechanism for side effects. All Elm code remains pure; the actual I/O happens in JavaScript.
- **ES:** `Platform.worker` permite ejecutar Elm sin un navegador. Es ideal para programas que solo procesan datos y se comunican vía puertos.
- **EN:** `Platform.worker` allows running Elm without a browser. It's ideal for programs that only process data and communicate via ports.
- **ES:** La concatenación en Elm usa `++` (no `+`). `++` funciona con strings y listas.
- **EN:** Concatenation in Elm uses `++` (not `+`). `++` works with strings and lists.
- **ES:** `run.js` usa `readline` de Node.js para la entrada de terminal, y los puertos de Elm para la comunicación.
- **EN:** `run.js` uses Node.js's `readline` for terminal input, and Elm's ports for communication.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

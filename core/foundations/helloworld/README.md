# Hello, World! — Elm

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Elm**, compilado con **elm make** y ejecutado con **Node.js**.

Elm es un lenguaje funcional puro compilado a JavaScript. No tiene E/S estándar directa; la salida se produce a través del depurador (`Debug.log`) o renderizando HTML en un navegador.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`elm.json`](elm.json) | Manifiesto del proyecto Elm (dependencias, versión). |
| [`src/HelloWorld.elm`](src/HelloWorld.elm) | Código fuente Elm: módulo `HelloWorld` con `main`. |
| [`run.js`](run.js) | Script Node.js que ejecuta el JavaScript compilado. |

**Estructura de directorios esperada:**

```text
helloworld/
├── elm.json                   # Manifiesto del proyecto
├── src/
│   └── HelloWorld.elm         # Código fuente Elm
├── run.js                     # Script de ejecución (Node.js)
└── README.md                  # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **Elm** como lenguaje funcional puro. A diferencia de otros lenguajes, Elm no tiene una consola interactiva tradicional; su salida principal es HTML en un navegador. Para este ejemplo minimalista:

- **`Debug.log`** se usa para imprimir el mensaje en la consola (solo para desarrollo; `Debug` no debe usarse en producción).
- **`Platform.worker`** es el tipo de programa Elm sin interfaz gráfica (solo lógica), ideal para scripts sin HTML.
- **Compilación**: `elm make src/HelloWorld.elm --output=hello.js` genera JavaScript.
- **Ejecución**: `node run.js` carga el JS compilado e inicializa el programa Elm.

**EN:** This project uses **Elm** as a pure functional language. Unlike other languages, Elm has no traditional interactive console; its main output is HTML in a browser. For this minimal example:

- **`Debug.log`** is used to print the message to the console (development only; `Debug` should not be used in production).
- **`Platform.worker`** is the Elm program type without a graphical interface (logic only), ideal for scripts without HTML.
- **Compilation**: `elm make src/HelloWorld.elm --output=hello.js` generates JavaScript.
- **Execution**: `node run.js` loads the compiled JS and initializes the Elm program.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `elm.json` — Manifiesto del proyecto

**ES:** Define el tipo de proyecto (`application`), versión de Elm, directorios fuente y dependencias.

**EN:** Defines the project type (`application`), Elm version, source directories and dependencies.

```json
{
    "type": "application",
    "source-directories": ["src"],
    "elm-version": "0.19.1",
    "dependencies": {
        "direct": {
            "elm/browser": "1.0.2",
            "elm/core": "1.0.5",
            "elm/html": "1.0.1"
        }
    }
}
```

### `src/HelloWorld.elm` — Implementación

**ES:** Módulo Elm que exporta `main`. Usa `Platform.worker` para un programa sin interfaz gráfica y `Debug.log` para imprimir el saludo en la consola.

**EN:** Elm module that exports `main`. Uses `Platform.worker` for a program without a graphical interface and `Debug.log` to print the greeting to the console.

```elm
module HelloWorld exposing (main)

import Platform
import Debug

main : Program () () ()
main =
    let
        _ = Debug.log "Hello, World! from Elm" ()
    in
    Platform.worker
        { init = \() -> ( (), Cmd.none )
        , update = \_ _ -> ( (), Cmd.none )
        , subscriptions = \_ -> Sub.none
        }
```

| Elemento | Propósito |
|----------|-----------|
| `Debug.log` | Función de depuración que imprime un valor en la consola y lo retorna |
| `Platform.worker` | Tipo de programa Elm sin renderizado HTML (solo lógica) |
| `init`, `update`, `subscriptions` | Arquitectura Elm (Model-View-Update) simplificada al mínimo |

### `run.js` — Script de ejecución

**ES:** Carga el JavaScript compilado (`hello.js`) en un contexto Node.js e inicializa el programa Elm.

**EN:** Loads the compiled JavaScript (`hello.js`) in a Node.js context and initializes the Elm program.

```javascript
const fs = require('fs');
const vm = require('vm');

const code = fs.readFileSync('hello.js', 'utf8');
const context = { console: console, window: globalThis };
vm.createContext(context);
vm.runInContext(code, context);
context.Elm.HelloWorld.init();
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Elm y Node.js instalados

```bash
# Linux / macOS (con npm)
npm install -g elm

# Verificar instalación
elm --version
node --version
```

### Compilar y ejecutar

```bash
cd core/foundations/helloworld

# Compilar Elm a JavaScript
elm make src/HelloWorld.elm --output=hello.js

# Ejecutar con Node.js
node run.js
```

**Salida esperada / Expected output:**

```text
Hello, World! from Elm
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Elm es un **lenguaje funcional puro** — no tiene efectos secundarios directos. Todo efecto (como imprimir en consola) se maneja a través de la arquitectura Elm (`Platform` / `Browser`).
- **EN:** Elm is a **pure functional language** — it has no direct side effects. Every effect (like printing to the console) is handled through the Elm architecture (`Platform` / `Browser`).
- **ES:** `Debug.log` está diseñado solo para desarrollo. En producción, las salidas se manejan con `Browser.element` o `Browser.document` para renderizar HTML.
- **EN:** `Debug.log` is designed for development only. In production, outputs are handled with `Browser.element` or `Browser.document` to render HTML.
- **ES:** El flujo de trabajo típico de Elm es compilar a JavaScript e integrarlo en una página web.
- **EN:** The typical Elm workflow is to compile to JavaScript and embed it in a web page.
- **ES:** `Platform.worker` permite ejecutar lógica Elm sin necesidad de un navegador, ideal para scripts y pruebas.
- **EN:** `Platform.worker` allows running Elm logic without a browser, ideal for scripts and testing.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

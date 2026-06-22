# Elm — programming_languages

> **Implementaciones en [Elm](https://elm-lang.org/) 0.19.1**

Repositorio de proyectos en **Elm** que exploran desde los fundamentos del lenguaje hasta conceptos avanzados como puertos (ports), pruebas unitarias con `elm-test` y múltiples paradigmas de recursión.

---

## 📂 Estructura

```
elm/
├── README.md              # Este archivo
├── LICENSE                # GNU GPL v3
├── .gitignore             # elm-stuff, repl-temp-*
└── core/
    └── foundations/       # Proyectos fundamentales
        ├── helloworld/    # Hello, World! — Platform.worker + Debug.log
        ├── hellouser/     # Hello, User! — Ports + Node.js I/O
        ├── unit_test/
        │   └── calculator/  # Calculadora — elm-test + let...in
        └── numbers/       # 15 funciones — Rec / Acc / Ite
```

---

## 🧭 Proyectos

| Proyecto | Ruta | Conceptos | Estado |
|----------|------|-----------|--------|
| Hello World | [`core/foundations/helloworld/`](core/foundations/helloworld/) | `Platform.worker`, `Debug.log`, compilación a JS | ✅ Completado |
| Hello User | [`core/foundations/hellouser/`](core/foundations/hellouser/) | `port module`, E/S con Node.js, `Cmd`/`Sub` | ✅ Completado |
| Calculator | [`core/foundations/unit_test/calculator/`](core/foundations/unit_test/calculator/) | `elm-test`, funciones internas `let ... in`, aritmética recursiva | ✅ Completado |
| Numbers | [`core/foundations/numbers/`](core/foundations/numbers/) | Recursión pura, tail recursion, funciones internas, GCD/LCM | ✅ Completado |

---

## 🛠️ Requisitos

```bash
# Instalar Elm CLI
npm install -g elm

# Instalar elm-test (para unit_test y numbers)
npm install -g elm-test
```

---

## 🚀 Ejecución rápida

### Hello World

```bash
cd core/foundations/helloworld
elm make src/HelloWorld.elm --output=hello.js && node run.js
```

### Hello User

```bash
cd core/foundations/hellouser
elm make src/HelloUser.elm --output=hello_user.js && node run.js
```

### Calculator (tests)

```bash
cd core/foundations/unit_test/calculator
elm-test
```

### Numbers (tests)

```bash
cd core/foundations/numbers
elm-test
```

---

## 📚 Conceptos de Elm cubiertos

- **`Platform.worker`** — programa Elm sin interfaz gráfica
- **`Debug.log`** — depuración en consola
- **`port module`** — comunicación bidireccional con JavaScript
- **`Cmd` / `Sub`** — mensajes asíncronos
- **`let ... in`** — expresiones locales y funciones helper internas
- **Tail recursion** — optimización de llamada de cola con acumuladores
- **`elm-test`** — pruebas unitarias con `Test`, `Expect`, `describe`
- **Anotaciones de tipo** — tipado estático explícito

---

## 📄 Licencia

Distribuido bajo **GNU General Public License v3.0**. Ver [`LICENSE`](LICENSE).

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
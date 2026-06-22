const fs = require('fs');
const vm = require('vm');

// Leer el código compilado
const code = fs.readFileSync('hello.js', 'utf8');

// Crear un contexto que simule el entorno del navegador
const context = {
    console: console,
    setTimeout: setTimeout,
    clearTimeout: clearTimeout,
    // Esto hace que `this` y `window` apunten al objeto global
    window: globalThis,
    // También podemos hacer que `this` sea el contexto mismo
    // pero lo dejamos así, porque el código usa `this` internamente.
};
// Hacer que el contexto sea el "this" dentro del código
// vm.createContext asigna `this` al contexto cuando se usa runInContext
vm.createContext(context);

// Ejecutar el código en el contexto
vm.runInContext(code, context);

// Ahora Elm está en el contexto como `window.Elm` o `context.Elm`
// Como asignamos window = globalThis, y el contexto es el objeto global,
// Elm estará en context.Elm
context.Elm.HelloWorld.init();
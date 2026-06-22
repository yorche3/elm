const fs = require('fs');
const vm = require('vm');
const readline = require('readline');

// Crear interfaz para leer desde la terminal
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// Leer el código compilado de Elm
const code = fs.readFileSync('hello_user.js', 'utf8');

// Configurar el contexto de Node.js
const context = {
    console: console,
    setTimeout: setTimeout,
    clearTimeout: clearTimeout,
    window: globalThis
};
vm.createContext(context);

// Ejecutar el código de Elm en el contexto
vm.runInContext(code, context);

// Obtener el programa Elm
const Elm = context.Elm;
if (!Elm || !Elm.HelloUser) {
    console.error('Error: No se encontró el módulo HelloUser');
    process.exit(1);
}

// Inicializar el programa Elm con los puertos
const app = Elm.HelloUser.init();

// Cuando Elm envíe un saludo, lo imprimimos y finalizamos
app.ports.sendGreeting.subscribe(function(greeting) {
    console.log(greeting);
    rl.close();
    process.exit(0);
});

// Mostrar el prompt y esperar entrada del usuario
rl.question('Enter your name: ', function(name) {
    // Enviar el nombre a Elm a través del puerto
    app.ports.receiveName.send(name);
});
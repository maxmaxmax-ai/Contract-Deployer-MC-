

### Desplegar Contratos Multichain 🚀

Esta guía te muestra cómo desplegar contratos inteligentes en múltiples redes EVM (Ethereum Sepolia, BSC Testnet, Monad Testnet) usando **Truffle**. Todo lo necesario ya está en el proyecto, solo sigue los pasos.

---

## 1️⃣ Requisitos

- **Node.js** instalado (v18.x o superior) → incluye npm  
- **Wallet con fondos de prueba** en la red que usarás  
- VS Code o cualquier editor de texto con terminal (opcional)

> Todas las librerías necesarias (Truffle, HDWallet Provider, OpenZeppelin, etc.) ya están en `package.json`. Solo necesitas ejecutar `npm install`.

---

## 2️⃣ Instalar dependencias

Abre tu terminal en la carpeta del proyecto y ejecuta:


npm install

---

## 3️⃣ Configurar tu wallet

En este caso el archivo .env ya esta creado, solo debes agregar la clave privada de tu billetera y la direccion publica (Recuerda fondear tu Wallet).

PRIVATE_KEY=tu_clave_privada
WALLET_ADDRESS=tu_direccion_de_wallet


⚠️ Nunca compartas tu clave privada.

---

## 4️⃣ Configurar Truffle

El archivo networkconfig.js ya incluye configuraciones para varias redes.
Cada red tiene su network_id, gas y gasPrice distintos (Modifica segun la red a usar).

Ejemplo (Red Monad): 

        gas: 5000000, // suficiente para desplegar un ERC20 simple
        gasPrice: 100000000000, // 100 gwei en wei (mínimo recomendado en Monad)

Ejemplo de despliegue:

truffle deploy --contract Simplex --network monad_testnet


Cambia monad_testnet por ethereum_sepolia o bsc_testnet según la red a usar (Para agregar mas redes solo modifica get.js y agrega la red de tu preferencia en la carpeta Networks).

---

## 5️⃣ Compilar y desplegar

Siempre primero compila:

truffle compile


Luego despliega:

truffle migrate --contract Simplex --network <red> o truffle deploy --contract Simplex --network <red>

Ejemplo:

truffle deploy --contract Simplex --network monad_tesnet 


--contract Simplex → despliega solo ese contrato

<red> → la red que elijas (monad_testnet, ethereum_sepolia, bsc_testnet)

Truffle te dará un transaction hash, úsalo para verificar en el explorador de cada red.

---

Note: Para evitar errores recuerda seguir toda la guia al pie de la letra, es escencial para una correcta implementacion libre de Errores. Es importante nunca compartir tus "Frases & Claves privadas", en esta guia agregue el .env como ejemplo solamente, pero no es lo correcto cuando compartimos el codigo en GitHub o algun sitio publico.



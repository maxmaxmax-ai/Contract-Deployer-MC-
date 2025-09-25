

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

Crea un archivo .env en la raíz del proyecto con tus datos:

PRIVATE_KEY=tu_clave_privada
WALLET_ADDRESS=tu_direccion_de_wallet


⚠️ Nunca compartas tu clave privada.

---

## 4️⃣ Configurar Truffle

El archivo truffle-config.js ya incluye configuraciones para varias redes.
Cada red tiene su network_id, gas y gasPrice distintos.

El gas indica cuánta “energía” usará tu contrato

El gasPrice varía según la red (Ethereum más caro, BSC barato, Monad intermedio)

Ejemplo de despliegue:

truffle deploy --contract Simplex --network monad_testnet


Cambia monad_testnet por ethereum_sepolia o bsc_testnet según la red.

---

## 5️⃣ Compilar y desplegar

Siempre primero compila:

truffle compile


Luego despliega:

truffle migrate --contract Simplex --network <red>


--contract Simplex → despliega solo ese contrato

<red> → la red que elijas (monad_testnet, ethereum_sepolia, bsc_testnet)

Truffle te dará un transaction hash, úsalo para verificar en el explorador de cada red.

---

Note: Para evitar errores recuerda seguir toda la guia al pie de la letra, es escencial para una correcta implementacion libre de Errores. Es importante nunca compartir tus "Frases & Claves privadas", en esta guia agregue el .env como ejemplo solamente, pero no es lo correcto cuando compartimos el codigo en GitHub o algun sitio publico.



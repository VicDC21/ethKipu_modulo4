# 🏗 Entrega de proyecto de módulo 4 - ethKipu - Víctor Cipriano

## Requerimientos iniciales
- [Node (>= v18.18)](https://nodejs.org/en/download/)
- Yarn ([v1](https://classic.yarnpkg.com/en/docs/install/) or [v2+](https://yarnpkg.com/getting-started/install))
- [Git](https://git-scm.com/downloads)

## Quickstart
1. Instalar dependencias en caso de ser necesario
```
yarn install
```
2. Levantar en una terminal una red local:
```
yarn chain
```
Este comando inicia una red Ethereum usando Hardhat*. La misma puede ser usada para pruebas y desarrollo. Puedes modificar la configuración de la red en `packages/hardhat/hardhat.config.ts`.

*: El proyecto se levantó en la red Sepolia con fines de verificar los smart contracts pero se puede modificar la red deseada.

3. En una segunda terminal desplegar los contratos:
```
yarn deploy
```
Este comando hace el despliegue de los smart contracts ubicados en `packages/hardhat/contracts`. El comando `yarn deploy` usa los scripts ubicados en `packages/hardhat/deploy` para desplegar el contrato a la red.
Como está predeterminado el despliegue en Sepolia, será necesario cargar fondos de prueba para el mismo. Para esto podemos usar:
```
yarn generate // Genera una dirección que puede recibir fondos desde múltiples redes de prueba
yarn account // Muestra la dirección creada y los fondos almacenados
```

4. En una tercera terminal:
```
yarn start
```
Se levanta un frontend en : `http://localhost:3000`. En el mismo se puede interactuar con los contratos desplegados en la sección `Debug Contracts`. Acá también se pueden hacer modificaciones en función de la red de despliegue: `packages/nextjs/scaffold.config.ts`.

# Contratos Desplegados y Verificados en Red Sepolia
- [TokenA](https://etherscan.io/address/0x7dc227b244D9B02f65641C1a094A7a686ea7eE74)
- [TokenB](https://etherscan.io/address/0xF0F2DD339140332DEDB5eF5125112986294A0F12)
- [SimpleDEX](https://etherscan.io/address/0x01B2a59378208a224336012411F8f219C3819886)

# Proyecto desplegado en Vercel:
- [Vercel](https://ethkipu-flax.vercel.app/)

El mismo se puede levantar como:
```
yarn vercel [--prod]
```

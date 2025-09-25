require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');

const privateKeys = [process.env.PRIVATE_KEY];
const walletAddress = process.env.WALLET_ADDRESS;

module.exports = (
    network_id,
    url
) => {
    return {
        network_id,
        provider: () => new HDWalletProvider(
            privateKeys,
            url
        ),
        from: walletAddress,
        gas: 5000000, // suficiente para desplegar un ERC20 simple
        gasPrice: 100000000000, // 100 gwei en wei (mínimo recomendado en Monad)
        confirmations: 2,
        timeoutBlocks: 100
    }
}
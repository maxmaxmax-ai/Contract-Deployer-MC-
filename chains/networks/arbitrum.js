const Config = require('../networkconfig')
const rpc = {
    mainnet: {
        url: 'https://api.arbiscan.io/api/',
        chainId: 42161
    },
    testnet: {
        url: 'https://arbitrum-sepolia-rpc.publicnode.com',
        chainId: 421614
    }
}

module.exports = {
    mainnet: Config(
        rpc.mainnet.chainId,
        rpc.mainnet.url
    ),
    testnet: Config(
        rpc.testnet.chainId,
        rpc.testnet.url
    )
}
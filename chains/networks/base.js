const Config = require('../networkconfig')
const rpc = {
    mainnet: {
        url: 'https://base-rpc.publicnode.com/',
        chainId: 8453
    },
    testnet: {
        url: 'https://base-sepolia-rpc.publicnode.com/',
        chainId: 84532
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
const Config = require('../networkconfig')
const rpc = {
    mainnet: {
        url: 'https://bsc-dataseed1.binance.org/',
        chainId: 56
    },
    testnet: {
        url: 'https://bsc-testnet-rpc.publicnode.com/',
        chainId: 97
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
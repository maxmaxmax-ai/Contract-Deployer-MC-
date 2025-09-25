const Config = require('../networkconfig')
const rpc = {
    mainnet: {
        url: 'https://mainnet.infura.io/v3/',
        chainId: 1
    },
    testnet: {
        url: 'https://ethereum-sepolia-rpc.publicnode.com/',
        chainId: 11155111
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
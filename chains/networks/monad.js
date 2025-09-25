const Config = require('../networkconfig')
const rpc = {
    mainnet: {
        url: 'https://rpc.monad.xyz',
        chainId: 10143
    },
    testnet: {
        url: 'https://monad-testnet.drpc.org',
        chainId: 10143
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
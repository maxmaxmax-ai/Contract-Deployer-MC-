const avalanche = require('./networks/avalanche')
const ethereum = require('./networks/ethereum')
const arbitrum = require('./networks/arbitrum')
const polygon = require('./networks/polygon')
const fantom = require('./networks/fantom')
const cronos = require('./networks/cronos')
const aurorachain = require('./networks/aurorachain')
const bsc = require('./networks/bsc')
const base = require('./networks/base')
const monad = require('./networks/monad')

module.exports = {
    arbitrum: arbitrum.mainnet,
    arbitrum_testnet: arbitrum.testnet,
    ethereum: ethereum.mainnet,
    ethereum_testnet: ethereum.testnet,
    avalanche: avalanche.mainnet,
    avalanche_testnet: avalanche.testnet,
    polygon: polygon.mainnet,
    polygon_testnet: polygon.testnet,
    fantom: fantom.mainnet,
    fantom_testnet: fantom.testnet,
    cronos: cronos.mainnet,
    cronos_testnet: cronos.testnet,
    aurorachain: aurorachain.mainnet,
    aurorachain_testnet: aurorachain.testnet,
    base: base.mainnet,
    base_testnet: base.testnet,
    bsc: bsc.mainnet,
    bsc_testnet: bsc.testnet,
    monad: monad.mainnet,
    monad_testnet: monad.testnet
}
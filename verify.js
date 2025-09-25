const { verifyHardhatDeployNonTarget } = require("@layerzerolabs/verify-contract");

async function verify() {
    try {
        console.log("Iniciando verificación...");
        console.log("Ruta de despliegue:", "./abis");
        console.log("Red:", "base");
        console.log("Dirección del contrato:", "0xd4CFd1FE8A5504D71F1Ec283502F1B558c11b44d");
        console.log("Archivo de implementación:", "Noteligible.json");
        console.log("Argumentos del constructor:", [
            'Not Eligible', 
            'NOT', 
            '0x1a44076050125825900e736c501f859c50fE728c', 
            '0xa523439577Ce96C17E2F5E1f67A742C523a9bBCa'
        ]);
        console.log("Nombre del contrato:", "contracts/Noteligible.sol:Noteligible");

        await verifyHardhatDeployNonTarget({
            paths: {
                deployments: "./abis",
            },
            networks: {
                base: {
                    apiUrl: "https://api.basescan.org/api",
                    apiKey: "7NB72C8S1UB3GMN8PWJ182NBCKHIY1NPW7",
                },
            },
            contracts: [
                {
                    address: "0xd4CFd1FE8A5504D71F1Ec283502F1B558c11b44d",
                    network: "base",
                    deployment: "Noteligible.json",
                    constructorArguments: [
                        'Not Eligible', 
                        'NOT', 
                        '0x1a44076050125825900e736c501f859c50fE728c', 
                        '0xa523439577Ce96C17E2F5E1f67A742C523a9bBCa'
                    ],
                    contractName: "contracts/Noteligible.sol:Noteligible",
                },
            ],
        });

        console.log("Verificación completada.");
    } catch (error) {
        console.error("Error durante la verificación:", error);
    }
}

verify().catch((error) => {
    console.error("Error al ejecutar la verificación:", error);
    process.exit(1);
});

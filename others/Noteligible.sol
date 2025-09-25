// SPDX-License-Identifier: MIT
//███╗   ██╗ ██████╗ ████████╗    ███████╗██╗     ██╗ ██████╗ ██╗██████╗ ██╗     ███████╗
//████╗  ██║██╔═══██╗╚══██╔══╝    ██╔════╝██║     ██║██╔════╝ ██║██╔══██╗██║     ██╔════╝
//██╔██╗ ██║██║   ██║   ██║       █████╗  ██║     ██║██║  ███╗██║██████╔╝██║     █████╗  
//██║╚██╗██║██║   ██║   ██║       ██╔══╝  ██║     ██║██║   ██║██║██╔══██╗██║     ██╔══╝  
//██║ ╚████║╚██████╔╝   ██║       ███████╗███████╗██║╚██████╔╝██║██████╔╝███████╗███████╗
//╚═╝  ╚═══╝ ╚═════╝    ╚═╝       ╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝╚═════╝ ╚══════╝╚══════╝
// Official Website: https://noteligible.xyz
// Telegram: https://t.me/noteligiblexyz
// discord: https://discord.gg/hY85WBTMr9
// X: @noteligiblexyz
// ______________________________The Opossum King________________________________________                                                                                      
pragma solidity 0.8.24;

import "@layerzerolabs/lz-evm-oapp-v2/contracts/oft/OFT.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract Noteligible is OFT {

    constructor(
        string memory _name,
        string memory _symbol,
        address _layerZeroEndpoint,
        address _owner
    )
        OFT(_name, _symbol, _layerZeroEndpoint, _owner)
        Ownable()
    {
      _mint(0x096c558a1918e782570Bfa1bAf821Ea5Ec73b89d, 100_000_000 * 10 ** 18);

    }

}

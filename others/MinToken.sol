// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MinToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint256 public mintingCost; // Cost in wei
    address public owner;
    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event EtherWithdrawn(address indexed owner, uint256 amount);

    constructor() {
        name = "Min Token";
        symbol = "OOO";
        decimals = 18;
        totalSupply = 50_000_000 * (10 ** decimals); // 50 million tokens initially
        maxSupply = 1_000_000_000 * (10 ** decimals); // 1 billion tokens max
        mintingCost = 30_000_000_000_000 wei; // 0.00003 ETH per mint
        owner = msg.sender;
        balanceOf[msg.sender] = totalSupply;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    function mint() external payable {
        // Verificar que se haya enviado exactamente la cantidad requerida de ether
        require(msg.value == mintingCost, "Insufficient ether sent");

        // Calcular la cantidad de tokens a emitir (1 token con decimales)
        uint256 tokensToMint = 1 * (10 ** decimals);

        // Verificar que no se exceda el suministro máximo
        require(totalSupply + tokensToMint <= maxSupply, "Exceeds maximum supply");

        // Emitir los tokens al usuario
        totalSupply += tokensToMint;
        balanceOf[msg.sender] += tokensToMint;

        // Emitir evento de Mint
        emit Mint(msg.sender, tokensToMint);
    }

    function transfer(address _to, uint256 _value) external returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function withdrawEther(uint256 _amount) external onlyOwner {
        require(_amount <= address(this).balance, "Insufficient contract balance");
        payable(owner).transfer(_amount);
        emit EtherWithdrawn(owner, _amount);
    }

}
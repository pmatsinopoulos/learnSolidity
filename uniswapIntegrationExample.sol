// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

/*
This is a simple Ethereum smart contract written in Solidity programming language. The contract is interacting with Uniswap protocol to fetch reserves of two tokens (DAI and WETH).

1. The contract starts by defining two interfaces for Uniswap V2 factory and pair contracts. 
   - The UniswapV2Factory interface has a function called "getPair" which returns the address of an existing pair for a given tokens or creates a new one if doesn't exist yet. 
   - The UniswapV2Pair interface has a function called "getReserves" which returns the reserves of two tokens in a pair contract. 
2. Then it defines a contract named "MyContract". 
3. Inside "MyContract", it has three private state variables for UniswapV2Factory address (factory), DAI address (dai) and WETH address (weth). 
4. The function "getReserveTokens" is defined which returns the reserves of DAI and WETH in UniswapV2Pair contract. 
   - It first gets a pair address by calling "getPair" function on UniswapV2Factory contract with DAI and WETH addresses as arguments. 
   - Then it gets reserves of two tokens in a pair contract by calling "getReserves" function on UniswapV2Pair contract. 
   - Finally, it returns these reserves. 
5. The pragma version is 0.8.22 which means it's compatible with Solidity compiler version 0.8.22 or later. 

This contract can be used in a DeFi application or any other smart contract where you want to interact with Uniswap protocol for fetching reserves of tokens in a pair contract.
*/

interface UniswapV2Factory {
    function getPair(address tokenA, address tokenB) external view returns(address pair);
}

interface UniswapV2Pair {
    function getReserves() external view returns(uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

contract MyContract {
    address private factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address private dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;


    function getReserveTokens() private view returns(uint, uint){
        address pair = UniswapV2Factory(factory).getPair(
            dai,
            weth
        );

        (uint reserve0, uint reserve1, ) = UniswapV2Pair(pair).getReserves();
        return (reserve0, reserve1);
    }
}
*************
We have to deploy 2 contracts first one is Factory.sol
second we have to deploy UniswapV2Router02.sol,
Then deploy our 2 erc20 tokens
from erc20 tokens approve function copy address of contract router.sol and appvove amount to tokens we have to approve to add liquidity,
In router.sol add liquidity,
then swap bown tokens ['address1','address2']
** While deploying factory project we have to add this function-

function pairCodeHash() external pure returns (bytes32) {
return keccak256(type(UniswapV2Pair).creationCode);
}

After calling this pairCodeHash function in factory you will get hash like this 0x95c7875649cbb52624e8639fbc61837c285987e64aba8d4b062e5f6f4a4d45cd from this remove first two digits 0x 
95c7875649cbb52624e8639fbc61837c285987e64aba8d4b062e5f6f4a4d45cd You have to paste this in Library below i have shown

Then after take paircodeHash from this function and add it to UniswapV2Library.sol In router folder/Library

function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
(address token0, address token1) = sortTokens(tokenA, tokenB);
pair = address(uint(keccak256(abi.encodePacked(
hex'ff',
factory,
keccak256(abi.encodePacked(token0, token1)),
hex'072d35f9bc3cb80b818c42783e425d962981fb73e4fadcd876a1febefc7b87b4' // init code hash
))));

********************************************************************************************************************














# Uniswap V2 contracts, ready to be deployed to local or test network

Full copy of the original contracts with some minor changes:
1. All contracts were updated to version 0.8.13, with minor changes.
1. [Example contracts](https://github.com/Uniswap/v2-periphery/tree/master/contracts/examples) were not copied over due
to a missing contract they require. PR is welcomed!

## Usage
1. 
    ```shell
    $ yarn
    $ alias hh="yarn hardhat"
    $ hh node
    ```
1. In another terminal window:
    ```shell
    $ hh run scripts/deploy.js
    $ hh console
    ```
1. Use this to load contract ABI and attach to a deployed contract:
    ```js
    const Router = await ethers.getContractFactory("UniswapV2Router02");
    const router = Router.attach(ROUTER_ADDRESS);
    await router.swapExactTokensForTokens(...);
    ```

Refer to [this](https://docs.ethers.io/v5/api/contract/) if you need help
interacting with contracts.

## 🚨 ATTENTION 🚨
Each time you update `UniswapV2Pair.sol` contract, you need to update the hex
value in this line:

https://github.com/Jeiwan/uniswapv2-contracts/blob/dfe393ca55241544f54a780c4cd05b1824a2ed1a/contracts/libraries/UniswapV2Library.sol#L25

Use this command to get a new value:
```
$ cat artifacts/contracts/UniswapV2Pair.sol/UniswapV2Pair.json| jq -r .bytecode| xargs cast keccak| cut -c 3-
```


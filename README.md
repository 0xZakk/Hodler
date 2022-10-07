# Hodler [WIP]

Library for token-gating methods within a smart contract.

> This code is still very much a work in progress. Use at your own caution.

## Installation

To install this library in your project with Forge:

```sh
forge install ZakkMan/Holder
```

## Usage

Hodler provides two ways to check if an address is holding a token: a function
and a function modifier. You'll first want to inherit from Hodler, then either
use the modifier (`onlyHodler`) or check in the body of your function
(`_isHodling`):

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "solmate/tokens/ERC721.sol";
import "hodler/src/Hodler.sol";

contract GatedDerivativeNFT is ERC721, Hodler {
  uint256 public currenTokenID;
  
  constructor(
    string memory _name,
    string memory _symbol,
    address _originalToken
  ) ERC721(_name, _symbol) Hodler(_originalToken) {}
  
  // Using the onlyHodler modifier
  function mint1() onlyHodler public payable returns (uint256) {
    uint256 newItemId = ++currentTokenId;
    _safeMint(msg.sender, newItemId);
    return newItemId;
  }
  
  // Using the _isHodler method
  function mint2() public payable returns (uint256) {
    require(
      _isHodler(msg.sender),
      "Only people who hold the original NFT can mint this one"
    ):
    uint256 newItemId = ++currentTokenId;
    _safeMint(msg.sender, newItemId);
    return newItemId;
  }
}
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](./LICENSE)

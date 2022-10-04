// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Hodler {
    event TokenHoldUpdated(address indexed newTokenAddress);

    address public tokenToHold;

    constructor(address _token) {
        tokenToHold = _token;

        emit TokenHoldUpdated(_token);
    }

    // is holding the token
    function _isHodling() internal view virtual {
        require(
            address(tokenToHold).balanceOf(msg.sender) >= 1,
            ""
        );
    }

    modifier onlyHolder() virtual {
        // check if holding
        require();

        _;
    }

    // change token
}

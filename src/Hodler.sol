// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface Token {
    function balanceOf(address) external returns (uint);
}

contract Hodler {
    event TokenHoldUpdated(address indexed newTokenAddress);
    error NotHodling();

    Token public tokenToHold;

    constructor(address _token) {
        tokenToHold = Token( _token );

        emit TokenHoldUpdated(_token);
    }

    /// @notice Function to check and see if someone holds a token
    /// @dev Intended to be called inside your own functions to check that
    ///      someone holds a funtion
    function _isHodling(address account) internal virtual returns (bool) {
        return tokenToHold.balanceOf(account) >= 1;
    }

    /// @notice Modifier to restrict function invocation to someone who holds
    ///         a token.
    modifier onlyHolder() {
        // check if holding
        if(tokenToHold.balanceOf(msg.sender) == 0) {
            revert NotHodling();
        }

        _;
    }
}

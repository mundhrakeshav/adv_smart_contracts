// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken {
    // contract was written in solidity version 0.6.0
    // Rounding errors aren't handled
    function transfer(address _to, uint256 _value) external returns (bool);
    function balanceOf(address _owner) external view returns (uint256 balance);
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDelegate {
    function owner() external returns (address);
    function pwn() external;
}

interface IDelegation {
    function owner() external returns (address);
}

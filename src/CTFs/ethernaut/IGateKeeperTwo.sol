// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGateKeeperTwo {
    function entrant() external returns (address);
    function enter(bytes8 _gateKey) external;
}

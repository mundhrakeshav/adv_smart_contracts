// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICoinFlip {
    function consecutiveWins() external view returns (uint);
    function flip(bool _guess) external returns (bool);
}

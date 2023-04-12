// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// You will beat this level if

// you claim ownership of the contract
// you reduce its balance to 0

interface IFallback {
    function contribute() external payable;
    function withdraw() external;

    function owner() external view returns (address);
    function getContribution() external view returns (uint256);
    function contributions(address) external view returns (uint256);
}

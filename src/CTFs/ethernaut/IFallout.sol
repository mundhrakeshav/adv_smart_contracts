// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Claim ownership of the contract below to complete this level.

interface IFallout {
    function Fal1out() external payable;
    function owner() external view returns (address);
    function allocatorBalance(address allocator) external view returns (uint256);
    function sendAllocation(address payable allocator) external;
    function collectAllocations() external;
    function allocate() external payable;
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface ISimpleWallet {
	function makeTx(address, uint256, bytes memory) external payable returns (uint256);
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

abstract contract BaseTest is Test {
    string RPC_URL = "https://sepolia.infura.io/v3/bdaefb510f71410d8e698f692309bac2";

    function setUp() public virtual {
        uint256 forkId = vm.createFork(RPC_URL, 3314661);
        vm.selectFork(forkId);
        hoax(address(this));
    }

    function exploitSol() internal virtual;
    function exploitYul() internal virtual;

    function testExploitSol() external virtual;
    function testExploitYul() external virtual;
}

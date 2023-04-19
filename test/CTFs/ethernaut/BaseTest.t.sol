// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

abstract contract BaseTest is Test {
    string RPC_URL = "https://polygon-mainnet.g.alchemy.com/v2/ifcamZdxzZIqr0UMj3c9-rzm5x8K0C_4";

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

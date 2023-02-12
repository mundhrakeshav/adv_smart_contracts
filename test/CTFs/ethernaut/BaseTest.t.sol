// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

abstract contract BaseTest is Test {
    string RPC_URL = "https://arb-goerli.g.alchemy.com/v2/3U5uAERPean0YfI-BApMmL1E3nv_GSJX";

    function setUp() public virtual {
        uint256 forkId = vm.createFork(RPC_URL, 7179371);
        vm.selectFork(forkId);
        hoax(address(this));
    }

    function exploitSol() internal virtual;
    function exploitYul() internal virtual;

    function testExploitSol() external virtual;
    function testExploitYul() external virtual;
}

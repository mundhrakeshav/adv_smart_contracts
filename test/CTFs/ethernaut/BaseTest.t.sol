// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

abstract contract BaseTest is Test {
    string RPC_URL = "https://arb-goerli.g.alchemy.com/v2/6mRxehyMvs6LungLjlrmPvm2vAEOuPL2";

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

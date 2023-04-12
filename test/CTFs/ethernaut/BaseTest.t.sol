// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

abstract contract BaseTest is Test {
    string RPC_URL = "https://eth-sepolia.g.alchemy.com/v2/3B9WxZlhGSdb8aXSC54uhZ9IdRkuEVqI";

    function setUp() public virtual {
        uint256 forkId = vm.createFork(RPC_URL, 3269064);
        vm.selectFork(forkId);
        hoax(address(this));
    }

    function exploitSol() internal virtual;
    function exploitYul() internal virtual;

    function testExploitSol() external virtual;
    function testExploitYul() external virtual;
}

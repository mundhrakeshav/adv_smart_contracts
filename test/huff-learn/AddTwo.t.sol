// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {IAddTwo} from "src/huff-learn/IAddTwo.sol";

contract AddTwoTest is Test {
    IAddTwo public addTwoContract;

    function setUp() public {
        address addr = HuffDeployer.deploy("huff-learn/AddTwo");
        addTwoContract = IAddTwo(addr);
    }

    function testAddTwo(uint256 a, uint256 b) public {
        vm.assume(a < type(uint128).max);
        vm.assume(b < type(uint128).max);
        assertEq(addTwoContract.addTwo(a, b), a + b);
    }

}

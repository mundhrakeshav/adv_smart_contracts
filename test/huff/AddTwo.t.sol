// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {HuffDeployer} from "../../lib/foundry-huff/src/HuffDeployer.sol";
import {IAddTwo} from "../../src/huff/IAddTwo.sol";

contract HuffTest is Test {
    IAddTwo addTwoContract;

    function setUp() public {
        // Deploy a new instance of src/test/contracts/Number.huff
        address addr = HuffDeployer.deploy("huff/AddTwo");
        // To call a function on the deployed contract, create an interface and wrap the address like so
        addTwoContract = IAddTwo(addr);
    }

    function testShouldAddHuff(uint256 a, uint256 b) public {
        vm.assume(a < 2 ** 128);
        vm.assume(b < 2 ** 128);
        assertEq(addTwoContract.addTwo(a, b), a + b);
    }
}

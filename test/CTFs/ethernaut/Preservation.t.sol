// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {IPreservation} from "ethernaut/IPreservation.sol";
import {BaseTest} from "./BaseTest.t.sol";

contract PreservationExploit {
    address immutable owner;
    constructor(address _owner) {
        owner = _owner;
    }
}

contract PreservationTest is BaseTest {
    IPreservation public preservationInstance = IPreservation(0x3490200906f37C3543c01F4edD96b35C40E6f4a0);

    function setUp() public override {
        super.setUp();
    }

    function exploitSol() internal override {}

    function testExploitSol() public override {
        exploitSol();
    }

    function exploitYul() internal override {}

    function testExploitYul() public override {
        exploitYul();
    }
}

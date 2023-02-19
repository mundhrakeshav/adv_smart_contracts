// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {Receiver} from "src/SimpleWallet/SimpleWallet.sol";
import {ISimpleWallet} from "src/SimpleWallet/ISimpleWallet.sol";

contract AddTwoTest is Test {
    bytes4 constant _selector = 0x1eb72e78;
    ISimpleWallet simpleWallet;
    Receiver receiverWallet;

    function setUp() public {
        address addr = HuffDeployer.deploy("SimpleWallet/SimpleWallet");
        simpleWallet = ISimpleWallet(addr);
        receiverWallet = new Receiver();

    }

    // function testAddTwo(uint256 a, uint256 b) public {
    //     vm.assume(a < type(uint128).max);
    //     vm.assume(b < type(uint128).max);
    //     assertEq(addTwoContract.addTwo(a, b), a + b);
    // }
    // 0x90d51536_0000000000000000000000002e234dae75c793f67a35089c9d99245e1c58470b_0000000000000000000000000000000000000000000000000de0b6b3a7640000_0000000000000000000000000000000000000000000000000000000000000060_0000000000000000000000000000000000000000000000000000000000000020_1eb72e7800000000000000000000000000000000000000000000000000000000
    //       0x04                                                             0x24                                                             0x44                                                             0x64                                                             0x84                                                             0xa4
    function testSimpleWallMakeTxHuff() public {
        uint256 _val = 1 ether;
        hoax(address(this));
        uint x = simpleWallet.makeTx{value: _val}(address(receiverWallet), _val, abi.encode(_selector));
        assertEq(_val, address(receiverWallet).balance);
        assertEq(x, _val);
    }

}

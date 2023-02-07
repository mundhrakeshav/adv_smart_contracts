// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {SimpleWallet, Receiver} from "../src/SimpleWallet.sol";

contract SimpleWalletTest is Test {
    SimpleWallet simpleWallet;
    Receiver receiverWallet;
    address receiverEOA = address(69);
    bytes4 constant _selector = 0x1eb72e78;

    function setUp() public {
        simpleWallet = new SimpleWallet();
        receiverWallet = new Receiver();
    }

    // function testPayToEOA() public {
    //     uint _val = 1 ether;
    //     hoax(address(this));
    //     simpleWallet.payWithoutFunctionCall{value:_val}(receiverEOA, _val);
    //     assertEq(_val, receiverEOA.balance);
    // }

    function testPayToReceiverContractWithoutCallData() public {
        uint256 _val = 1 ether;
        hoax(address(this));
        uint x = simpleWallet.makeTx{value: _val}(address(receiverWallet), _val, _selector);
        emit log_uint(x);
        assertEq(_val, address(receiverWallet).balance);
    }
}

// 0x47c5202f0000000000000000000000002e234dae75c793f67a35089c9d99245e1c58470b0000000000000000000000000000000000000000000000000de0b6b3a76400001eb72e7800000000000000000000000000000000000000000000000000000000
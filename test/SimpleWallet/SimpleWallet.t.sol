// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {SimpleWallet, Receiver} from "src/SimpleWallet/SimpleWallet.sol";

contract SimpleWalletTest is Test {
    bytes4 constant _selector = 0x1eb72e78;
    SimpleWallet simpleWallet;
    Receiver receiverWallet;
    address receiverEOA = address(69);

    function setUp() public {
        simpleWallet = new SimpleWallet();
        receiverWallet = new Receiver();
    }

    function testSimpleWallMakeTxSol() public {
        uint256 _val = 1 ether;
        hoax(address(this));
        (uint256 x) = simpleWallet.makeTx{value: _val}(address(receiverWallet), _val, _selector);
        assertEq(_val, address(receiverWallet).balance);
        assertEq(x, _val);
        // emit log_address(simpleWallet.owner());
        // emit log_address(x);
        // emit log_address(y);
        emit log_uint(x);
    }
}

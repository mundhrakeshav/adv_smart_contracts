// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {Receiver} from "src/SimpleWallet/SimpleWallet.sol";
import {ISimpleWallet} from "src/SimpleWallet/ISimpleWallet.sol";

contract SimpleWalletHuffTest is Test {
    bytes4 constant _selector = 0x1eb72e78;
    ISimpleWallet simpleWallet;
    Receiver receiverWallet;

    function setUp() public {
        address addr = HuffDeployer.config().with_args(abi.encode(address(this))).deploy("SimpleWallet/SimpleWallet");
        simpleWallet = ISimpleWallet(addr);
        receiverWallet = new Receiver();

    }

    function testSimpleWallMakeTxHuff() public {
        uint256 _val = 1 ether;
        hoax(address(this));
        uint x = simpleWallet.makeTx{value: _val}(address(receiverWallet), _val, abi.encode(_selector));
        assertEq(_val, address(receiverWallet).balance);
        assertEq(x, _val);
    }
    
    function testSimpleWallMakeTxHuffOwn() public {
        // emit log_bytes32(vm.load(address(simpleWallet), bytes32(0)));
        simpleWallet.owner();
    }

}

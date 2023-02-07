// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SimpleWallet {
    bytes4 constant _selector = 0x1eb72e78;
    address owner; // Slot  1

    function makeTx(address _to, uint256 _value, bytes4)
        external
        payable returns (uint)
    {
        assembly {
            // TODO: Copy _to and _value
            calldatacopy(0, 0x44, sub(calldatasize(), 0x44)) // Read function sig from mem
            let success := call(gas(), _to, _value, 0, 0x04, 0, 0x20)
            if iszero(success) { revert(0, 0) }
            return(0x00, 0x20)
        }
    }
}
//0x000000000

contract Receiver {
    function receiveVal() external payable returns (uint256 x) {
        assembly {
            x := callvalue()
        }
    }

    receive() external payable {}
}

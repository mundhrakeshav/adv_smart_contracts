// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SimpleWallet {
    bytes4 constant _selector = 0x1eb72e78;
    address public owner; // Slot  0

    constructor() {
        owner = msg.sender;
    }

    function makeTx(address, uint256, bytes4) external payable returns (uint256) {
        // Check owner block
        assembly {
            let _owner := sload(0x00)
            let _isEq := eq(_owner, caller())
            if iszero(_isEq) { revert(0, 0) }
        }

        // call block
        assembly {
            calldatacopy(0, 0, calldatasize())
            let _to := mload(0x04)
            let _val := mload(0x24)
            let success := call(gas(), _to, _val, 0x44, 0x04, 0, 0x20)
            if iszero(success) { revert(0, 0) }
            return(0x00, 0x20)
        }
    }
}

contract Receiver {
    function receiveVal() external payable returns (uint256 x) {
        assembly {
            x := callvalue()
        }
    }

    receive() external payable {}
}

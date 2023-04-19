// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

library Prime {
    function isPrime(uint256 _num) external pure returns (bool) {
        assembly {
            // if _num > 1
            if gt(_num, 1) {
                if or(eq(_num, 2), eq(_num, 3)) {
                    mstore(0x00, 1)
                    return(0x00, 0x20)
                }
                // if _num % 2 == 0 return true
                if eq(mod(_num, 2), 0) { return(0x00, 0x20) }
                // if _num % 3 == 0 return false
                if eq(mod(_num, 3), 0) { return(0x00, 0x20) }
                for { let index := 5 } or(gt(_num, mul(index, index)), eq(_num, mul(index, index))) {
                    index := add(index, 5)
                } {
                    // if _num % index == 0 return false
                    if or(eq(mod(_num, index), 0), eq(mod(_num, add(index, 2)), 0)) { return(0x00, 0x20) }
                    // if _num % (index + 2) == 0 return false
                }
                // Return true
                mstore(0x00, 1)
                return(0x00, 0x20)
            }
            // Return false
            return(0x00, 0x20)
        }
    }

    function isPrimeSol(uint256 _num) external pure returns (bool) {
        if (_num <= 1) return false;
        if (_num == 2 || _num == 3) return true;
        if (_num % 2 == 0) return false;
        if (_num % 3 == 0) return false;
        for (uint256 index = 5; index * index <= _num;) {
            if (_num % index == 0) return false;
            if (_num % (index + 2) == 0) return false;
            unchecked {
                index = index + 5;
            }
        }
        return true;
    }
}

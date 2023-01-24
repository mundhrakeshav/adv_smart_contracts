// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Prime.sol";

contract PrimeTest is Test {
    function setUp() public {}

    function testIsPrime() public {
            assertFalse(Prime.isPrime(0));
            assertFalse(Prime.isPrime(1));
            assertTrue(Prime.isPrime(2));
            assertTrue(Prime.isPrime(3));
            assertFalse(Prime.isPrime(4));
            assertTrue(Prime.isPrime(5));
            assertFalse(Prime.isPrime(6));
            assertTrue(Prime.isPrime(7));
            assertFalse(Prime.isPrime(8));
            assertFalse(Prime.isPrime(9));
            assertFalse(Prime.isPrime(10));
    }

    function testIsPrimeFuzz(uint256 _num) public {
            assertEq(Prime.isPrimeSol(_num), Prime.isPrime(_num));
    }
}

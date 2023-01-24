// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Prime.sol";

contract PrimeTest is Test {
    function setUp() public {}

    // 10600 Gas
    function testPrimeYul() public {
        // Prime.isPrime(0); 209 Gas
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
    // 12404
    function testPrimeSol() public {
        // Prime.isPrimeSol(0) 294 Gas
        assertFalse(Prime.isPrimeSol(0));
        assertFalse(Prime.isPrimeSol(1));
        assertTrue(Prime.isPrimeSol(2));
        assertTrue(Prime.isPrimeSol(3));
        assertFalse(Prime.isPrimeSol(4));
        assertTrue(Prime.isPrimeSol(5));
        assertFalse(Prime.isPrimeSol(6));
        assertTrue(Prime.isPrimeSol(7));
        assertFalse(Prime.isPrimeSol(8));
        assertFalse(Prime.isPrimeSol(9));
        assertFalse(Prime.isPrimeSol(10));
    }

    function testIsPrimeFuzz(uint256 _num) public {
            assertEq(Prime.isPrimeSol(_num), Prime.isPrime(_num));
    }
}

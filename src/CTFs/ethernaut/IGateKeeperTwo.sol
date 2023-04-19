// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IGateKeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin, "TXORIGIN");
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0,"T2");
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max, "G3");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}
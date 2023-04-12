// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITelephone {
  function owner() view external returns(address);
  function changeOwner(address _owner) external;
}
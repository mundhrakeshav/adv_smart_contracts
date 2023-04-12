interface IOwnable {
    function owner() external view returns (address);
    function setOwner(address) external;
}

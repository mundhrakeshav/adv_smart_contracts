interface ISimpleWallet {
    event OwnerUpdated(address indexed, address indexed);

    function makeTx(address, uint256, bytes memory) external payable returns (uint256);
    function owner() external view returns (address);
    function setOwner(address) external;
}

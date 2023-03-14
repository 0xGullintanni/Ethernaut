// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Force/Force.sol";
import "../src/Force/Attack.sol";

contract ForceTest is Test {
    Attack internal attack;
    Force internal force;

    function setUp() public {
        force = new Force();
        attack = new Attack();
    }

    function testAttack() public {}
}
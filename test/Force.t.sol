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
        attack = new Attack(address(force));
    }

    function testAttack() public {
        vm.deal(address(attack), .1 ether);
        assertEq(address(force).balance, 0 ether);
        attack.attack{value: address(attack).balance }();
        assertEq(address(attack).balance, 0 ether);
        assertEq(address(force).balance, .2 ether); // selfdestruct returns half the gas of transacting to the target addr but wtf is it doubling?
    }
}
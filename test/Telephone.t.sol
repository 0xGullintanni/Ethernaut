// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Telephone/Telephone.sol";
import "../src/Telephone/Attack.sol";

contract TelephoneTest is Test {
    Attack internal attack;
    Telephone internal telephone;
    AttackProxy internal ap;

    address internal bob = address(0x1);

    function setUp() public {
        telephone = new Telephone();
        ap = new AttackProxy(address(telephone));
        attack = new Attack(address(ap));
    }

    function testAttack() public {
        assertEq(telephone.owner(), address(this));
        vm.pauseGasMetering();
        attack.attack();
        vm.resumeGasMetering();
        assertEq(telephone.owner(), address(attack));
      
    }
}
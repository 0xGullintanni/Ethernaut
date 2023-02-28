// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Fallback/Fallback.sol";
import "../src/Fallback/Attack.sol";

contract FallbackTest is Test {
    Attack internal attack;
    Fallback internal _fallback;

    function setUp() public {
        _fallback = new Fallback();
        attack = new Attack(address(_fallback));
    }

    function testAttack() public {
        vm.deal(address(attack), .1 ether);
        vm.deal(address(_fallback), 100 ether); // Establish the honeypot

        assertEq(address(attack).balance, .1 ether);
        assertEq(address(_fallback).balance, 100 ether);
        
        assertEq(_fallback.owner(), address(this));
        vm.pauseGasMetering(); // We will reach out of gas errors on external calls without this
        attack.takeControlOfTarget{value: .0005 ether}();
        vm.resumeGasMetering(); // Turn gas back on

        assertEq(_fallback.contributions(address(attack)), .0001 ether);
        assertEq(_fallback.owner(), address(attack));
        assertGe(address(attack).balance, 100 ether);
    }
}

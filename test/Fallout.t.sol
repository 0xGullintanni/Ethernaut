// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Fallout/Fallout.sol";
import "../src/Fallout/Attack.sol";

contract FalloutTest is Test {
    Attack internal attack;
    Fallout internal fallout;

    function setUp() public {
        fallout = new Fallout();
        attack = new Attack(address(fallout));
    }

    function testAttack() public {
        vm.deal(address(attack), .1 ether);
        
        assertEq(fallout.owner(), payable(address(0))); // "Constructor" has different name than contract and isnt called
        vm.pauseGasMetering(); // We will reach out of gas errors on external calls without this
        attack.attack{value: .0005 ether}();
        vm.resumeGasMetering(); // Turn gas back on

        assertEq(fallout.owner(), address(attack));
    }
}

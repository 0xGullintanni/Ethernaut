// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Token/Token.sol";
import "../src/Token/Attack.sol";

contract TokenTest is Test {
    Attack internal attack;
    Token internal token;

    address internal bob = address(0x1);

    function setUp() public {
        token = new Token(2000);
        attack = new Attack(address(token));

    }

    function testAttack() public {
        assertEq(token.balanceOf(address(this)), 2000);
        assertEq(token.balanceOf(address(attack)), 20);
        attack.attack();
        assertEq(token.balanceOf(address(this)), 0);
        assertEq(token.balanceOf(address(attack)), 2000);
    }
}
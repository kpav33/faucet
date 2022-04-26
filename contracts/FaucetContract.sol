// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {

  // Create an array of addresses (20 byte address format)
  // private -> can be accesible only within the smart contract
  // internal -> can be accesible within smart contract and also derived smart contract
  // address[] public funders;
  // address[] private funders;

    uint public numOfFunders;
    // mapping(uint => address) private funders;
    mapping(address => bool) private funders;
    mapping(uint => address) private lutFunders;


    modifier limitWithdraw(uint withdrawAmount) {
      require(withdrawAmount <= 100000000000000000, "Cannot withdraw more than 0.1 ether");
      _;
    }

  // this is a special function
  // it's called when you make a transaction that doesn't specify
  // function name to call

  // External functions are part of the contract interface
  // which means they can be called via contracts and other transactions

    receive() external payable {}

    // Payable functions can process transactions
    function addFunds() external payable {
      // Push the senders address into the funders array
      // funders.push(msg.sender);
      // uint index = numOfFunders++;
      // funders[index] = msg.sender;
      address funder = msg.sender;

      if (!funders[funder]) {
        numOfFunders++;
        uint index = numOfFunders++;
        funders[funder] = true;
        lutFunders[index] = funder;
      }
    }

    
    // function withdraw(uint withdrawAmount) external {
    //   // if (withdrawAmount < 1000000000000000000) {
    //   //   payable(msg.sender).transfer(withdrawAmount);
    //   // }
    //   require(withdrawAmount <= 100000000000000000, "Cannot withdraw more than 0.1 ether");
    //   payable(msg.sender).transfer(withdrawAmount);
    // }

    function withdraw(uint withdrawAmount) external limitWithdraw(withdrawAmount) {
      payable(msg.sender).transfer(withdrawAmount);
    }

    function getAllFunders() external view returns (address[] memory) {
      address[] memory _funders = new address[](numOfFunders);

      for (uint i = 0; i < numOfFunders; i++) {
        _funders[i] = lutFunders[i];
      }

      return _funders;
    }

    function getFunderAtIndex(uint8 index) external view returns(address) {
      return lutFunders[index];
    }

    
    // function getAllFunders() external view returns (address[] memory) {
    //   address[] memory _funders = new address[](numOfFunders);

    //   for (uint i = 0; i < numOfFunders; i++) {
    //     _funders[i] = funders[i];
    //   }

    //   return _funders;
    // }

    // External function that views value in contract storage and returns it
    // You can't call functions marked as external from inside of the smart contract
    // function getAllFunders() external view returns (address[] memory) {
    //   return funders;
    // }

    // Functions marked as public cant be called by other functions inside of the smart contract
    // Use external for functions that you expect to only call from outside of the smart contract
    // Use public for functions that you expect to call from inside and outside of the smart contract
    // function getAllFunders() public view returns (address[] memory) {
    //   return funders;
    // }

    // function getFunderAtIndex(uint8 index) external view returns (address) {
    //   // address[] memory _funders = getAllFunders();
    //   // return _funders[index];
    //   return funders[index];
    // }
}

// const instance = await Faucet.deployed();
// instance.addFunds({from: accounts[0], value: "2000000000000000000"})
// instance.addFunds({from: accounts[1], value: "2000000000000000000"})
// instance.withdraw("500000000000000000", {from: accounts[1]})
// instance.getFunderAtIndex(0)
// instance.getAllFunders()

 // const instance = await Faucet.deployed()
 // instance.addFunds({ from: accounts[0], value: "2" })

// Block info
// Nonce - a hash that when combined with the minHash proofs that
// the block has gone through proof of work(POW)
// 8 bytes => 64 bits
// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LearnStructs {
    struct Customer {
        string firstName;
        string lastName;
        uint64 lastOrderId;
    }

    Customer[] public customers;

    function insertCustomer(
        string memory _firstName,
        string memory _lastName,
        uint64 _lastOrderId
    ) public {
        customers.push(
            Customer(
                _firstName,
                _lastName,
                _lastOrderId
            )
        );
    }
}
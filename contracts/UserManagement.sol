//SPDX-License-Identifier: Unlicense
pragma solidity 0.7.6;

import "./interfaces/IUserManagement.sol";

contract UserManagement is IUserManagement {
    mapping(address => bool) admins;

    modifier onlyAdmin() {
        require(
            isAdmin(msg.sender),
            "You can not perform this action"
        );
        _;
    }

    constructor() {
        admins[msg.sender] = true;
    }

    function isAdmin(address _subject) public view override returns (bool) {
        return admins[_subject];
    }

    function addAdmin(address _subject) external onlyAdmin {
        admins[_subject] = true;
    }

    function removeAdmin(address _subject) external onlyAdmin {
        admins[_subject] = false;
    }
}

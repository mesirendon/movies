//SPDX-License-Identifier: Unlicense
pragma solidity 0.7.6;

import "./interfaces/IUserManagement.sol";
import "./interfaces/IMovie.sol";

contract Tender {
    address owner;
    address userManagementAddress;

    mapping(address => bool) public movieAdresses;

    modifier onlyAdmin() {
        require(
            IUserManagement(userManagementAddress).isAdmin(msg.sender),
            "You can not perform this action"
        );
        _;
    }

    constructor(address _userManagementAddress) {
        owner = msg.sender;
        userManagementAddress = _userManagementAddress;
    }

    function addMovie(address _movieAddress) external onlyAdmin {
        require(
            IMovie(_movieAddress).isActive(),
            "The movie is not active yet"
        );
        movieAdresses[_movieAddress] = true;
    }
}

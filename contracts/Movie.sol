//SPDX-License-Identifier: Unlicense
pragma solidity 0.7.6;

import "./Constants.sol";
import "./interfaces/IMovie.sol";
import "./interfaces/IUserManagement.sol";

contract Movie is Constants, IMovie {
    struct Milestone {
        uint256 timestamp;
        bool active;
        Error error;
    }

    address owner;
    address userManagementAddress;
    string public name;

    mapping(uint256 => Milestone) milestones;

    modifier onlyAdmin() {
        require(
            IUserManagement(userManagementAddress).isAdmin(msg.sender),
            "You can not perform this action"
        );
        _;
    }

    constructor(address _userManagementAddress, string memory _name) {
        owner = msg.sender;
        userManagementAddress = _userManagementAddress;
        name = _name;
        milestones[0] = Milestone({
            timestamp: block.timestamp + 1000,
            active: false,
            error: Error.NO_ERROR
        });
    }

    function isActive()
        public
        view
        override
        returns (bool active)
    {
        Milestone storage m = milestones[0];
        active = m.active;
    }

    function activateMovie() external onlyAdmin {
        milestones[0].active = true;
    }
}

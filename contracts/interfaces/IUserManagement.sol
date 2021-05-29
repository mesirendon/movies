//SPDX-License-Identifier: Unlicense
pragma solidity 0.7.6;

interface IUserManagement {
    function isAdmin(address _subject) external view returns(bool);
}
//SPDX-License-Identifier: Unlicense
pragma solidity 0.7.6;

interface IMovie {
    function isActive() external view returns (bool active);
}
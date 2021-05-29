// We require the Hardhat Runtime Environment explicitly here. This is optional 
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
const { ethers } = require('hardhat');

async function main() {
  const [
    owner,
    admin,
  ] = await ethers.getSigners();

  const UserManagement = await ethers.getContractFactory('UserManagement');
  const userManagementResult = await UserManagement.deploy();
  const userManagement = await ethers.getContractAt('UserManagement', userManagementResult.address);
  await userManagement.addAdmin(admin.address);

  const Tender = await ethers.getContractFactory('Tender');
  const tenderResult = await Tender.deploy(userManagementResult.address);
  const tender = await ethers.getContractAt('Tender', tenderResult.address);

  const Movie = await ethers.getContractFactory('Movie');
  const movieOneResult = await Movie.deploy(userManagementResult.address, 'Star wars');

  setTimeout(() => console.log('Ready'), 1100);
  await movieOneResult.activateMovie();
  await tender.addMovie(movieOneResult.address);
  console.log(await tender.movieAdresses(movieOneResult.address));
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });

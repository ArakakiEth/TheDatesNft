const hre = require("hardhat");

async function main() {
  const deployContract = async (contractName, libraries) => {
    const factory = await hre.ethers.getContractFactory(contractName, {
      libraries: (libraries || {}),
    });

    const contract = await factory.deploy();

    await contract.deployed();

    return contract;
  };

  const validator = await deployContract("Validator");

  const image = await deployContract("Image");

  const tokenTrait = await deployContract("TokenTrait", {
    "Image": image.address,
    "Validator": validator.address,
  });

  const nft = await deployContract("TheDatesNft", {
    "TokenTrait": tokenTrait.address,
  });
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error({
      error: err,
    });

    process.exit(1);
  });

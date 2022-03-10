const {
  expect,
} = require("chai");

const {
  ethers,
} = require("hardhat");

describe("TheDatesNft", () => {
  let contract;
  let signers;

  beforeEach(async () => {
    signers = await ethers.getSigners();

    const deployContract = async (contractName, libraries) => {
      const factory = await ethers.getContractFactory(contractName, {
        signer: signers[0],
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

    contract = await deployContract("TheDatesNft", {
      "TokenTrait": tokenTrait.address,
    });
  });

  it("can be claimed only by contract owner by default", async () => {
    await contract.deployed();

    for (const data of [
      { signer: signers[0], expectSuccess: true },
      { signer: signers[1], expectSuccess: false },
    ]) {
      const result = await contract.connect(data.signer).claim().catch((err) => {
        return err;
      });

      if (data.expectSuccess) {
        expect(result).not.to.be.an.instanceof(Error, JSON.stringify({ data }));
      } else {
        expect(result).to.be.an.instanceof(Error, JSON.stringify({ data }));
      }
    }
  });

  it("can be claimed when set as claimable.", async () => {
    await contract.deployed();

    await contract.setIsClaimable(true);

    const result = await contract.connect(signers[1]).claim().catch((err) => {
      return err;
    });

    expect(result).not.to.be.an.instanceof(Error);
  });

  it("should increment token id after claiming", async () => {
    await contract.deployed();

    for (let claimCount = 1; claimCount <= 5; claimCount++) {
      await contract.claim();

      const tokenId = await contract.getCurrentTokenId();

      expect(tokenId).to.equal(claimCount.toString(10));
    }
  });

  it("should return date by token id", async () => {
    await contract.deployed();

    await contract.claim();

    const tokenId = await contract.getCurrentTokenId();

    await contract.setDate(tokenId, "20220305");

    const date = await contract.getDate(tokenId);

    expect(date).to.equal("20220305");
  });

  it("should be able to set date only from the token owner", async () => {
    await contract.deployed();

    const signers = await ethers.getSigners();

    await contract.connect(signers[0]).claim();

    const tokenId = await contract.getCurrentTokenId();

    const result = await contract.connect(signers[1]).setDate(tokenId, "20220305").catch((err) => {
      return err;
    });

    expect(result).to.be.an.instanceof(Error);
  });

  it("should be able to set date only once", async () => {
    await contract.deployed();

    const signers = await ethers.getSigners();

    await contract.connect(signers[0]).claim();

    const tokenId = await contract.getCurrentTokenId();

    await contract.connect(signers[0]).setDate(tokenId, "20220305");

    const result = await contract.connect(signers[0]).setDate(tokenId, "20220305").catch((err) => {
      return err;
    });

    expect(result).to.be.an.instanceof(Error);
  });

  it("should accept only yyyyMMdd format date", async () => {
    await contract.deployed();

    for (const data of [
      { dateString: "abcdefgh", isValid: false },
      { dateString: "2022123", isValid: false },
      { dateString: "2022001023", isValid: false },
      { dateString: "20220131", isValid: true },
      { dateString: "20220132", isValid: false },
      { dateString: "20220229", isValid: false },
      { dateString: "20200229", isValid: true },
      { dateString: "20000229", isValid: false },
      { dateString: "20220331", isValid: true },
      { dateString: "20220332", isValid: false },
      { dateString: "20220430", isValid: true },
      { dateString: "20220431", isValid: false },
      { dateString: "20220531", isValid: true },
      { dateString: "20220532", isValid: false },
      { dateString: "20220630", isValid: true },
      { dateString: "20220631", isValid: false },
      { dateString: "20220731", isValid: true },
      { dateString: "20220732", isValid: false },
      { dateString: "20220831", isValid: true },
      { dateString: "20220832", isValid: false },
      { dateString: "20220930", isValid: true },
      { dateString: "20220931", isValid: false },
      { dateString: "20221031", isValid: true },
      { dateString: "20221032", isValid: false },
      { dateString: "20221130", isValid: true },
      { dateString: "20221131", isValid: false },
      { dateString: "20221231", isValid: true },
      { dateString: "20221232", isValid: false },
    ]) {
      await contract.claim();

      const tokenId = await contract.getCurrentTokenId();

      const result = await contract.setDate(tokenId, data.dateString).catch((err) => {
        return err;
      });

      if (data.isValid) {
        expect(result).not.to.be.an.instanceof(Error, JSON.stringify(data));
      } else {
        expect(result).to.be.an.instanceof(Error, JSON.stringify(data));
      }
    }
  });

  it("should not have duplicated date", async () => {
    await contract.deployed();

    for (let count = 0; count < 5; count++) {
      await contract.claim();

      const tokenId = await contract.getCurrentTokenId();

      const result = await contract.setDate(tokenId, "20220305").catch((err) => {
        return err;
      });

      if (count === 0) {
        expect(result).not.to.be.an.instanceof(Error);
      } else {
        expect(result).to.be.an.instanceof(Error);
      }
    }
  });

  it("should be able to set message", async () => {
    await contract.deployed();

    await contract.claim();

    const tokenId = await contract.getCurrentTokenId();

    for (const data of [
      { requestMessage: "0123456789 abcd efgh ijkl mnop qrst uvwx yz.", expectedMessage: "0123456789 abcd efgh ijkl mnop qrst uvwx yz.      " },
      { requestMessage: "`1234567890-=~!@#$%^&*()_+", expectedMessage: " 1234567890   !                                   " },
    ]) {
      await contract.setMessage(tokenId, data.requestMessage)

      const message = await contract.getMessage(tokenId);

      expect(message).to.equal(data.expectedMessage);
    }
  });

  it("should be able to set color", async () => {
    await contract.deployed();

    for (const data of [
      { requestColors: ["#ffffff", "#ff3333", "#3333ff"], isValid: true, expectedColors: ["#ffffff", "#ff3333", "#3333ff"] },
      { requestColors: ["ffffff", "ff3333", "3333ff"], isValid: false, expectedColors: ["#edc271", "#e9435e", "#6868ac"] },
      { requestColors: ["#ffffff", "", ""], isValid: false, expectedColors: ["#edc271", "#e9435e", "#6868ac"] },
      { requestColors: ["#fff", "#f33", "#33f"], isValid: false, expectedColors: ["#edc271", "#e9435e", "#6868ac"] },
      { requestColors: [], isValid: false, expectedColors: ["#edc271", "#e9435e", "#6868ac"] },
    ]) {
      await contract.claim();

      const tokenId = await contract.getCurrentTokenId();

      const result = await contract.setColors(tokenId, data.requestColors).catch((err) => {
        return err;
      });

      if (data.isValid) {
        expect(result).not.to.be.an.instanceof(Error, JSON.stringify({ data }));
      } else {
        expect(result).to.be.an.instanceof(Error, JSON.stringify({ data }));
      }

      const colors = await contract.getColors(tokenId);

      expect(colors).to.eql(data.expectedColors);
    }
  });

  it("should serve token uri", async () => {
    await contract.deployed();

    await contract.claim();

    const tokenId = await contract.getCurrentTokenId();

    await contract.setDate(tokenId, "20220309");
    await contract.setMessage(tokenId, "TheDates  NFT       to send   your love.");
    await contract["safeTransferFrom(address,address,uint256)"](signers[0].address, signers[1].address, tokenId);

    const tokenUri = await contract.tokenURI(tokenId);

    const tokenUriData = JSON.parse(tokenUri);

    console.log(tokenUri);
  });
});


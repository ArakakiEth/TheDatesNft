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
    const colorLibFactory = await ethers.getContractFactory("Color");

    const colorLib = await colorLibFactory.deploy();

    await colorLib.deployed();

    const numberLibFactory = await ethers.getContractFactory("Number");

    const numberLib = await numberLibFactory.deploy();

    await numberLib.deployed();

    const dateLibFactory = await ethers.getContractFactory("Date");

    const dateLib = await dateLibFactory.deploy();

    await dateLib.deployed();

    const imageLibFactory = await ethers.getContractFactory("Image", {
      libraries: {
        // "Number": numberLib.address,
      },
    });

    const imageLib = await imageLibFactory.deploy();

    await imageLib.deployed();

    const messageLibFactory = await ethers.getContractFactory("Message");

    const messageLib = await messageLibFactory.deploy();

    await messageLib.deployed();

    const contractFactory = await ethers.getContractFactory("TheDatesNft", {
      libraries: {
        "Color": colorLib.address,
        "Date": dateLib.address,
        "Image": imageLib.address,
        "Message": messageLib.address,
        "Number": numberLib.address,
      },
    });

    contract = await contractFactory.deploy();

    await contract.deployed();

    signers = await ethers.getSigners();
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

      const tokenId = await contract.currentTokenId();

      console.log(claimCount, tokenId);

      expect(tokenId).to.equal(claimCount.toString(10));
    }
  });

  it("should return date by token id", async () => {
    await contract.deployed();

    await contract.claim();

    const tokenId = await contract.currentTokenId();

    await contract.setDate(tokenId, "20220305");

    const date = await contract.date(tokenId);

    expect(date).to.equal("20220305");
  });

  it("should accept request to set date only from the token owner", async () => {
    await contract.deployed();

    const signers = await ethers.getSigners();

    await contract.connect(signers[0]).claim();

    const tokenId = await contract.currentTokenId();

    const result = await contract.connect(signers[1]).setDate(tokenId, "20220305").catch((err) => {
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

      const tokenId = await contract.currentTokenId();

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

  it("should not be able to reset date", async () => {
    await contract.deployed();

    await contract.claim();

    const tokenId = await contract.currentTokenId();

    await contract.setDate(tokenId, "20220305");

    const result = await contract.setDate(tokenId, "20220406").catch((err) => {
      return err;
    });

    expect(result).to.be.an.instanceof(Error);
  });

  it("should not have duplicated date", async () => {
    await contract.deployed();

    await contract.claim();

    const tokenId1 = await contract.currentTokenId();

    await contract.setDate(tokenId1, "20220305");

    await contract.claim();

    const tokenId2 = await contract.currentTokenId();

    const result = await contract.setDate(tokenId2, "20220305").catch((err) => {
      return err;
    });

    expect(result).to.be.an.instanceof(Error);
  });

  it("should be able to set message", async () => {
    await contract.deployed();

    await contract.claim();

    const tokenId = await contract.currentTokenId();

    for (const data of [
      { requestMessage: "0123456789 abcd efgh ijkl mnop qrst uvwx yz.", expectedMessage: "0123456789 abcd efgh ijkl mnop qrst uvwx yz.      " },
      { requestMessage: "`1234567890-=~!@#$%^&*()_+", expectedMessage: " 1234567890                                       " },
    ]) {
      await contract.setMessage(tokenId, data.requestMessage)

      const message = await contract.message(tokenId);

      expect(message).to.equal(data.expectedMessage);
    }
  });

  it("should be able to set color", async () => {
    await contract.deployed();

    await contract.claim();

    const tokenId = await contract.currentTokenId();

    await contract.setColors(tokenId, [
      "#ffffff",
      "#ff3333",
      "#3333ff",
    ]);

    const colors = await contract.colors(tokenId);

    expect(message).to.equal(data.expectedMessage);
  });

  it("should serve token uri", async () => {
    await contract.deployed();

    await contract.claim();

    const tokenId = await contract.currentTokenId();

    const tokenUri = await contract.tokenURI(tokenId);

    // console.log({ tokenUri });
  });
});


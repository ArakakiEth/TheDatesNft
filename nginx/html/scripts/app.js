class App extends EventTarget {
  constructor(config) {
    super();

    this.config = config;

    this.contracts = {};

    this.userAddress = null;
  }

  async requestWallet() {
    if (this.config?.ethereum) {
      this.config.ethereum.on("chainChanged", (networkId) => {
        this.dispatchEvent(new CustomEvent("ChainChanged"));
      });

      const accounts = await ethereum.request({
        method: "eth_requestAccounts",
      }).catch((err) => {
        console.error({ error: err });

        return [];
      });

      if (!accounts[0]) {
        return this.dispatchEvent(new CustomEvent("WalletRequestFailed"));
      }

      this.userAddress = accounts[0];

      return this.dispatchEvent(new CustomEvent("WalletRequestSucceeded"));
    } else {
      return this.dispatchEvent(new CustomEvent("WalletRequestFailed"));
    }
  }

  async requestPolygonNetwork() {
    if (this.config?.ethereum?.chainId === "0x89") {
      return this.dispatchEvent(new CustomEvent("NetworkRequestSucceeded"));
    }

    const err = await this.config?.ethereum?.request({
      method: "wallet_switchEthereumChain",
      params: [
        {
          chainId: "0x89",
        },
      ],
    }).catch((err) => {
      return err;
    });

    if (!err) {
      return this.dispatchEvent(new CustomEvent("NetworkRequestSucceeded"));
    } else {
      return this.dispatchEvent(new CustomEvent("NetworkRequestFailed"));
    }
  }

  async getTheDatesNftContract() {
    if (this.contracts.TheDatesNft) {
      return this.dispatchEvent(new CustomEvent("TheDatesNftContractGetSucceeded"));
    }

    const abiResponse = await fetch("../data/the-dates-nft-abi.json");

    if (!abiResponse.ok) {
      return this.dispatchEvent(new CustomEvent("TheDatesNftContractGetFailed"));
    }

    const abi = await abiResponse.json();

    this.contracts.TheDatesNft = new (this.config?.web3).eth.Contract(abi, this.config?.contractAddresses?.TheDatesNft);

    return this.dispatchEvent(new CustomEvent("TheDatesNftContractGetSucceeded"));
  }
}


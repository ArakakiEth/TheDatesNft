class App extends EventTarget {
  constructor(config) {
    super();

    this.config = config;

    this.contract = {};

    const walletAvailable = this.checkWallet();

    if (walletAvailable) {
      this.requestPolygonNetwork();

      this.config?.ethereum?.on("networkChanged", (networkId) => {
        this.dispatchEvent(new CustomEvent("NetworkChanged"));
      });
    }
  }

  checkWallet() {
    if (this.config?.ethereum) {
      this.dispatchEvent(new CustomEvent("WalletCheckSucceeded"));

      return true;
    } else {
      this.dispatchEvent(new CustomEvent("WalletCheckFailed"));

      return false;
    }
  }

  async requestPolygonNetwork() {
    if (this.config?.ethereum?.chainId === "0x89") {
      return this.dispatchEvent(new CustomEvent("NetworkCheckSucceeded"));
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
      return this.dispatchEvent(new CustomEvent("NetworkCheckSucceeded"));
    } else {
      return this.dispatchEvent(new CustomEvent("NetworkCheckFailed"));
    }
  }

  async getTheDatesNftContract() {
    const abiResponse = await fetch("../data/the-dates-nft-abi.json");

    if (!abiResponse.ok) {
      return this.dispatchEvent(new CustomEvent("TheDatesNftContractGetFailed"));
    }

    const abi = await abiResponse.json();

    const web3 = this.config?.web3;

    this.contract.TheDatesNft = new web3.eth.Contract(abi, this.config?.contractAddresses?.TheDatesNft);

    return this.dispatchEvent(new CustomEvent("TheDatesNftContractGetSucceeded"));
  }
}


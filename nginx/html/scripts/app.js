class App extends EventTarget {
  constructor() {
    super();

    const walletAvailable = this.checkWallet();

    if (walletAvailable) {
      this.requestPolygonNetwork();

      ethereum.on("networkChanged", (networkId) => {
        this.dispatchEvent(new CustomEvent("NetworkChanged"));
      });
    }
  }

  checkWallet() {
    if ("ethereum" in window) {
      this.dispatchEvent(new CustomEvent("WalletCheckSucceeded"));

      return true;
    } else {
      this.dispatchEvent(new CustomEvent("WalletCheckFailed"));

      return false;
    }
  }

  async requestPolygonNetwork() {
    if (ethereum.chainId === "0x89") {
      return this.dispatchEvent(new CustomEvent("NetworkCheckSucceeded"));
    }

    const err = await ethereum.request({
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
}


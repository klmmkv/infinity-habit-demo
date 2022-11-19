import { ethers } from 'ethers'
import { toast } from 'react-toastify'

const networkId = process.env.NEXT_PUBLIC_NETWORK_ID || "31337";
const networks: Record<string, string> = {
  1: "Mainnet",
  3: "Ropsten",
  4: "Rinkeby",
  5: "Goerli",
  42: "Kovan",
  1337: "localhost",
  31337: "localhost",
  11155111: "Sepolia",
};
const networkName = networks[networkId];

export const getEthereumObject = () => {
  const { ethereum } = window as any;
  if (!ethereum) return null;

  if (ethereum.networkVersion !== networkId) {
    // toast.error(`Please switch to the ${networkName} network.`);
    console.log(ethereum.networkVersion);
    console.log(networkId);
    return null;
  }

  return ethereum;
};

export const setupEthEventListeners = (eth: any) => {
  const provider = new ethers.providers.Web3Provider(eth, "any");

  provider.on("network", (_newNetwork, oldNetwork) => {
    if (oldNetwork) {
      window.location.reload();
    }
  });

  (window as any).ethereum.on("accountsChanged", () => {
    window.location.reload();
  });

  return eth;
};

export const getCurrentAccount = async () => {
  const { ethereum } = window as any;
  const accounts = await ethereum.request({
    method: "eth_accounts",
  });

  if (!accounts || accounts.length === 0) {
    return null;
  }

  const account = accounts[0];
  return account;
};

export const connectWallet = async () => {
  const { ethereum } = window as any;
  if (!ethereum) {
    toast.info("Please install Metamask.");
  }

  await ethereum.request({
    method: "eth_requestAccounts",
  });
  location.reload();
};

export const getSignedContract = (address: string, abi: any) => {
  const { ethereum } = window as any;

  const provider = new ethers.providers.Web3Provider(ethereum, "any");

  const signer = provider.getSigner();
  return new ethers.Contract(address, abi, signer);
};

export const getAccountBalance = async (address: string) => {
  const { ethereum } = window as any;

  const provider = new ethers.providers.Web3Provider(ethereum, "any");

  const signer = provider.getSigner(address);
  return await signer.getBalance();
};

// @ts-ignore
import { ethers } from 'ethers'
import React, { useState } from 'react'
import { getAccountBalance } from 'utils/common'
import { useAccount, useContracts } from 'utils/context'

// import { useInterval } from "../utils/hooks";

type Props = {
  address: string;
};

export default function Balance({ address }: Props) {
  // const account = useAccount();
  // const { campContract } = useContracts();

  const [balance, setBalance] = useState("...");

  // const loadBalance = async () => {
  //   try {
  //     const userBalance = await campContract.balanceOf(account);
  //     const balance = parseInt(userBalance._hex, 16);
  //     const formattedBalance = Intl.NumberFormat("en-US", {
  //       notation: "compact",
  //       maximumFractionDigits: 1,
  //     }).format(balance / 1000000000000000000);
  //     setBalance(formattedBalance);
  //   } catch (e) {}
  // };

  // useInterval(() => {
  //   loadBalance();
  // }, 1000);

  React.useEffect(() => {
    async function getBalance() {
      const balance = await getAccountBalance(address);
      setBalance(ethers.utils.formatEther(balance).slice(0, 12));
    }

    getBalance();
  }, [address]);

  return (
    <p className="text-transparent text-sm bg-clip-text bg-gradient-to-r from-pink-500 to-orange-400 font-semibold">
      {balance}
    </p>
  );
}

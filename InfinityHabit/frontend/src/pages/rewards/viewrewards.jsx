import React, { useState, useEffect, useContext } from "react";

import Layout from "components/Layout";
import Link from "next/link";

import { useAccount, useContracts } from "contexts";

export default function Rewards() {
  const [rewards, setRewards] = useState([])

  const { habitContract } = useContracts();
  const account = useAccount();

  const loadRewards = async () => {
    let rewards = [];
    console.log({habitContract});
    if (!habitContract) return;
    try{
        const reward = await habitContract.viewPointBalances(account);
        console.log(reward);
        rewards.push(reward);
      }
      catch(e){
        console.log("Error occured");
      }
    setRewards(rewards)
    }

  useEffect(() => {
    loadRewards();
  }, [account]);

  return <div className="p-4">{rewards.map((reward) => 
    <div className="my-4">
      <h2>Congratualtions! You have accumulated a total of</h2>
      <h1 className="font-bold">{parseInt(reward._hex,16)} Hera</h1>
    </div>)}
    </div>;
}

Rewards.getLayout = function getLayout(page) {
  return <Layout>{page}</Layout>;
};

import React, { useState, useEffect, useContext } from "react";

import Layout from "components/Layout";
import Link from "next/link";

import { useAccount, useContracts } from "contexts";

export default function Home() {
  const [communities, setCommunities] = useState([])

  const { habitContract } = useContracts();
  const account = useAccount();

  const loadCommunities = async () => {
    let communities = []
    for (let i = 0; i < 10; i++) {
      try{
        const community = await habitContract.communities(i);
        communities.push(community)
      }
      catch(e){
        break;
      }
    }
    setCommunities(communities)
    }

  useEffect(() => {
    loadCommunities();
  }, [account]);

  return <div className="p-4">{communities.map((community) => 
    <div className="my-4">
      <h1 className="font-bold">{community.name}</h1>
      <h2>{community.description}</h2>
      <u><Link href={`/communities/${community.indexKey}/challenges`}>View challenge</Link></u>
    </div>)}
    </div>;
}

Home.getLayout = function getLayout(page) {
  return <Layout>{page}</Layout>;
};

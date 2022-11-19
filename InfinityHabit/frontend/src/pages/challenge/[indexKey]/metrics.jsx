import React, { useState, useEffect, useContext } from "react";
import { useRouter } from "next/router";
import Link from "next/link";

import Layout from "components/Layout";
import { useAccount, useContracts } from "contexts";

export default function Metrics() {
  const router = useRouter();
  const indexKey = router.query.indexKey;

  if(indexKey == null || indexKey == undefined){
    return <></>
  }

  const challengeId = parseInt(indexKey)

  const [metrics, setMetrics] = useState([]);

  const { habitContract } = useContracts();
  const account = useAccount();

  const load = async () => {
    let metrics = [];
    for (let i = 0; i < 100; i++) {
      try {
        const metric = await habitContract.metrics(i);
        const metricChallengeId = parseInt(metric.challengeId._hex, 16)
        if (challengeId == metricChallengeId) {
            metrics.push(metric);
        }
      } catch (e) {
        break;
      }
    }
    setMetrics(metrics);
  };

 /* const enrollIntoChallenge = async(challengeId, cohortId) => {
    const txn = await habitContract.enrollIntoChallenge(challengeId, cohortId)
    await txn.wait();
    console.log("Succesfully enrolled into challenge with challengeId", challengeId)
  }*/

  useEffect(() => {
    load();
  }, [account]);

  return (
    <div className="p-4">
      <b><h1>View Metrics</h1></b>  
      {metrics.map((metric) => (
        <div className="my-4">
          <h1 className="font-bold">{metric.name}</h1>
          <h2>{metric.description}</h2>
          <h2>Points : {parseInt(metric.metricPoints._hex,16)}</h2>
        </div>
      ))}
    </div>
  );
}

Metrics.getLayout = function getLayout(page) {
  return <Layout>{page}</Layout>;
};

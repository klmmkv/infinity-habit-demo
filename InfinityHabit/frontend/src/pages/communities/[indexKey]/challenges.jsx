import React, { useState, useEffect, useContext } from "react";
import { useRouter } from "next/router";
import Link from "next/link";

import Layout from "components/Layout";
import { useAccount, useContracts } from "contexts";

export default function Challenges() {
  const router = useRouter();
  const indexKey = router.query.indexKey;

  if(indexKey == null || indexKey == undefined){
    return <></>
  }

  const communityId = parseInt(indexKey)

  const [challenges, setChallenges] = useState([]);

  const { habitContract } = useContracts();
  const account = useAccount();

  const load = async () => {
    let challenges = [];
    for (let i = 0; i < 100; i++) {
      try {
        const challenge = await habitContract.challenges(i);
        const challengeCommunityId = parseInt(challenge.communityId._hex, 16)
        if (communityId == challengeCommunityId) {
          challenges.push(challenge);
        }
      } catch (e) {
        break;
      }
    }
    setChallenges(challenges);
  };

  const enrollIntoChallenge = async(challengeId, cohortId) => {
    const txn = await habitContract.enrollIntoChallenge(challengeId, cohortId)
    await txn.wait();
    console.log("Succesfully enrolled into challenge with challengeId", challengeId)
  }

  useEffect(() => {
    load();
  }, [account]);

  return (
    <div className="p-4">
      {challenges.map((challenge) => (
        <div className="my-4">
          <h1 className="font-bold">{challenge.name}</h1>
          <h2>{challenge.description}</h2>
          <button
            onClick={() => enrollIntoChallenge(parseInt(challenge.indexKey._hex, 16), 0)}
          >
            <u>Join challenge </u>
          </button>
          <Link href={`/challenge/${challenge.indexKey}/metrics`}><u>  View Metrics</u></Link>
        </div>
      ))}
    </div>
  );
}

Challenges.getLayout = function getLayout(page) {
  return <Layout>{page}</Layout>;
};

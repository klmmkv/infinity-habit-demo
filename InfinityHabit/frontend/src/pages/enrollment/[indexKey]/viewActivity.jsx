import React, { useState, useEffect, useContext } from "react";
import { useRouter } from "next/router";
import Link from "next/link";

import Layout from "components/Layout";
import { useAccount, useContracts } from "contexts";

export default function Activities() {
  const router = useRouter();
  const indexKey = router.query.indexKey;

  if(indexKey == null || indexKey == undefined){
    return <></>
  }

  const enrollmentId = parseInt(indexKey)

  const [activities, setActivities] = useState([]);

  const { habitContract } = useContracts();
  const account = useAccount();

  const load = async () => {
    let activities = [];
    console.log({habitContract});
    if (!habitContract) return;

    for (let i = 0; i < 100; i++) {
      try {
        const image = await habitContract.images(i);
        const key = parseInt(image.enrollmentId._hex, 16)
        if (enrollmentId == key) {
            activities.push(image);
        }
      } catch (e) {
        break;
      }
    }
    console.log({activities})
    setActivities(activities);
  };

/*  const enrollIntoChallenge = async(challengeId, cohortId) => {
    const txn = await habitContract.enrollIntoChallenge(challengeId, cohortId)
    await txn.wait();
    console.log("Succesfully enrolled into challenge with challengeId", challengeId)
  }

*/
  const validateActivity = async(key) => {
    const txn = await habitContract.validateActivity(key)
    await txn.wait();
    console.log("Succesfully validated the activity")
  }


  useEffect(() => {
    load();
  }, [account]);

  return (
    <div className="p-4">
      {activities.map((activity) => (
        <div className="my-4">
          <h1 className="font-bold">{activity.title}</h1>
          <h2>{activity.description}</h2>
          <span><h2>Validated - {activity.isValidated && (<span> Yes</span>)} </h2></span>
          <button
            onClick={() =>  validateActivity(parseInt(activity.keyIndex._hex,16)) }
          >
            <u>Validate Activity </u>
          </button>
        </div>
      ))}
    </div>
  );
}

Activities.getLayout = function getLayout(page) {
  return <Layout>{page}</Layout>;
};

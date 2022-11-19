import React, { useState, useEffect, useContext } from "react";
import { useRouter } from "next/router";
import Link from "next/link";

import Layout from "components/Layout";
import { useAccount, useContracts } from "contexts";

export default function Enrollments() {
  const router = useRouter();
  const indexKey = router.query.indexKey;

  if(indexKey == null || indexKey == undefined){
    return <></>
  }

 // const challengeId = parseInt(indexKey)

  const [enrollments, setEnrollments] = useState([]);

  const [challenges, setChallenges] = useState([]);

  const { habitContract } = useContracts();
  const account = useAccount();

  const load = async () => {
    let enrollmentrecords = [];
    let challenges = [];
    console.log({habitContract});
    if (!habitContract) return;
    const enrollments = await habitContract.viewEnrollmentsbyUser();
    console.log({enrollments});

    //console.log(enrollments);
    //await enrollments.wait();;   
    for (let i = 0; i < 50; i++) {
      try {
        const enrollment = await habitContract.enrollments(i);
        console.log(account, enrollment.user);

        if (enrollment.user.toLowerCase() == account.toLowerCase()){
            const challenge = await habitContract.challenges(parseInt(enrollment.challengeId._hex,16));
            enrollmentrecords.push(enrollment);
            challenges.push(challenge)
        }
      } catch (e) {
        break;
      }
    }
    console.log({enrollmentrecords});
    setEnrollments(enrollmentrecords);
    setChallenges(challenges);
    //setEnrollments(enrollments);

  };

   useEffect(() => {
    load();
  }, [account]);

  return (
    <div className="p-4">
      <b><h1>List of enrolled challenges </h1></b>  
      {enrollments.map((enrollment) => (
        <div className="my-4">
          <h2>{challenges[parseInt(enrollment.challengeId._hex,16)].name}</h2>
          <h2>{challenges[parseInt(enrollment.challengeId._hex,16)].description}</h2>
          <button
           // onClick={() => enrollIntoChallenge(parseInt(challenge.indexKey._hex, 16), 0)}
          >
            <u>Upload Activity </u>
          </button>


        </div>
      ))}
    </div>
  );
}

Enrollments.getLayout = function getLayout(page) {
  return <Layout>{page}</Layout>;
};

import '../styles/globals.css'
import 'react-toastify/dist/ReactToastify.css'

import Layout from 'components/Layout/layout'
import counterContractMetadata from 'data/abis/Counter.metadata.json'
import { Contract } from 'ethers'
import { NextPage } from 'next'
import Head from 'next/head'
import React, { ReactElement, ReactNode } from 'react'
import { ToastContainer } from 'react-toastify'
import {
  getCurrentAccount, getEthereumObject, getSignedContract, setupEthEventListeners
} from 'utils/common'
import { AccountContext, ContractsContext } from 'utils/context'

import type { AppProps } from "next/app";
export type NextPageWithLayout<P = {}, IP = P> = NextPage<P, IP> & {
  getLayout?: (page: ReactElement) => ReactNode;
};

type AppPropsWithLayout = AppProps & {
  Component: NextPageWithLayout;
};

export type ContractType = {
  counterContract: Contract | null;
};

const counterContractAddr = process.env.NEXT_PUBLIC_COUNTER_ADDRESS as string;

function MyApp({ Component, pageProps }: AppPropsWithLayout) {
  const getLayout = Component.getLayout || ((page) => page);
  const [account, setAccount] = React.useState("");
  const [contracts, setContracts] = React.useState<ContractType>({
    counterContract: null,
    // dcWarriorsContract: null,
    // stakingContract: null,
  });

  React.useEffect(() => {
    const load = async () => {
      const ethereum = getEthereumObject();
      if (!ethereum) return;

      setupEthEventListeners(ethereum);

      const counterContract = getSignedContract(
        counterContractAddr,
        counterContractMetadata
      );
      // const dcWarriorsContract = getSignedContract(
      //   dappCampWarriorsContractAddr,
      //   warriorsContractMetadata.output.abi
      // );

      // const stakingContract = getSignedContract(
      //   stakingContractAddr,
      //   stakingContractMetdata.output.abi
      // );

      // if (!campContract || !dcWarriorsContract || !stakingContract) return;

      const currentAccount = await getCurrentAccount();
      setContracts({ counterContract });
      setAccount(currentAccount);
    };

    load();
  }, []);

  return (
    <>
      <Head>
        <title>Infinite Habit</title>
        <meta name="viewport" content="initial-scale=1.0, width=device-width" />
      </Head>
      <AccountContext.Provider value={account}>
        <ContractsContext.Provider value={contracts}>
          <ToastContainer
            position="top-center"
            autoClose={5000}
            closeOnClick
            pauseOnFocusLoss
            draggable
            pauseOnHover
          />
          <Layout>{getLayout(<Component {...pageProps} />)}</Layout>
        </ContractsContext.Provider>
      </AccountContext.Provider>
    </>
  );
}

export default MyApp;

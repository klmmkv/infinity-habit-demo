import Layout from 'components/Layout/layout'
import Head from 'next/head'
import Image from 'next/image'
import Link from 'next/link'

import type { NextPage } from "next";

const Home: NextPage = () => {
  return (
    <>
      <Head>
        <title>Infinite Habit</title>
      </Head>
      <div className="bg-black h-full w-full flex-grow relative">
        <div className="w-full h-full opacity-20 absolute inset-0">
          <img
            src="https://images.unsplash.com/photo-1533134486753-c833f0ed4866?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80"
            alt="black abstract picture from Unsplash by Adrien Olichon"
            className="w-full h-full"
          />
        </div>

        <div className="absolute left-1/2 top-1/2 -translate-x-1/2">
          <button
            type="button"
            className="bg-gradient-to-br from-cyan-500 to-indigo-500 rounded-md text-lg font-semibold"
          >
            <Link
              href="/dashboard"
              className="h-full w-full py-4 px-12 block text-gray-100 text-2xl"
            >
              E X P L O R E
            </Link>
          </button>
        </div>

        <div className="absolute bottom-20 left-12">
          <h1 className="text-gray-300 text-6xl">
            Infinite <strong>Habit</strong>
          </h1>
          <p className="text-2xl text-gray-500">
            Make better habit, better life, better you!
          </p>
        </div>
      </div>
    </>
  );
};

export default Home;

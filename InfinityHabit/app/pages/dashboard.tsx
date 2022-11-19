import Layout from 'components/Layout/layout'
import Head from 'next/head'
import React from 'react'
import { AiOutlineUsergroupAdd } from 'react-icons/ai'

type Props = {};

const Dashboard = (props: Props) => {
  return (
    <>
      <Head>
        <title>Dashboard</title>
      </Head>
      <div className="flex-grow w-full p-20 text-gray-50 bg-gray-900">
        <div className="h-32">
          <h1 className="text-6xl font-extrabold uppercase text-center text-transparent bg-clip-text bg-gradient-to-l from-pink-500 to-indigo-400">
            Join Community
          </h1>
        </div>

        <div className="mt-8 flex items-center justify-center w-full">
          <table className="border-separate border-spacing-1 table-auto">
            <thead>
              <tr className="bg-gray-700">
                <th className="px-8 py-4">Community Name</th>
                <th className="px-8 py-4">Description</th>
                <th className="px-8 py-4">Metrics</th>
                <th className="px-8 py-4">Icon</th>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td className="px-8 py-4">Community Name</td>
                <td className="px-8 py-4">Description</td>
                <td className="px-8 py-4">Metrics</td>
                <td className="px-8 py-4">
                  <button
                    type="button"
                    className="bg-gray-400 rounded-md px-4 py-2 text-indigo-700 hover:bg-gray-300 transition-colors"
                  >
                    <AiOutlineUsergroupAdd />
                  </button>
                </td>
              </tr>

              <tr>
                <td className="px-8 py-4">Community Name</td>
                <td className="px-8 py-4">Description</td>
                <td className="px-8 py-4">Metrics</td>
                <td className="px-8 py-4">
                  <button
                    type="button"
                    className="bg-gray-400 rounded-md px-4 py-2 text-indigo-700 hover:bg-gray-300 transition-colors"
                  >
                    <AiOutlineUsergroupAdd />
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </>
  );
};

export default Dashboard;

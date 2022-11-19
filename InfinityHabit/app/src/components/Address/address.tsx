import React from 'react'

type Props = {
  address: string | undefined;
};

const Address = ({ address }: Props) => {
  const shortAddress =
    address &&
    address.length > 0 &&
    address.slice(0, 6) + "..." + address.slice(-4);
  return <p className="text-sm text-gray-400">{shortAddress}</p>;
};

export default Address;

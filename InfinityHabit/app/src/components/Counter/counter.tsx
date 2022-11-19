import React from 'react'
import { useContracts } from 'utils/context'

type Props = {};

const Counter = (props: Props) => {
  const { counterContract } = useContracts();
  const [number, setNumber] = React.useState(0);

  React.useEffect(() => {
    async function loadCounterNumber() {
      if (!counterContract) return;
      const number = await counterContract.number();
      setNumber(number);
    }

    loadCounterNumber();
  }, []);

  return <div>{counterContract && number}</div>;
};

export default Counter;

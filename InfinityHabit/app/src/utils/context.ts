import { createContext, useContext } from 'react'

import { ContractType } from '../../pages/_app'

export const AccountContext = createContext<string | null>(null);
export const ContractsContext = createContext<ContractType>({
  counterContract: null,
  // dcWarriorsContract: null,
  // stakingContract: null,
});

export function useAccount() {
  return useContext(AccountContext);
}
export function useContracts() {
  return useContext(ContractsContext);
}

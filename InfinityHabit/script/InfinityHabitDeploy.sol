// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/InfinityHabit.sol";

contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        HeraToken hera = new HeraToken();

        InfinityHabit habit = new InfinityHabit(address(hera));


        vm.stopBroadcast();
    }
}
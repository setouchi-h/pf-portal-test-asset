// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {TestAsset} from "../src/TestAsset.sol";

contract MintTestAsset is Script {
    function mint(address testERC20Address, address deployer, address recipient, uint256 amount) public {
        vm.startBroadcast(deployer);
        TestAsset testAsset = TestAsset(testERC20Address);
        testAsset.mint(recipient, amount);
        vm.stopBroadcast();
    }

    function mintUsingConfig(address testERC20Address, address recipient) public {
        HelperConfig helperConfig = new HelperConfig();
        (address deployer) = helperConfig.activeNetworkConfig();
        mint(testERC20Address, deployer, recipient, 100 ether);
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("TestAsset", block.chainid);
        // ここでrecipientを指定
        address recipient = 0x9302ce59d765FeE24D91aEa8d1A8629EF33b9856;
        mintUsingConfig(mostRecentlyDeployed, recipient);
    }
}

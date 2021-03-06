const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const SPKZ = artifacts.require('SPKZLounge');


module.exports = async function (deployer, network, accounts) {
  const instance = await deployProxy(SPKZ, ["https://raw.githubusercontent.com/Arianee/spkz-metadata/main/137/contract-spkz-lounges.json"], { deployer });
  console.log('Deployed', instance.address);
};

/*
module.exports = async function (deployer, network, accounts) {
  const existing = await SPKZ.deployed();
  const instance = await upgradeProxy(existing.address, SPKZV3, { deployer });
  console.log('Deployed', instance.address);
};
*/
const {deployProxy} = require("@openzeppelin/truffle-upgrades");
const Migrations = artifacts.require('Migrations');
const Bartender = artifacts.require('SPKZBar')

module.exports = async function(deployer) {
  // deployment steps
  deployer.deploy(Migrations);
  const instance = await deployProxy(Bartender, { deployer });
  console.log('Deployed', instance.address);deployer.deploy(Bartender);
};
//"https://github.com/Arianee/spkz-metadata/blob/main/80001/contract-spkz-bar.json"
var ERC20WithAutoMinerReward = artifacts.require("ERC20WithAutoMinerReward");

module.exports = function(deployer) {
  deployer.deploy(ERC20WithAutoMinerReward);
};

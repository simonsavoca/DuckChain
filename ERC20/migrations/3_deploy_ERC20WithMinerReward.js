var ERC20WithMinerReward = artifacts.require("ERC20WithMinerReward");

module.exports = function(deployer) {
  deployer.deploy(ERC20WithMinerReward);
};

var calc = artifacts.require("./calc.sol");

module.exports = function (deployer) {
  deployer.deploy(calc);
};

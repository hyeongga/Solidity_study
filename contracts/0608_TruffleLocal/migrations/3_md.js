const A = artifacts.require("ADD");
// const B = artifacts.require("DIV");

module.exports = function (deployer) {
  deployer.deploy(A);
  // deployer.deploy(B);
};

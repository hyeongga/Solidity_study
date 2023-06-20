const A = artifacts.require("ADD");
const B = artifacts.require("SUB");

module.exports = function (deployer) {
  deployer.deploy(A);
  deployer.deploy(B);
};

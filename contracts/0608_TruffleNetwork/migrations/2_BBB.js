const b = artifacts.require("B");

module.exports = function (deployer) {
  deployer.deploy(b, 10); //그냥 뒤에 필요한 input값들을 같이 넣어주면 됨 (여기서는 constructor값)
};

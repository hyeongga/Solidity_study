// scripts 폴더의 deploy.js 파일 수정

const hre = require("hardhat");

async function main() {
  //contract가지고 오기
  const LOCK = await hre.ethers.getContractFactory("Lock" /*contract명*/);
  const lock = await LOCK.deploy();
  console.log("LOCK Info : ", lock); //컨트랙트에 관련된 모든 내용 출력
  console.log("LOCK deployed to : ", lock.target); // 컨트랙트 주소만 출력
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

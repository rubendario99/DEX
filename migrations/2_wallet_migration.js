const Wallet = artifacts.require("Wallet");

module.exports =async function (deployer) {
  await deployer.deploy(Wallet);
  let wallet = await Wallet.deployed()
  console.log(wallet)
};

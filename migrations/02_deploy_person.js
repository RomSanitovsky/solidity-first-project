const Person = artifacts.require('Person');

const deployCollections = async (deployer, network, accounts) => {
  await deployer.deploy(Person);
};

module.exports = deployCollections;

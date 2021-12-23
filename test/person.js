const { assert } = require('chai');
const Person = artifacts.require('./Person.sol');

contract('Person', (accounts) => {
  const [owner] = accounts;
  describe('Person', () => {
    it('is doing somthing', async () => {
      const person = await Person.deployed();
      const name = await person.name();
      assert.equal(name, 'test');
    });
  });
});

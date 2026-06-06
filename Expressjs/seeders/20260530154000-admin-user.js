"use strict";

const bcrypt = require('bcryptjs');

module.exports = {
  up: async (queryInterface) => {
    const passwordHash = await bcrypt.hash('adminpassword', 10);
    await queryInterface.bulkInsert('users', [
      {
        name: 'Admin',
        email: 'admin@example.com',
        password: passwordHash,
        role: 'admin',
        createdAt: new Date(),
        updatedAt: new Date(),
      }
    ], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('users', { email: 'admin@example.com' }, {});
  }
};

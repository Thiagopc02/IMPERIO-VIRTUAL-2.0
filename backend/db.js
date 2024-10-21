const { Sequelize } = require('sequelize');
require('dotenv').config();

const sequelize = new Sequelize(
  process.env.DB_NAME || 'imperio_bebidas_e_tabacos',
  process.env.DB_USER || 'postgres',
  process.env.DB_PASSWORD || process.env.DB_PASS,
  {
    host: process.env.DB_HOST || 'localhost',
    dialect: 'postgres',
    logging: false,
    dialectOptions: {
      ssl: false
    }
  }
);

module.exports = sequelize;
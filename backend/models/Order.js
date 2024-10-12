const { DataTypes } = require('sequelize');
const sequelize = require('../db');
const OrderItem = require('./OrderItem'); // Importa o modelo OrderItem

const Order = sequelize.define('Order', {
  order_id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  user_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'users',
      key: 'user_id',
    },
  },
  total_price: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: false,
  },
  status: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'pendente',
  },
  payment_method: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  address: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  createdAt: {  // Corrigindo o nome para o padrão usado pelo Sequelize
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
  updatedAt: {  // Corrigindo o nome para o padrão usado pelo Sequelize
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
}, {
  tableName: 'orders',
  timestamps: true,  // Usando timestamps automáticos
});

// Define a relação entre Order e OrderItem
Order.hasMany(OrderItem, {
  foreignKey: 'order_id',
  as: 'items',
});

OrderItem.belongsTo(Order, {
  foreignKey: 'order_id',
  as: 'order',
});

module.exports = Order;

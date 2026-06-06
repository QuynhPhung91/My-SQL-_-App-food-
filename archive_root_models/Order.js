const { DataTypes } = require("sequelize");
const sequelize = require("../database");

const Order = sequelize.define(
  "Order",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    user_id: { type: DataTypes.INTEGER },
    food_id: { type: DataTypes.INTEGER },
    amount: { type: DataTypes.INTEGER },
    code: { type: DataTypes.STRING },
    arr_sub_id: { type: DataTypes.STRING },
  },
  { timestamps: false },
);

module.exports = Order;

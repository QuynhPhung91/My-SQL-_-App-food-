const { DataTypes } = require("sequelize");
const sequelize = require("../database");

const FoodType = sequelize.define(
  "FoodType",
  {
    type_id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    type_name: { type: DataTypes.STRING, allowNull: false },
  },
  { timestamps: false },
);

module.exports = FoodType;

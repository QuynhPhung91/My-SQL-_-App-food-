const { DataTypes } = require("sequelize");
const sequelize = require("../database");

const Restaurant = sequelize.define(
  "Restaurant",
  {
    res_id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    res_name: { type: DataTypes.STRING, allowNull: false },
    image: { type: DataTypes.STRING },
    description: { type: DataTypes.STRING, defaultValue: "Chưa có thông tin" },
  },
  { timestamps: false },
);

module.exports = Restaurant;

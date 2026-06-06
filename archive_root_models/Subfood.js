const { DataTypes } = require("sequelize");
const sequelize = require("../database");
const fetch = require("node-fetch");
const token = "<TOKEN>";

const SubFood = sequelize.define(
  "SubFood",
  {
    sub_id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    sub_name: { type: DataTypes.STRING, allowNull: false },
    price: { type: DataTypes.FLOAT },
    food_id: { type: DataTypes.INTEGER },
  },
  { timestamps: false },
);

module.exports = SubFood;

await fetch("http://localhost:3000/api/restaurants/123/like", {
  method: "POST",
  headers: { Authorization: `Bearer ${token}` },
});

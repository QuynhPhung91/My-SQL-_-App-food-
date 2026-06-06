const { DataTypes } = require("sequelize");
const sequelize = require("../database");

const Food = sequelize.define(
  "Food",
  {
    food_id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    food_name: { type: DataTypes.STRING },
    image: { type: DataTypes.STRING },
    price: { type: DataTypes.FLOAT },
    description: { type: DataTypes.STRING, defaultValue: "Chưa có thông tin" },
    type_id: { type: DataTypes.INTEGER },
  },
  { timestamps: false },
);

module.exports = Food;

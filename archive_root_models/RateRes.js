const { DataTypes } = require("sequelize");
const sequelize = require("../database");

const RateRes = sequelize.define(
  "Rate_res",
  {
    user_id: { type: DataTypes.INTEGER, primaryKey: true },
    res_id: { type: DataTypes.INTEGER, primaryKey: true },
    amount: { type: DataTypes.INTEGER },
    date_rate: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
  },
  { timestamps: false },
);

module.exports = RateRes;

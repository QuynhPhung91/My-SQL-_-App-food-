const { DataTypes } = require("sequelize");
const sequelize = require("../database");
const LikeRes = sequelize.define(
  "Like_res",
  {
    user_id: { type: DataTypes.INTEGER, primaryKey: true },
    res_id: { type: DataTypes.INTEGER, primaryKey: true },
  },
  { timestamps: false },
);

module.exports = LikeRes;

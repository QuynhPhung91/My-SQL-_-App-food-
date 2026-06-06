const User = require("./User");
const Food = require("./Food");
const FoodType = require("./Foodtype");
const SubFood = require("./Subfood");
const Restaurant = require("./Restaurant");
const Order = require("./Order");
const LikeRes = require("./LikeRes");
const RateRes = require("./RateRes");

// Food <-> FoodType
FoodType.hasMany(Food, { foreignKey: "type_id" });
Food.belongsTo(FoodType, { foreignKey: "type_id" });

// Food <-> SubFood
Food.hasMany(SubFood, { foreignKey: "food_id" });
SubFood.belongsTo(Food, { foreignKey: "food_id" });

// User <-> Order
User.hasMany(Order, { foreignKey: "user_id" });
Order.belongsTo(User, { foreignKey: "user_id" });

// Food <-> Order
Food.hasMany(Order, { foreignKey: "food_id" });
Order.belongsTo(Food, { foreignKey: "food_id" });

// User <-> Restaurant (Like)
User.belongsToMany(Restaurant, { through: LikeRes, foreignKey: "user_id" });
Restaurant.belongsToMany(User, { through: LikeRes, foreignKey: "res_id" });

// User <-> Restaurant (Rate)
User.belongsToMany(Restaurant, {
  through: RateRes,
  foreignKey: "user_id",
  as: "RatedRestaurants",
});
Restaurant.belongsToMany(User, {
  through: RateRes,
  foreignKey: "res_id",
  as: "RatingUsers",
});

module.exports = {
  User,
  Food,
  FoodType,
  SubFood,
  Restaurant,
  Order,
  LikeRes,
  RateRes,
};

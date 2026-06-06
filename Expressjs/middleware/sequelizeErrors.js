const { ValidationError, UniqueConstraintError } = require("sequelize");

module.exports = (err, req, res, next) => {
  if (err instanceof UniqueConstraintError) {
    return res
      .status(409)
      .json({ error: err.errors.map((e) => e.message).join(", ") });
  }
  if (err instanceof ValidationError) {
    return res
      .status(400)
      .json({ error: err.errors.map((e) => e.message).join(", ") });
  }
  next(err);
};

const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const User = require("../models/User");
const { body, validationResult } = require("express-validator");

const JWT_SECRET = process.env.JWT_SECRET;
const FALLBACK_SECRET = "dev-secret";
const signToken = (payload) => {
  if (!JWT_SECRET && process.env.NODE_ENV === "production") {
    throw new Error("JWT_SECRET is required in production");
  }
  return jwt.sign(payload, JWT_SECRET || FALLBACK_SECRET, {
    expiresIn: "7d",
  });
};

// Register
router.post(
  "/register",
  body("name").notEmpty(),
  body("email").isEmail(),
  body("password").isLength({ min: 6 }),
  async (req, res, next) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty())
        return res.status(400).json({ errors: errors.array() });

      const { name, email, password, phone, address } = req.body;
      const existing = await User.findOne({ where: { email } });
      if (existing)
        return res.status(409).json({ error: "Email already in use" });

      const user = await User.create({ name, email, password, phone, address });
      const payload = { id: user.id, email: user.email };
      const token = signToken(payload);

      res
        .status(201)
        .json({
          success: true,
          data: { id: user.id, name: user.name, email: user.email },
          token,
        });
    } catch (err) {
      next(err);
    }
  },
);

// Login
router.post(
  "/login",
  body("email").isEmail(),
  body("password").notEmpty(),
  async (req, res, next) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty())
        return res.status(400).json({ errors: errors.array() });

      const { email, password } = req.body;
      const user = await User.findOne({ where: { email } });
      if (!user) return res.status(401).json({ error: "Invalid credentials" });

      const valid = await user.comparePassword(password);
      if (!valid) return res.status(401).json({ error: "Invalid credentials" });

      const payload = { id: user.id, email: user.email };
      const token = signToken(payload);

      res.json({
        success: true,
        data: { id: user.id, name: user.name, email: user.email },
        token,
      });
    } catch (err) {
      next(err);
    }
  },
);

module.exports = router;

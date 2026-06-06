const express = require("express");
const router = express.Router();
const User = require("../models/User");
const auth = require("../middleware/auth");

// Get all users
router.get("/", async (req, res, next) => {
  try {
    const users = await User.findAll({ attributes: { exclude: ["password"] } });
    res.json({
      success: true,
      data: users,
      total: users.length,
    });
  } catch (err) {
    next(err);
  }
});

// Get user by ID
router.get("/:id", async (req, res, next) => {
  try {
    const user = await User.findByPk(req.params.id, {
      attributes: { exclude: ["password"] },
    });
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }
    res.json({
      success: true,
      data: user,
    });
  } catch (err) {
    next(err);
  }
});

const { body, validationResult } = require("express-validator");

const admin = require('../middleware/admin');

// Create user (admin)
router.post(
  "/",
  auth,
  admin,
  body("name").notEmpty(),
  body("email").isEmail(),
  body("password").isLength({ min: 6 }),
  body("role").optional().isIn(["user", "admin"]),
  async (req, res, next) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty())
        return res.status(400).json({ errors: errors.array() });

      const { name, email, password, phone, address, role } = req.body;
      const user = await User.create({
        name,
        email,
        password,
        phone,
        address,
        role: role || "user",
      });
      const safe = await User.findByPk(user.id, {
        attributes: { exclude: ["password"] },
      });

      res.status(201).json({
        success: true,
        data: safe,
        message: "User created successfully",
      });
    } catch (err) {
      next(err);
    }
  },
);

const ownerOrAdmin = require('../middleware/ownerOrAdmin');

// Update user (protected, owner or admin)
router.put(
  "/:id",
  auth,
  ownerOrAdmin,
  body("name").optional().notEmpty(),
  body("email").optional().isEmail(),
  body("password").optional().isLength({ min: 6 }),
  body("role").optional().isIn(["user", "admin"]),
  async (req, res, next) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty())
        return res.status(400).json({ errors: errors.array() });

      const user = await User.findByPk(req.params.id);
      if (!user) {
        return res.status(404).json({ error: "User not found" });
      }

      const updates = { ...req.body };
      if (req.user.role !== "admin") {
        delete updates.role;
      }

      const allowedFields = ["name", "email", "password", "phone", "address", "role"];
      const filteredUpdates = Object.fromEntries(
        Object.entries(updates).filter(([key]) => allowedFields.includes(key)),
      );

      await user.update(filteredUpdates);
      res.json({
        success: true,
        data: user,
        message: "User updated successfully",
      });
    } catch (err) {
      next(err);
    }
  },
);

// Delete user (protected, owner or admin)
router.delete("/:id", auth, ownerOrAdmin, async (req, res, next) => {
  try {
    const user = await User.findByPk(req.params.id);
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    await user.destroy();
    res.json({
      success: true,
      message: "User deleted successfully",
    });
  } catch (err) {
    next(err);
  }
});

module.exports = router;

const express = require("express");
const router = express.Router();
const MenuItem = require("../models/MenuItem");
const auth = require("../middleware/auth");
const { body, validationResult } = require('express-validator');
const admin = require('../middleware/admin');

// Get all menu items
router.get("/", async (req, res, next) => {
  try {
    const items = await MenuItem.findAll();
    res.json({
      success: true,
      data: items,
      total: items.length,
    });
  } catch (err) {
    next(err);
  }
});

// Get menu item by ID
router.get("/:id", async (req, res, next) => {
  try {
    const item = await MenuItem.findByPk(req.params.id);
    if (!item) {
      return res.status(404).json({ error: "Menu item not found" });
    }
    res.json({
      success: true,
      data: item,
    });
  } catch (err) {
    next(err);
  }
});

// Create menu item (protected - admin)
router.post(
  "/",
  auth,
  admin,
  body("name").notEmpty(),
  body("price").isNumeric(),
  body("description").optional().isString(),
  body("category").optional().isString(),
  body("available").optional().isBoolean(),
  async (req, res, next) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) return res.status(400).json({ errors: errors.array() });

      const { name, description, price, category, available } = req.body;

      const item = await MenuItem.create({
        name,
        description,
        price,
        category,
        available: available !== undefined ? available : true,
      });

      res.status(201).json({ success: true, data: item, message: "Menu item created successfully" });
    } catch (err) {
      next(err);
    }
  }
);

// Update menu item (protected - admin)
router.put(
  "/:id",
  auth,
  admin,
  body("name").optional().notEmpty(),
  body('price').optional().isNumeric(),
  body("description").optional().isString(),
  body("category").optional().isString(),
  body("available").optional().isBoolean(),
  async (req, res, next) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) return res.status(400).json({ errors: errors.array() });

      const item = await MenuItem.findByPk(req.params.id);
      if (!item) return res.status(404).json({ error: "Menu item not found" });

      const updates = Object.fromEntries(
        Object.entries(req.body).filter(([key]) =>
          ["name", "description", "price", "category", "available"].includes(key),
        ),
      );

      await item.update(updates);
      res.json({ success: true, data: item, message: "Menu item updated successfully" });
    } catch (err) {
      next(err);
    }
  }
);

// Delete menu item (protected - admin)
router.delete("/:id", auth, admin, async (req, res, next) => {
  try {
    const item = await MenuItem.findByPk(req.params.id);
    if (!item) {
      return res.status(404).json({ error: "Menu item not found" });
    }

    await item.destroy();
    res.json({
      success: true,
      message: "Menu item deleted successfully",
    });
  } catch (err) {
    next(err);
  }
});

module.exports = router;

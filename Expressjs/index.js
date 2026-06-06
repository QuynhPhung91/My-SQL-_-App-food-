require("dotenv").config();
const express = require("express");
const cors = require("cors");
const authRoutes = require("./routes/auth");
const userRoutes = require("./routes/users");
const menuRoutes = require("./routes/menu");
const sequelizeErrorHandler = require("./middleware/sequelizeErrors");

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/api/auth", authRoutes);
app.use("/api/users", userRoutes);
app.use("/api/menu", menuRoutes);

app.get("/api/status", (req, res) => {
  res.json({
    success: true,
    status: "ok",
    time: new Date().toISOString(),
  });
});

app.use(sequelizeErrorHandler);
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ error: "Internal server error" });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

module.exports = app;

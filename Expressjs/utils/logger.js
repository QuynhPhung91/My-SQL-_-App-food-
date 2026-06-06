const { createLogger, format, transports } = require("winston");

const logger = createLogger({
  level: process.env.NODE_ENV === "development" ? "debug" : "info",
  format: format.combine(
    format.timestamp(),
    format.printf(({ timestamp, level, message, ...meta }) => {
      const metaString = Object.keys(meta).length ? JSON.stringify(meta) : "";
      return `${timestamp} [${level.toUpperCase()}] ${message} ${metaString}`;
    }),
  ),
  transports: [new transports.Console()],
});

module.exports = logger;

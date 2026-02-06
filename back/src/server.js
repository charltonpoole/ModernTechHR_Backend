import express from "express";
import cors from "cors";
import morgan from "morgan";
import dotenv from "dotenv";
import apiRoutes from "./routes/api.js";
import { pingDb } from "./db.js";

dotenv.config();

const app = express();
const port = Number(process.env.PORT || 4001);
const corsOrigins = (process.env.CORS_ORIGIN || "http://localhost:5173")
  .split(",")
  .map(origin => origin.trim())
  .filter(Boolean);

app.use(
  cors({
    origin(origin, cb) {
      if (!origin) return cb(null, true);
      if (corsOrigins.includes(origin)) return cb(null, true);
      return cb(new Error(`CORS blocked for origin: ${origin}`));
    }
  })
);
app.use(express.json({ limit: "1mb" }));
app.use(morgan("dev"));

app.get("/api/health", async (req, res) => {
  try {
    await pingDb();
    res.json({ ok: true, message: "ModernTechHR API is running" });
  } catch (err) {
    console.error("[api] Database connection failed", err);
    res.status(500).json({ ok: false, error: "Database connection failed" });
  }
});

app.use("/api", apiRoutes);

app.use((req, res) => {
  res.status(404).json({ error: "Route not found" });
});

app.listen(port, () => {
  console.log(`ModernTechHR API listening on http://localhost:${port}`);
});

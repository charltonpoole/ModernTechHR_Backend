import mysql from "mysql2/promise";
import dotenv from "dotenv";

dotenv.config();

const useSsl = String(process.env.DB_SSL || "").toLowerCase() === "true";

export const pool = mysql.createPool({
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "root",
  // Allow empty password for local dev, but avoid hardcoded secrets.
  password: process.env.DB_PASSWORD ?? "",
  database: process.env.DB_NAME || "moderntech_hr",
  port: Number(process.env.DB_PORT || 3306),
  ...(useSsl ? { ssl: { rejectUnauthorized: false } } : {}),
  waitForConnections: true,
  connectionLimit: 10
});

export async function pingDb() {
  await pool.query("SELECT 1");
}

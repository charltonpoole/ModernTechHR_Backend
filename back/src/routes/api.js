import { Router } from "express";
import { pool } from "../db.js";

const router = Router();

function logError(context, err) {
  console.error(`[api] ${context}`, err);
}

function mapEmployee(row) {
  return {
    id: row.employee_id,
    name: row.name,
    position: row.position,
    department: row.department,
    salary: Number(row.salary),
    employmentHistory: row.employment_history,
    contact: row.contact
  };
}

router.get("/employees", async (req, res) => {
  try {
    const [rows] = await pool.query(
      "SELECT employee_id, name, position, department, salary, employment_history, contact FROM employees"
    );
    res.json(rows.map(mapEmployee));
  } catch (err) {
    logError("employees", err);
    res.status(500).json({ error: "Failed to load employees" });
  }
});

router.get("/attendance", async (req, res) => {
  try {
    const [rows] = await pool.query(
      "SELECT id, employee_id, date, status FROM attendance ORDER BY date ASC"
    );
    res.json(rows);
  } catch (err) {
    logError("attendance", err);
    res.status(500).json({ error: "Failed to load attendance" });
  }
});

router.get("/attendance-and-leave", async (req, res) => {
  try {
    const [employeeRows] = await pool.query(
      "SELECT employee_id, name FROM employees"
    );
    const [attendanceRows] = await pool.query(
      "SELECT employee_id, date, status FROM attendance ORDER BY date ASC"
    );
    const [leaveRows] = await pool.query(
      "SELECT employee_id, start_date, end_date, type, status FROM leave_requests ORDER BY created_at ASC"
    );

    const attendanceMap = new Map();
    for (const row of attendanceRows) {
      if (!attendanceMap.has(row.employee_id)) attendanceMap.set(row.employee_id, []);
      attendanceMap.get(row.employee_id).push({ date: row.date, status: row.status });
    }

    const leaveMap = new Map();
    for (const row of leaveRows) {
      if (!leaveMap.has(row.employee_id)) leaveMap.set(row.employee_id, []);
      leaveMap.get(row.employee_id).push({
        date: row.start_date,
        to: row.end_date,
        reason: row.type,
        status: row.status
      });
    }

    const response = employeeRows.map(emp => ({
      employeeId: emp.employee_id,
      name: emp.name,
      attendance: attendanceMap.get(emp.employee_id) || [],
      leaveRequests: leaveMap.get(emp.employee_id) || []
    }));

    res.json(response);
  } catch (err) {
    logError("attendance-and-leave", err);
    res.status(500).json({ error: "Failed to load attendance and leave" });
  }
});

router.get("/leave-requests", async (req, res) => {
  try {
    const [rows] = await pool.query(
      "SELECT id, employee_id, start_date, end_date, type, status FROM leave_requests ORDER BY created_at DESC"
    );
    res.json(rows.map(r => ({
      id: r.id,
      employeeId: r.employee_id,
      from: r.start_date,
      to: r.end_date,
      type: r.type,
      status: r.status
    })));
  } catch (err) {
    logError("leave-requests", err);
    res.status(500).json({ error: "Failed to load leave requests" });
  }
});

router.post("/leave-requests", async (req, res) => {
  try {
    const { employeeId, from, to, type } = req.body || {};
    if (!employeeId || !from || !to || !type) {
      return res.status(400).json({ error: "employeeId, from, to, and type are required" });
    }

    const [result] = await pool.query(
      "INSERT INTO leave_requests (employee_id, start_date, end_date, type, status) VALUES (?, ?, ?, ?, 'Pending')",
      [employeeId, from, to, type]
    );

    res.status(201).json({
      id: result.insertId,
      employeeId: Number(employeeId),
      from,
      to,
      type,
      status: "Pending"
    });
  } catch (err) {
    logError("leave-requests:create", err);
    res.status(500).json({ error: "Failed to create leave request" });
  }
});

router.patch("/leave-requests/:id", async (req, res) => {
  try {
    const id = Number(req.params.id);
    const { status } = req.body || {};
    if (!id || !status) {
      return res.status(400).json({ error: "id and status are required" });
    }

    const [result] = await pool.query(
      "UPDATE leave_requests SET status = ? WHERE id = ?",
      [status, id]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Leave request not found" });
    }

    res.json({ id, status });
  } catch (err) {
    logError("leave-requests:update", err);
    res.status(500).json({ error: "Failed to update leave request" });
  }
});

router.get("/payroll-history", async (req, res) => {
  try {
    const [rows] = await pool.query(
      "SELECT id, employee_id, month, gross, tax, net FROM payroll_history ORDER BY month DESC"
    );
    res.json(rows.map(r => ({
      id: r.id,
      employeeId: r.employee_id,
      month: r.month,
      gross: Number(r.gross),
      tax: Number(r.tax),
      net: Number(r.net)
    })));
  } catch (err) {
    logError("payroll-history", err);
    res.status(500).json({ error: "Failed to load payroll history" });
  }
});

router.get("/payroll-calculations", async (req, res) => {
  try {
    const [rows] = await pool.query(
      "SELECT employee_id, hours_worked, leave_deductions, final_salary FROM payroll_calculations"
    );
    res.json(rows.map(r => ({
      employeeId: r.employee_id,
      hoursWorked: r.hours_worked,
      leaveDeductions: r.leave_deductions,
      finalSalary: Number(r.final_salary)
    })));
  } catch (err) {
    logError("payroll-calculations", err);
    res.status(500).json({ error: "Failed to load payroll calculations" });
  }
});

router.get("/summary", async (req, res) => {
  try {
    const [[employees]] = await pool.query("SELECT COUNT(*) AS count FROM employees");
    const [[leaveRequests]] = await pool.query("SELECT COUNT(*) AS count FROM leave_requests");
    const [[attendance]] = await pool.query("SELECT COUNT(*) AS count FROM attendance");
    const [[payrollHistory]] = await pool.query("SELECT COUNT(*) AS count FROM payroll_history");

    res.json({
      employees: employees.count,
      leaveRequests: leaveRequests.count,
      attendanceEntries: attendance.count,
      payrollHistory: payrollHistory.count
    });
  } catch (err) {
    logError("summary", err);
    res.status(500).json({ error: "Failed to build summary" });
  }
});

export default router;

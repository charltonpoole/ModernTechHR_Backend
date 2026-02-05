-- ===============================
-- DATABASE
-- ===============================
CREATE DATABASE IF NOT EXISTS moderntech_hr;
USE moderntech_hr;

-- ===============================
-- EMPLOYEES
-- ===============================
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    employment_history VARCHAR(255),
    contact VARCHAR(150) NOT NULL
);

INSERT INTO employees (name, position, department, salary, employment_history, contact) VALUES
('Sibongile Nkosi','Software Engineer','Development',70000,'Joined in 2015, promoted to Senior in 2018','sibongile.nkosi@moderntech.com'),
('Lungile Moyo','HR Manager','HR',80000,'Joined in 2013, promoted to Manager in 2017','lungile.moyo@moderntech.com'),
('Thabo Molefe','Quality Analyst','QA',55000,'Joined in 2018','thabo.molefe@moderntech.com'),
('Keshav Naidoo','Sales Representative','Sales',60000,'Joined in 2020','keshav.naidoo@moderntech.com'),
('Zanele Khumalo','Marketing Specialist','Marketing',58000,'Joined in 2019','zanele.khumalo@moderntech.com'),
('Sipho Zulu','UI/UX Designer','Design',65000,'Joined in 2016','sipho.zulu@moderntech.com'),
('Naledi Moeketsi','DevOps Engineer','IT',72000,'Joined in 2017','naledi.moeketsi@moderntech.com'),
('Farai Gumbo','Content Strategist','Marketing',56000,'Joined in 2021','farai.gumbo@moderntech.com'),
('Karabo Dlamini','Accountant','Finance',62000,'Joined in 2018','karabo.dlamini@moderntech.com'),
('Fatima Patel','Customer Support Lead','Support',58000,'Joined in 2016','fatima.patel@moderntech.com');

-- ===============================
-- USER ACCOUNTS (LOGIN)
-- ===============================
CREATE TABLE user_accounts (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin','Manager','Employee') DEFAULT 'Employee',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO user_accounts (employee_id, username, password, role) VALUES
(1,'sibongile.nkosi','password123','Employee'),
(2,'lungile.moyo','admin123','Manager'),
(3,'thabo.molefe','password123','Employee'),
(4,'keshav.naidoo','password123','Employee'),
(5,'zanele.khumalo','password123','Employee'),
(6,'sipho.zulu','password123','Employee'),
(7,'naledi.moeketsi','password123','Employee'),
(8,'farai.gumbo','password123','Employee'),
(9,'karabo.dlamini','password123','Employee'),
(10,'fatima.patel','password123','Employee');

-- ===============================
-- ATTENDANCE
-- ===============================
CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present','Absent') NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO attendance (employee_id, date, status) VALUES
(1,'2025-07-25','Present'),(1,'2025-07-26','Absent'),(1,'2025-07-27','Present'),(1,'2025-07-28','Present'),(1,'2025-07-29','Present'),
(2,'2025-07-25','Present'),(2,'2025-07-26','Present'),(2,'2025-07-27','Absent'),(2,'2025-07-28','Present'),(2,'2025-07-29','Present'),
(3,'2025-07-25','Present'),(3,'2025-07-26','Present'),(3,'2025-07-27','Present'),(3,'2025-07-28','Absent'),(3,'2025-07-29','Present'),
(4,'2025-07-25','Absent'),(4,'2025-07-26','Present'),(4,'2025-07-27','Present'),(4,'2025-07-28','Present'),(4,'2025-07-29','Present'),
(5,'2025-07-25','Present'),(5,'2025-07-26','Present'),(5,'2025-07-27','Absent'),(5,'2025-07-28','Present'),(5,'2025-07-29','Present'),
(6,'2025-07-25','Present'),(6,'2025-07-26','Present'),(6,'2025-07-27','Absent'),(6,'2025-07-28','Present'),(6,'2025-07-29','Present'),
(7,'2025-07-25','Present'),(7,'2025-07-26','Present'),(7,'2025-07-27','Present'),(7,'2025-07-28','Absent'),(7,'2025-07-29','Present'),
(8,'2025-07-25','Present'),(8,'2025-07-26','Absent'),(8,'2025-07-27','Present'),(8,'2025-07-28','Present'),(8,'2025-07-29','Present'),
(9,'2025-07-25','Present'),(9,'2025-07-26','Present'),(9,'2025-07-27','Present'),(9,'2025-07-28','Absent'),(9,'2025-07-29','Present'),
(10,'2025-07-25','Present'),(10,'2025-07-26','Present'),(10,'2025-07-27','Absent'),(10,'2025-07-28','Present'),(10,'2025-07-29','Present');

-- ===============================
-- LEAVE / TIME OFF REQUESTS
-- ===============================
CREATE TABLE leave_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    type VARCHAR(50) NOT NULL,
    status ENUM('Pending','Approved','Denied') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO leave_requests (employee_id, start_date, end_date, type, status) VALUES
(1,'2025-07-22','2025-07-22','Sick Leave','Approved'),
(1,'2024-12-01','2024-12-01','Personal','Pending'),
(2,'2025-07-15','2025-07-15','Family Responsibility','Denied'),
(2,'2024-12-02','2024-12-02','Vacation','Approved'),
(3,'2025-07-10','2025-07-10','Medical Appointment','Approved'),
(3,'2024-12-05','2024-12-05','Personal','Pending'),
(4,'2025-07-20','2025-07-20','Bereavement','Approved'),
(5,'2024-12-01','2024-12-01','Childcare','Pending'),
(6,'2025-07-18','2025-07-18','Sick Leave','Approved'),
(7,'2025-07-22','2025-07-22','Vacation','Pending'),
(8,'2024-12-02','2024-12-02','Medical Appointment','Approved'),
(9,'2025-07-19','2025-07-19','Childcare','Denied'),
(10,'2024-12-03','2024-12-03','Vacation','Pending'),
-- merged previous time off requests
(2,'2025-12-20','2025-12-24','Emergency','Pending'),
(3,'2025-12-01','2025-12-02','Sick','Pending');

-- ===============================
-- PAYROLL HISTORY
-- ===============================
CREATE TABLE payroll_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    month CHAR(7),
    gross DECIMAL(10,2),
    tax DECIMAL(10,2),
    net DECIMAL(10,2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO payroll_history (employee_id, month, gross, tax, net) VALUES
(2,'2025-11',9000,1350,7650),
(3,'2025-11',6200,930,5270),
(9,'2025-11',5800,870,4930),
(7,'2025-11',6000,900,5100);

-- ===============================
-- PAYROLL CALCULATIONS
-- ===============================
CREATE TABLE payroll_calculations (
    employee_id INT PRIMARY KEY,
    hours_worked INT,
    leave_deductions INT,
    final_salary DECIMAL(10,2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO payroll_calculations (employee_id, hours_worked, leave_deductions, final_salary) VALUES
(1,160,8,69500),
(2,150,10,79000),
(3,170,4,54800),
(4,165,6,59700),
(5,158,5,57850),
(6,168,2,64800),
(7,175,3,71800),
(8,160,0,56000),
(9,155,5,61500),
(10,162,4,57750);



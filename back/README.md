# ModernTechHR Backend (MySQL)

Express API for the ModernTechHR frontend. Uses MySQL for data.

## Setup

1. Create the database and seed data:

Run the SQL script in `back/MySQL.sql`.

2. Configure environment:

Create `back/.env`:

```
PORT=4000
CORS_ORIGIN=http://localhost:5173
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=
DB_NAME=moderntech_hr
DB_SSL=false
```

3. Install dependencies:

```
cd back
npm install
```

4. Start the API:

```
npm run dev
```

API runs at `http://localhost:4000` by default.

## Endpoints

- `GET /api/health`
- `GET /api/employees`
- `GET /api/attendance`
- `GET /api/attendance-and-leave`
- `GET /api/leave-requests`
- `POST /api/leave-requests`
- `PATCH /api/leave-requests/:id`
- `GET /api/payroll-history`
- `GET /api/payroll-calculations`
- `GET /api/summary`

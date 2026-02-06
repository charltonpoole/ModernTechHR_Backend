# ModernTechHR (Full Stack)

This repo contains:
- `back/` — Express + MySQL API
- `ModernTechHR/` — Vue + Vite frontend

## Prerequisites
- Node.js (LTS)
- MySQL 8+

## 1) Database setup
Run the SQL file in MySQL (Workbench or CLI):

```
back/MySQL.sql
```

This creates and seeds the `moderntech_hr` database.

## 2) Backend setup
Create `back/.env`:

```
PORT=4001
CORS_ORIGIN=http://localhost:5173
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=root
DB_PASSWORD="your_password"
DB_NAME=moderntech_hr
DB_SSL=false
```

Note: If your password contains `#`, wrap it in quotes or it will be truncated.

Install and run the API:

```powershell
cd back
npm install
npm run dev
```

Health check:
```
http://localhost:4001/api/health
```

## 3) Frontend setup
Create `ModernTechHR/.env`:

```
VITE_API_BASE=http://localhost:4001
```

Install and run the frontend:

```powershell
cd ModernTechHR
npm install
npm run dev
```

Open the app:
```
http://localhost:5173
```

## Notes
- If MySQL is stopped, the API will fail and the frontend won’t load data.


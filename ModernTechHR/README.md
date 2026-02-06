# ModernTechHR

Vue 3 + Vite frontend for the ModernTechHR demo.

## Project Setup

```sh
npm install
```

### Compile and Hot-Reload for Development

```sh
npm run dev
```

### Compile and Minify for Production

```sh
npm run build
```

## API Configuration

This frontend reads data from the backend API.
Set `VITE_API_BASE` in `ModernTechHR/.env` (default is `http://localhost:4001`).

## Local Run (Frontend + Backend)

1. Start the backend in `back`:

```powershell
npm install
npm run dev
```

2. Start the frontend in `ModernTechHR`:

```powershell
npm install
npm run dev
```

Open the site at `http://localhost:5173` and visit `/login`.

Mock credentials (client-side only):
- Username: `hradmin`
- Password: `secret`

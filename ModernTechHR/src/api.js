const API_BASE = import.meta.env.VITE_API_BASE || 'http://localhost:4000'

async function handleResponse(response) {
  if (!response.ok) {
    const text = await response.text()
    throw new Error(text || `Request failed with ${response.status}`)
  }
  return response.json()
}

export async function apiGet(path) {
  const res = await fetch(`${API_BASE}${path}`)
  return handleResponse(res)
}

export async function apiSend(path, options = {}) {
  const res = await fetch(`${API_BASE}${path}`, {
    headers: { 'Content-Type': 'application/json', ...(options.headers || {}) },
    ...options
  })
  return handleResponse(res)
}

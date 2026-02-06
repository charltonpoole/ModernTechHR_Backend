<template>
  <nav class="navbar navbar-expand-lg navbar-dark navbar-hr p-3 rounded mb-3">
    <div class="container-fluid">
      <a class="navbar-brand brand" href="#">ModernTech HR</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navmenu">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navmenu">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item"><router-link class="nav-link" to="/">Log-in</router-link></li>
          <li class="nav-item"><router-link class="nav-link" to="/hr">HR Dashboard</router-link></li>

        </ul>
      </div>
    </div>
  </nav>
</template>

<script setup>
</script>

<style scoped>
.navbar-hr { background: linear-gradient(90deg, #0088ff44, transparent); border: 1px solid rgba(0, 0, 0, 0.799) }
.brand { color: var(--gold) }
.nav-link { color: var(--muted) }
.nav-link.router-link-active { color: var(--gold); font-weight:600 }
.nav-link:hover { color: var(--gold); text-decoration: underline }
</style>

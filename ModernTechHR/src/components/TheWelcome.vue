<template>
  <section class="hero">
    <div class="hero-inner">
      <h1>Welcome to ModernTech HR</h1>
      <p class="lead muted">Manage employees, payroll and reports in one place.</p>
      <router-link to="/login" class="btn-gold">Sign In</router-link>
    </div>
  </section>
</template>

<style scoped>
.hero { display:flex; align-items:center; justify-content:center; padding: 2rem 1rem; text-align:center }
.hero-inner { max-width: 900px }
.hero h1 { margin: 0 0 0.5rem 0 }
.hero .lead { margin-bottom: 1rem }
</style>

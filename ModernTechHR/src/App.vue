<script setup>
import { RouterView } from 'vue-router'
import NavBarHR from './components/NavBarHR.vue'
</script>

<template>
  <div>
    <NavBarHR />
    <main class="mt-3">
      <RouterView />
    </main>
  </div>
</template>

<style scoped>
.mt-3 { margin-top: 1rem }
</style>

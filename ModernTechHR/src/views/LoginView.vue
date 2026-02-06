<template>
  <div class="card mx-auto" style="max-width:420px">
    <div class="card-body">
      <h4 class="card-title brand">HR Portal Login</h4>

      <form @submit.prevent="login">
        <div class="mb-3">
          <label class="form-label">Username</label>
          <input v-model="form.username" required type="text" class="form-control" />
        </div>
        <div class="mb-3">
          <label class="form-label">Password</label>
          <input v-model="form.password" required type="password" class="form-control" />
        </div>

        <div class="d-flex justify-content-between align-items-center">
          <button class="btn btn-warning text-dark" type="submit">Sign in</button>
          <small class="muted">Use <strong>hradmin / secret</strong></small>
        </div>
      </form>

      <div v-if="error" class="mt-3 alert alert-danger p-2">{{ error }}</div>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const form = reactive({ username: '', password: '' })
const error = ref('')

function login() {
  if (form.username === 'hradmin' && form.password === 'secret') {
    localStorage.setItem('auth', JSON.stringify({ user: 'hradmin' }))
    router.push('/hr')
  } else {
    error.value = 'Invalid credentials'
  }
}

</script>

<style scoped>
.card { background: var(--card); border: 1px solid var(--border) }
.signin-link { color: var(--accent); text-decoration: underline; cursor: pointer }

.card .btn.btn-warning[type="submit"] {
  background: #00aeff6e;
  color: #ffffff;
  border: none;
}
.card .btn.btn-warning[type="submit"]:hover {
  opacity: 0.95;
  transform: translateY(-1px);
}
</style>

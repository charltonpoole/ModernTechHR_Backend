<template>
  <div>
    <h5 class="brand">Time Off Requests</h5>
    <div class="card mt-3 p-3">
      <h6 class="mb-2">Submit Time Off Request</h6>
      <form @submit.prevent="submitRequest">
        <div class="row">
          <div class="col">
            <label class="form-label">Employee</label>
            <select v-model="newReq.employeeId" class="form-select">
              <option v-for="e in employees" :value="e.id" :key="e.id">{{ e.name }}</option>
            </select>
          </div>
          <div class="col">
            <label class="form-label">From</label>
            <input v-model="newReq.from" type="date" class="form-control" />
          </div>
          <div class="col">
            <label class="form-label">To</label>
            <input v-model="newReq.to" type="date" class="form-control" />
          </div>
          <div class="col">
            <label class="form-label">Type</label>
            <select v-model="newReq.type" class="form-select">
              <option>Vacation</option>
              <option>Sick</option>
              <option>Emergency</option>
              <option>Personal</option>
            </select>
          </div>
        </div>
        <div class="mt-2">
          <button class="btn btn-gold" type="submit">Submit Request</button>
        </div>
      </form>
      <div v-if="formError" class="text-danger mt-2">{{ formError }}</div>
    </div>
    <div v-if="loading" class="muted mt-3">Loading requests...</div>
    <div v-else-if="error" class="text-danger mt-3">{{ error }}</div>
    <table v-else class="table table-light table-striped mt-3">
      <thead>
        <tr><th>Employee</th><th>From</th><th>To</th><th>Type</th><th>Status</th><th>Action</th></tr>
      </thead>
      <tbody>
        <tr v-for="r in requests" :key="r.id">
          <td>{{ employeeName(r.employeeId) }}</td>
          <td>{{ r.from }}</td>
          <td>{{ r.to }}</td>
          <td>{{ r.type }}</td>
          <td>{{ r.status }}</td>
          <td>
            <button class="btn btn-sm btn-success me-1" @click="update(r, 'Approved')">Approve</button>
            <button class="btn btn-sm btn-danger" @click="update(r, 'Denied')">Deny</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { apiGet, apiSend } from '../api.js'

const requests = ref([])
const employeesList = ref([])
const loading = ref(false)
const error = ref('')

function employeeName(id){
  const e = employeesList.value.find(x => x.id === id)
  return e ? e.name : 'Unknown'
}

async function update(r, status){
  try {
    const updated = await apiSend(`/api/leave-requests/${r.id}`, {
      method: 'PATCH',
      body: JSON.stringify({ status })
    })
    r.status = updated.status
  } catch (err) {
    error.value = 'Failed to update leave request.'
  }
}

const newReq = ref({ employeeId: 1, from: '', to: '', type: 'Vacation' })
const formError = ref('')

async function submitRequest() {
  formError.value = ''
  if (!newReq.value.from || !newReq.value.to) {
    formError.value = 'Please select both from and to dates.'
    return
  }
  try {
    const created = await apiSend('/api/leave-requests', {
      method: 'POST',
      body: JSON.stringify({
        employeeId: Number(newReq.value.employeeId),
        from: newReq.value.from,
        to: newReq.value.to,
        type: newReq.value.type
      })
    })
    requests.value.push(created)
    newReq.value = { employeeId: employeesList.value[0]?.id || 1, from: '', to: '', type: 'Vacation' }
  } catch (err) {
    formError.value = 'Failed to submit request.'
  }
}

onMounted(async () => {
  loading.value = true
  error.value = ''
  try {
    const [employees, leaveRequests] = await Promise.all([
      apiGet('/api/employees'),
      apiGet('/api/leave-requests')
    ])
    employeesList.value = employees || []
    requests.value = leaveRequests || []
    if (!newReq.value.employeeId && employeesList.value.length) {
      newReq.value.employeeId = employeesList.value[0].id
    }
  } catch (err) {
    error.value = 'Failed to load time off data from the API.'
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.table { background: transparent }
.table th { background-color: #f8f9fa }
.table td, .table th { vertical-align: middle }

.button { min-width: 80px }
.button + .button { margin-left: 0.5rem }

.button-success { background-color: #28a745; color: white; border: none; }
.button-danger { background-color: #dc3545; color: white; border: none; }
.button-success:hover { background-color: #218838; }
.button-danger:hover { background-color: #c82333; }
.button-success:disabled, .button-danger:disabled { opacity: 0.65; cursor: not-allowed; }
.button-success:disabled:hover, .button-danger:disabled:hover { background-color: inherit; }



</style>

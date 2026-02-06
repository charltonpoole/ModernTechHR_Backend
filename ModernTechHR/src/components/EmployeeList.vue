<template>
  <div class="container mt-4">
    <h5 class="brand text-gradient">Employees</h5>
    <div class="mb-3">
      <div class="input-group">
        <input
          v-model="searchQuery"
          @input="clearProfiles"
          type="search"
          class="form-control"
          placeholder="Search by name, role, department or email"
          aria-label="Search employees"
        />
        <button class="btn btn-outline-light" type="button" @click="searchQuery = ''">Clear</button>
      </div>
    </div>
    <div v-if="loading" class="muted">Loading employees...</div>
    <div v-else-if="error" class="text-danger">{{ error }}</div>
    <table v-else class="table table-striped premium-table mt-3">
      <thead>
        <tr>
          <th>Name</th>
          <th>Role</th>
          <th>Department</th>
          <th>Salary</th>
          <th>Attendance</th>
          <th>Status</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="e in filteredEmployees" :key="e.id">
          <td>{{ e.name }}</td>
          <td>{{ e.role }}</td>
          <td>{{ e.department }}</td>
          <td>R{{ e.salary }}</td>
          <td @click="emit('view-attendance-report')" class="attendance-link">{{ e.attendancePercent }}%</td>
          <td>
            <span :class="e.active ? 'text-success' : 'text-danger'">
              {{ e.active ? 'Active' : 'Inactive' }}
            </span>
          </td>
          <td>
            <button
              class="btn btn-sm btn-gradient-warning"
              @click="showProfiles"
            >
              View
            </button>
          </td>
        </tr>
      </tbody>
    </table>
    <div v-if="showingProfiles" class="mt-4">
      <h6 class="text-gradient">Employee Profiles</h6>
      <div class="row g-3">
        <div
          v-for="e in filteredEmployees.slice(0, 10)"
          :key="e.id"
          class="card profile-card col-md-4 p-3"
        >
          <h6>{{ e.name }} <small class="muted">({{ e.role }})</small></h6>
          <p class="muted mb-1">Department: {{ e.department }}</p>
          <p class="muted mb-1">Email: {{ e.email }}</p>
          <p class="muted mb-1">Start date: {{ e.startDate }}</p>
          <p class="muted mb-1">Attendance: {{ e.attendancePercent }}%</p>
          <p class="muted mb-1">
            Status: <strong>{{ e.active ? 'Active' : 'Blocked' }}</strong>
          </p>
          <button
            v-if="e.active"
            class="btn btn-sm btn-gradient-danger mt-2"
            @click="blockUser(e)"
          >
            Block
          </button>
          <button
            v-else
            class="btn btn-sm btn-outline-success mt-2"
            @click="unblockUser(e)"
          >
            Unblock
          </button>

        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, computed, onMounted } from 'vue'
import { apiGet } from '../api.js'

const emit = defineEmits(['view-attendance-report'])

const employees = ref([])
const showingProfiles = ref(false)
const searchQuery = ref('')
const loading = ref(false)
const error = ref('')
const filteredEmployees = computed(() => {
  const q = (searchQuery.value || '').trim().toLowerCase()
  if (!q) return employees.value
  return employees.value.filter(e => {
    return (
      (e.name && e.name.toLowerCase().includes(q)) ||
      (e.role && e.role.toLowerCase().includes(q)) ||
      (e.department && e.department.toLowerCase().includes(q)) ||
      (e.email && e.email.toLowerCase().includes(q))
    )
  })
})
function clearProfiles() {
  showingProfiles.value = false
}
function showProfiles() {
  showingProfiles.value = true
}
function blockUser(emp) {
  emp.active = false
}
function unblockUser(emp) {
  emp.active = true
}

function attendancePercent(attendance = []) {
  const total = attendance.length || 1
  const present = attendance.filter(s => String(s?.status || s).toLowerCase() === 'present').length
  return Math.round((present / total) * 100)
}

onMounted(async () => {
  loading.value = true
  error.value = ''
  try {
    const [employeeData, attendanceData] = await Promise.all([
      apiGet('/api/employees'),
      apiGet('/api/attendance-and-leave')
    ])
    const attendanceMap = new Map(
      (attendanceData || []).map(item => [item.employeeId, item.attendance || []])
    )
    employees.value = (employeeData || []).map(emp => ({
      id: emp.id,
      name: emp.name,
      role: emp.position,
      department: emp.department,
      salary: emp.salary,
      attendancePercent: attendancePercent(attendanceMap.get(emp.id)),
      email: emp.contact,
      startDate: emp.startDate || '--',
      active: emp.active ?? true
    }))
  } catch (err) {
    error.value = 'Failed to load employees from the API.'
  } finally {
    loading.value = false
  }
})
</script>
<style scoped>
.container {
  max-width: 1200px;
  margin: auto;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
.text-gradient {
  background: linear-gradient(90deg, #cbcbcb51, #6161617c);
  -webkit-text-fill-color: transparent;
}
.premium-table {
  background: #1C1C1C;
  color: #F0F0F0;
  border-radius: 10px;
  overflow: hidden;
}
.premium-table th, .premium-table td { vertical-align: middle; }
.premium-table tbody tr:hover { background: rgba(255, 255, 255, 0.2); }
.profile-card {
  background: #4e4c4c;
  color: #F5F5F5;
  border-radius: 12px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
  transition: transform 0.2s, box-shadow 0.2s;
}
.profile-card:hover { transform: translateY(-5px); box-shadow: 0 12px 30px rgba(0, 0, 0, 0.5); }
.btn-gradient-warning {
  background: linear-gradient(90deg, #FFB347, #FFCC33);
  color: #1C1C1C;
  border: none;
  transition: 0.3s;
}
.btn-gradient-warning:hover { background: linear-gradient(90deg, #FFCC33, #FFB347); }
.btn-gradient-danger {
  background: linear-gradient(90deg, #FF5F6D, #FFC371);
  color: #1C1C1C;
  border: none;
  transition: 0.3s;
}
.btn-gradient-danger:hover { background: linear-gradient(90deg, #FFC371, #FF5F6D); }
.text-success { color: #28A745; font-weight: bold; }
.text-danger { color: #DC3545; font-weight: bold; }
.muted { color: #B0B0B0; }
.active-letter {
  background-color: #0681c96d !important;
  color: #1C1C1C !important;
}
.attendance-link {
  cursor: pointer;
  color: #FFD700;
  transition: 0.2s;
}
.attendance-link:hover {
  color: #FFED4E;
  text-decoration: underline;
}
</style>

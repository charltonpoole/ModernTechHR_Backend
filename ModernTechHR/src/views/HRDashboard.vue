<template>
  <div>
    <div class="d-flex gap-3 mb-3">
      <button class="btn btn-outline-light" @click="active='employees'">Employees</button>
      <button class="btn btn-outline-light" @click="active='payroll'">Payroll</button>
      <button class="btn btn-outline-light" @click="active='timeoff'">Time Off</button>
      <button class="btn btn-outline-light" @click="active='reports'">Reports</button>
    </div>

    <div v-if="active==='employees'" class="card">
      <EmployeeList @view-attendance-report="active='reports'" />
    </div>

    <div v-if="active==='payroll'" class="card">
      <Payroll />
    </div>

    <div v-if="active==='timeoff'" class="card">
      <TimeOff />
    </div>

    <div v-if="active==='reports'" class="card">
      <Reports />
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import EmployeeList from '../components/EmployeeList.vue'
import Payroll from '../components/ThePayroll.vue'
import TimeOff from '../components/TimeOff.vue'
import Reports from '../components/TheReports.vue'

const active = ref('employees')
</script>

<style scoped>
.card { padding: 1rem }
.button { min-width: 100px }
.button + .button { margin-left: 0.5rem }
</style>

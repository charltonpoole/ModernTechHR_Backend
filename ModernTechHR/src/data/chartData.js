const raw = [
  {
    employeeId: 1,
    name: 'Sibongile Nkosi',
    attendance: ['Present','Absent','Present','Present','Present']
  },
  {
    employeeId: 2,
    name: 'Lungile Moyo',
    attendance: ['Present','Present','Absent','Present','Present']
  },
  {
    employeeId: 3,
    name: 'Thabo Molefe',
    attendance: ['Present','Present','Present','Absent','Present']
  },
  {
    employeeId: 4,
    name: 'Keshav Naidoo',
    attendance: ['Absent','Present','Present','Present','Present']
  },
  {
    employeeId: 5,
    name: 'Zanele Khumalo',
    attendance: ['Present','Present','Absent','Present','Present']
  },
  {
    employeeId: 6,
    name: 'Sipho Zulu',
    attendance: ['Present','Present','Absent','Present','Present']
  },
  {
    employeeId: 7,
    name: 'Naledi Moeketsi',
    attendance: ['Present','Present','Present','Absent','Present']
  },
  {
    employeeId: 8,
    name: 'Farai Gumbo',
    attendance: ['Present','Absent','Present','Present','Present']
  },
  {
    employeeId: 9,
    name: 'Karabo Dlamini',
    attendance: ['Present','Present','Present','Absent','Present']
  },
  {
    employeeId: 10,
    name: 'Fatima Patel',
    attendance: ['Present','Present','Absent','Present','Present']
  }
]

function attendancePercent(arr) {
  const total = arr.length || 1
  const present = arr.filter(s => String(s).toLowerCase() === 'present').length
  return Math.round((present / total) * 100)
}

export const chartData = {
  labels: raw.map(r => r.name),
  datasets: [
    {
      label: 'Attendance %',
      data: raw.map(r => attendancePercent(r.attendance)),
      backgroundColor: raw.map((_, i) => {
        const palette = [
          'rgba(212,175,55,0.8)',
          'rgba(35,151,125,0.8)',
          'rgba(243,217,139,0.8)',
          'rgba(102,102,255,0.8)',
          'rgba(255,102,102,0.8)'
        ]
        return palette[i % palette.length]
      })
    }
  ]
}


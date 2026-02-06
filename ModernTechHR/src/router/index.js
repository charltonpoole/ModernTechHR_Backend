import { createRouter, createWebHistory } from 'vue-router'

import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    // Serve the welcome/home page at root
    {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    // Keep /home working for existing links
    {
      path: '/home',
      redirect: '/',
    },
    {
      path: '/about',
      name: 'about',
      component: () => import('../views/AboutView.vue'),
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('../views/LoginView.vue'),
    },
    {
      path: '/hr',
      name: 'hr',
      component: () => import('../views/HRDashboard.vue'),
      meta: { requiresAuth: true }
    },
  ],
})

// Simple route guard for mock authentication
router.beforeEach((to, from, next) => {
  const requiresAuth = to.meta && to.meta.requiresAuth
  const isAuthed = !!localStorage.getItem('auth')
  if (requiresAuth && !isAuthed) {
    return next({ path: '/login' })
  }
  next()
})

export default router

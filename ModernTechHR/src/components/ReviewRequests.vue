<template>
  <div>
    <h5 class="brand">Review</h5>
    <div class="card mt-3 p-3">
      <h6 class="mb-2">Leave a Review</h6>
      <form @submit.prevent="submitReview">
        <div class="row">
          <div class="col">
            <label class="form-label">Your Name (optional)</label>
            <input
              v-model="newReview.name"
              type="text"
              class="form-control"
              placeholder="Name"
            />
          </div>
          <div class="col">
            <label class="form-label">Rating</label>
            <select v-model.number="newReview.rating" class="form-select">
              <option v-for="n in 5" :key="n" :value="n">{{ n }} / 5</option>
            </select>
          </div>
        </div>
        <div class="mt-2">
          <label class="form-label">Comments</label>
          <textarea
            v-model="newReview.comment"
            rows="3"
            class="form-control"
            placeholder="Share your feedback"
          ></textarea>
        </div>
        <div class="mt-2">
          <button class="btn btn-gold" type="submit">Submit Review</button>
        </div>
      </form>
      <div v-if="formError" class="text-danger mt-2">{{ formError }}</div>
      <div v-if="formSuccess" class="text-success mt-2">{{ formSuccess }}</div>
    </div>

    <h6 class="brand mt-4">Recent Reviews</h6>
    <table v-if="reviews.length" class="table table-light table-striped mt-2">
      <thead>
        <tr><th>Name</th><th>Rating</th><th>Comment</th><th>Date</th></tr>
      </thead>
      <tbody>
        <tr v-for="r in reviews" :key="r.id">
          <td>{{ r.name || 'Anonymous' }}</td>
          <td>{{ r.rating }}/5</td>
          <td>{{ r.comment }}</td>
          <td>{{ formatDate(r.createdAt) }}</td>
        </tr>
      </tbody>
    </table>
    <div v-else class="muted mt-2">No reviews yet.</div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const STORAGE_KEY = 'hr_reviews'

const reviews = ref([])
const newReview = ref({ name: '', rating: 5, comment: '' })
const formError = ref('')
const formSuccess = ref('')

function formatDate(value) {
  if (!value) return '--'
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return String(value)
  return date.toLocaleString()
}

function loadReviews() {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    reviews.value = raw ? JSON.parse(raw) : []
  } catch {
    reviews.value = []
  }
}

function saveReviews() {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(reviews.value))
}

function submitReview() {
  formError.value = ''
  formSuccess.value = ''
  const comment = (newReview.value.comment || '').trim()
  if (!comment) {
    formError.value = 'Please add a comment before submitting.'
    return
  }
  const review = {
    id: Date.now(),
    name: (newReview.value.name || '').trim(),
    rating: Number(newReview.value.rating) || 5,
    comment,
    createdAt: new Date().toISOString()
  }
  reviews.value.unshift(review)
  saveReviews()
  newReview.value = { name: '', rating: 5, comment: '' }
  formSuccess.value = 'Thanks! Your review has been saved.'
}

onMounted(() => {
  loadReviews()
})
</script>

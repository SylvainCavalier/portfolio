<template>
  <div
    v-if="visible"
    class="fixed bottom-4 right-4 bg-green-500 text-white font-chakra px-4 py-2 rounded shadow-lg z-50"
    >
    {{ message }}
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue'

const props = defineProps({
  message: String
})

const emit = defineEmits(['clear'])

const visible = ref(false)

watch(() => props.message, (val) => {
  if (val) {
    visible.value = true
    setTimeout(() => {
      visible.value = false
      emit('clear')
    }, 5000)
  }
})
</script>

<style scoped>
.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: opacity 0.3s ease-in-out, transform 0.3s ease-in-out;
}
.fade-slide-enter-from,
.fade-slide-leave-to {
  opacity: 0;
  transform: translateY(10px);
}
.fade-slide-enter-to,
.fade-slide-leave-from {
  opacity: 1;
  transform: translateY(0);
}
</style>
<template>
  <div class="text-center">
    <p class="text-xl mb-4">Compteur : {{ count }} </p>
    <button
      @click="increment"
      class="bg-blue-500 text-white px-4 py-2 rounded mr-2 hover:bg-blue-600"
    >
      Incrémenter
    </button>
    <button
      @click="decrement"
      class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600"
    >
      Décrémenter
    </button>
  </div>
</template>

<script setup>
import {ref} from 'vue'

const count = ref(0)
console.log(count.value)
const increment = () => {
  count.value++
}
const decrement = () => {
  count.value--
}
</script>

<style>
h1 {
  color: #42b983;
}
</style>
<template>
  <div id="app-wrapper" class="relative z-0">
    <div id="language-transition" class="language-transition" ref="transitionRef">
      <div v-for="i in 5" :key="i" :ref="el => setColumnRef(el, i-1)" class="column"></div>
    </div>
    <LandingPage @language-change="handleLanguageTransition" />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import LandingPage from './LandingPage.vue'
import gsap from 'gsap'

const transitionRef = ref(null)
const columns = ref(Array(5).fill(null))
let isAnimating = false

const setColumnRef = (el, index) => {
  if (el) {
    columns.value[index] = el
  }
}

// Initialiser les colonnes
onMounted(() => {
  columns.value.forEach((column, index) => {
    if (column) {
      gsap.set(column, {
        y: '100%',
        left: `${index * 20}%`,
        width: '20%',
        position: 'absolute'
      })
    }
  })
})

// Fonction pour gérer la transition de langue
const handleLanguageTransition = async (onEnterComplete) => {
  if (isAnimating) return
  isAnimating = true

  // Animation d'entrée
  const tl = gsap.timeline()
  
  columns.value.forEach((column, index) => {
    if (column) {
      tl.to(column, {
        y: '0%',
        duration: 0.3,
        ease: 'power2.inOut',
        delay: index * 0.1
      }, 0)
    }
  })

  // Attendre que l'animation d'entrée soit terminée
  await tl.then()

  // Déclencher le callback pour changer la langue
  if (onEnterComplete) onEnterComplete()

  // Créer une nouvelle timeline pour l'animation de sortie
  const tlOut = gsap.timeline()
  
  columns.value.forEach((column, index) => {
    if (column) {
      tlOut.to(column, {
        y: '100%',
        duration: 0.3,
        ease: 'power2.inOut',
        delay: index * 0.1
      }, 0)
    }
  })

  // Attendre que l'animation de sortie soit terminée
  await tlOut.then()
  isAnimating = false
}
</script>

<style>
.language-transition {
  position: fixed;
  inset: 0;
  z-index: 9999;
  pointer-events: none;
  overflow: hidden;
  width: 100vw;
}

.language-transition .column {
  position: absolute;
  height: 100vh;
  background-color: #09041e;
  will-change: transform;
  backface-visibility: hidden;
  width: 20vw;
  transform: translateY(100%);
  transition: transform 0.3s ease-in-out;
}
</style>
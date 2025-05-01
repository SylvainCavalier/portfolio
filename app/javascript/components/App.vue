<template>
  <div id="app-wrapper" class="relative z-0">
    <div id="language-transition" class="language-transition is-hidden">
      <div class="column" v-for="i in 5" :key="i"></div>
    </div>
    <LandingPage />
  </div>
</template>

<script setup>
import LandingPage from './LandingPage.vue'
</script>

<style>
.language-transition {
  opacity: 1;
  transition: opacity 0.3s ease;
  position: fixed;
  inset: 0;
  display: flex;
  z-index: 9999;
  pointer-events: none;
}

.language-transition.is-hidden {
  opacity: 0;
  pointer-events: none;
}

.language-transition .column {
  flex: 1;
  height: 100vh;
  background-color: #09041e;
  transform: translateY(100%);
  will-change: transform;
  backface-visibility: hidden;
}

/* animation d’entrée */
.language-transition.animate-in .column {
  animation: slide-in 0.5s ease-out forwards;
}

/* animation de sortie */
.language-transition.animate-out .column {
  animation: slide-out 0.5s ease-in forwards;
}

.language-transition.animate-in .column,
.language-transition.animate-out .column {
  animation-fill-mode: forwards; /* <--- obligatoire */
}

.language-transition .column:nth-child(1) { animation-delay: 0s; }
.language-transition .column:nth-child(2) { animation-delay: 0.05s; }
.language-transition .column:nth-child(3) { animation-delay: 0.1s; }
.language-transition .column:nth-child(4) { animation-delay: 0.15s; }
.language-transition .column:nth-child(5) { animation-delay: 0.2s; }

@keyframes slide-in {
  0%   { transform: translateY(100%); }
  100% { transform: translateY(0%); }
}

@keyframes slide-out {
  0%   { transform: translateY(0%); }
  100% { transform: translateY(100%); }
}
</style>
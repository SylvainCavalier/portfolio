<template>
  <div class="min-h-screen bg-gray-100 flex flex-col relative">
    <!-- Logo en arrière-plan -->
    <div class="absolute inset-0 flex items-center justify-center opacity-20 z-0">
      <img :src="logoUrl" alt="Logo de fond" class="w-3/4 max-w-lg">
    </div>

    <header class="bg-gray-900 text-white py-6 px-4 flex justify-evenly items-center fixed w-full z-50 shadow-md">
      <div class="relative w-24 h-24 md:w-32 md:h-32 perspective">
        <!-- Carte contenant les deux images -->
        <div
          class="flip-card w-full h-full transition-transform duration-700 ease-out transform-style-3d"
          :class="{ 'flipped': isFlipped }"
          @click="isFlipped = !isFlipped"
        >
          <!-- Face avant (photo normale) -->
          <img 
            :src="photoUrl" 
            alt="photo" 
            class="absolute w-full h-full rounded-full shadow-lg transition-transform duration-300 ease-out"
            :class="[isFlipped ? 'opacity-0 pointer-events-none' : 'opacity-100 hover:scale-110 hover:shadow-glow']"
          >
          
          <!-- Face arrière (photo alternative) -->
          <img
            :src="photofaceUrl"
            alt="Photo alternative"
            class="absolute w-full h-full object-cover rounded-full shadow-lg transition-transform duration-300 ease-out"
            :class="[isFlipped ? 'opacity-100 hover:scale-110 hover:shadow-glow' : 'opacity-0 pointer-events-none']"
          />
        </div>
      </div>
      <h1 ref="overlapText" class="text-4xl font-bold overlap">Sylvain Cavalier</h1>
      <nav class="space-x-4 flex gap-6">
        <a href="#info" class="magnetic-link relative inline-block text-xl transition-all duration-300">Info</a>
        <a href="#work" class="magnetic-link relative inline-block text-xl transition-all duration-300">Work</a>
        <a href="#archive" class="magnetic-link relative inline-block text-xl transition-all duration-300">Archive</a>
        <a href="#contact" class="magnetic-link relative inline-block text-xl transition-all duration-300">Contact</a>
      </nav>
      <button @click="switchLanguage" class="bg-blue-500 text-white px-3 py-2 rounded">
        {{ currentLanguage === 'en' ? 'Français' : 'English' }}
      </button>
    </header>

    <!-- Hero Section (fixe) -->
    <section class="h-screen w-full flex flex-col items-center justify-center text-center fixed top-0 left-0 z-10 bg-gray-100">
      <h2 class="font-chakra text-5xl font-bold opacity-0 animate-fadeIn">Développeur Web & Créatif</h2>
      <p class="font-chakra mt-4 text-lg opacity-0 animate-fadeIn delay-200">"Passionné par le code et la création de solutions innovantes."</p>
      <div class="absolute bottom-10 animate-bounce text-gray-700">⬇ Scroll to Explore ⬇</div>
    </section>

    <!-- Section Info avec effet de révélation et zoom du titre -->
    <section
      id="info"
      ref="infoSection"
      class="min-h-screen bg-gray-900 text-white flex flex-col items-center justify-center fixed top-0 left-0 w-full z-20 transition-all duration-700"
      :style="{ clipPath: infoClipPath, opacity: infoOpacity }"
    >
      <h2 
        class="text-3xl font-bold transition-transform duration-700"
        :style="{ transform: infoTitleScale }"
      >
        Mon parcours
      </h2>
      <p class="mt-4 text-center max-w-2xl">
        J'ai quitté une carrière de juriste pour suivre ma passion dans le développement web.
      </p>
    </section>

    <section
      id="work"
      ref="workSection"
      class="min-h-screen bg-gray-100 flex flex-col items-center justify-center opacity-0 transition-opacity duration-700 transform scale-y-0"
    >
      <h2 class="text-3xl font-bold">Mes projets</h2>
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-8">
        <div v-for="project in projects" :key="project.id" class="bg-white p-4 shadow-lg">
          <img :src="project.image_url" alt="Image du projet" class="w-full h-48 object-cover">
          <h3 class="font-bold text-xl mt-2">{{ project.name }}</h3>
          <p class="mt-2">{{ project.description }}</p>
          <a :href="project.github_url" class="text-blue-500 mt-4 block">Voir sur GitHub</a>
        </div>
      </div>
    </section>

    <section id="contact" class="min-h-screen bg-gray-200 flex flex-col items-center justify-center">
      <h2 class="text-3xl font-bold">Me contacter</h2>
      <form class="mt-8 w-full max-w-lg" @submit.prevent="submitForm">
        <div class="mb-4">
          <label for="name" class="block text-sm font-medium">Nom</label>
          <input id="name" v-model="form.name" type="text" class="w-full p-2 border rounded">
        </div>
        <div class="mb-4">
          <label for="email" class="block text-sm font-medium">Email</label>
          <input id="email" v-model="form.email" type="email" class="w-full p-2 border rounded">
        </div>
        <div class="mb-4">
          <label for="message" class="block text-sm font-medium">Message</label>
          <textarea id="message" v-model="form.message" class="w-full p-2 border rounded"></textarea>
        </div>
        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded">Envoyer</button>
      </form>
    </section>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import photoUrl from '../assets/your-photo.jpg'
import logoUrl from '../assets/LogoSpng.png'
import { onUnmounted } from 'vue'
import photofaceUrl from '../assets/photoface.png'

const projects = ref([])
const currentLanguage = ref('en')
const switchLanguage = () => {
  currentLanguage.value = currentLanguage.value === 'en' ? 'fr' : 'en'
}

const infoSection = ref(null)
const workSection = ref(null)
const infoClipPath = ref('inset(50% 0 50% 0)')
const infoOpacity = ref('0')
const infoTitleScale = ref('scale(0.8)')
const overlapText = ref(null)
const isFlipped = ref(false)
const showFront = ref(true)

const flipImage = () => {
  isFlipped.value = !isFlipped.value

  // Attendre la moitié de l'animation du flip (350ms sur 700ms)
  setTimeout(() => {
    showFront.value = !showFront.value
  }, 350)
}

const handleScroll = () => {
  const scrollY = window.scrollY
  const triggerPoint = window.innerHeight * 0.2

  if (scrollY > triggerPoint) {
    infoClipPath.value = 'inset(0 0 0 0)' 
    infoOpacity.value = '1'
    infoTitleScale.value = 'scale(1)'
  } else {
    infoClipPath.value = 'inset(50% 0 50% 0)' 
    infoOpacity.value = '0'
    infoTitleScale.value = 'scale(0.8)'
  }
}

onMounted(() => {
  fetch('/projects.json')
    .then(response => response.json())
    .then(data => projects.value = data)
    .catch(error => console.error('Erreur lors du chargement des projets:', error))

  window.addEventListener('scroll', handleScroll)

  document.querySelectorAll('.magnetic-link').forEach(link => {
    link.addEventListener('mousemove', (e) => {
      const rect = link.getBoundingClientRect();
      const x = (e.clientX - rect.left - rect.width / 2) * 0.2;
      const y = (e.clientY - rect.top - rect.height / 2) * 0.2;

      link.style.transform = `translate(${x}px, ${y}px) scale(1.1)`;
    });

    link.addEventListener('mouseleave', () => {
      link.style.transform = `translate(0, 0) scale(1)`;
    });
  });

  if (overlapText.value) {
    const textContent = overlapText.value.textContent
    overlapText.value.innerHTML = ''
    const chars = [...textContent]

    chars.forEach((char, index) => {
      const span = document.createElement('span')
      span.textContent = char
      span.style.setProperty('--index', index)
      span.classList.add('overlap-back')
      overlapText.value.appendChild(span)
    })
  }
});

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll);
});

const form = ref({ name: '', email: '', message: '' })
const submitForm = () => {
  console.log('Formulaire soumis :', form.value)
}
</script>

<style>
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

.animate-fadeIn {
  animation: fadeIn 1s ease-out forwards;
}

.clip-reveal {
  clip-path: inset(50% 0 50% 0);
  transition: clip-path 0.7s ease-out;
}

.clip-reveal.active {
  clip-path: inset(0% 0 0% 0);
}

.magnetic-link {
  display: inline-block;
  transition: transform 0.2s ease-out;
  cursor: pointer;
}

.overlap {
  --overlap: .15ch;
  --shadow-offset: .1ch;
  --shadow-blur: .2ch;
  --shadow-color: black;
  letter-spacing: calc(var(--overlap) * -1); 
  isolation: isolate;
  display: inline-block;
}

.overlap > span {
  position: relative;
  z-index: calc(var(--index, 1) * var(--mult, 1));
}

.overlap-back {
  text-shadow: 
    calc(var(--mult, 1) * var(--shadow-offset,0) * -1) 0 
    var(--shadow-blur, 0) 
    var(--shadow-color, black);
}

.flip-card {
  transform-style: preserve-3d;
  position: relative;
  cursor: pointer;
}

.flipped {
  transform: rotateY(180deg);
}

.backface-hidden {
  backface-visibility: hidden;
}

.rotateY-180 {
  transform: rotateY(180deg);
}

#info {
  transition: clip-path 0.8s ease-out, opacity 0.8s ease-out;
}
</style>
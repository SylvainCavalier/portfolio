<template>
  <div class="min-h-screen bg-gray-100 flex flex-col relative">
    <!-- Logo en arrière-plan -->
    <div class="absolute inset-0 flex items-center justify-center opacity-20 z-0">
      <img :src="logoUrl" alt="Logo de fond" class="w-3/4 max-w-lg">
    </div>

    <header class="bg-gray-900 text-white py-2 px-4 flex justify-evenly items-center fixed w-full z-50 shadow-md">
      <div class="relative w-24 h-24 md:w-24 md:h-24 perspective">
        <div
          class="flip-card-inner w-full h-full transition-transform duration-700 ease-out"
          :class="{ 'flipped': isFlipped }"
          @click="flipImage"
        >
          <!-- Face avant (photo normale) -->
          <div class="flip-card-front absolute w-full h-full rounded-full shadow-lg">
            <img 
              :src="photoUrl"
              alt="photo"
              class="w-full h-full rounded-full object-cover hover:scale-110 hover:shadow-glow transition-transform duration-300 ease-out"
            >
          </div>

          <!-- Face arrière (photo alternative) -->
          <div class="flip-card-back absolute w-full h-full rounded-full shadow-lg">
            <img
              :src="photofaceUrl"
              alt="Photo alternative"
              class="w-full h-full rounded-full object-cover hover:scale-110 hover:shadow-glow transition-transform duration-300 ease-out"
            >
          </div>
        </div>
      </div>
      <h1 ref="overlapText" class="text-4xl font-bold overlap">Sylvain Cavalier</h1>
      <nav class="space-x-4 flex gap-6">
        <a href="#info" class="magnetic-link relative inline-block text-xl transition-all duration-300">
          {{ currentLanguage === 'english' ? 'Info' : 'Infos' }}
        </a>
        <a href="#skills" class="magnetic-link relative inline-block text-xl transition-all duration-300">
          {{ currentLanguage === 'english' ? 'Skills' : 'Compétences' }}
        </a>
        <a href="#projects" class="magnetic-link relative inline-block text-xl transition-all duration-300">
          {{ currentLanguage === 'english' ? 'Projects' : 'Projets' }}
        </a>
        <a href="#contact" class="magnetic-link relative inline-block text-xl transition-all duration-300">
          {{ currentLanguage === 'english' ? 'Contact' : 'Contact' }}
        </a>
      </nav>
      <button @click="switchLanguage" class="glow-button">
        <div class="gradient"></div>
        <span>{{ currentLanguage === 'english' ? 'Français' : 'English' }}</span>
      </button>
    </header>

    <!-- Hero Section -->
    <section id="hero" class="relative inset-0 h-screen flex flex-col items-center justify-center z-10 bg-gray-100">
      <h2 class="glitch font-chakra text-5xl font-bold opacity-0 animate-fadeIn" :data-text="currentLanguage === 'english' ? 'Web Developer & Creative' : 'Développeur Web & Créatif'">
        {{ currentLanguage === 'english' ? 'Web Developer & Creative' : 'Développeur Web & Créatif' }}
      </h2>
      <p class="font-chakra mt-4 text-lg opacity-0 animate-fadeIn delay-200">
        {{ currentLanguage === 'english' ? 'I left a career in Law to pursue my passion for Web development.' : 'J\'ai quitté une carrière en droit pour me consacrer à ma passion pour le développement web.' }}
      </p>
      <div class="absolute bottom-10 animate-bounce text-gray-700">⬇ {{ currentLanguage === 'english' ? 'Scroll to Explore' : 'Faites défiler pour explorer' }} ⬇</div>
    </section>

    <!-- 📍 SECTION TIMELINE -->
    <section id="info" class="min-h-screen flex flex-col items-center justify-center bg-gray-900 text-white pt-24">
      <h2 ref="infoTitle" class="text-6xl font-bold text-white mb-10">
        {{ currentLanguage === 'english' ? 'My Journey' : 'Mon Parcours' }}
      </h2>
      
      <div class="w-full max-w-2xl mt-10 mx-auto">
        <!-- 🏁 Ligne Verticale Animée -->
        <div class="draw-line-height w-full flex justify-center">
          <svg id="line-svg" xmlns="http://www.w3.org/2000/svg" class="w-2" height="100%" viewBox="0 0 10 1500">
            <line id="line-path" x1="5" y1="0" x2="5" y2="1350" stroke="#2BAAE2" stroke-width="4.8484" stroke-linecap="round" />
          </svg>
          <!-- 📌 ÉTAPES -->
          <ul class="timeline">
            <li v-for="(step, index) in filteredSteps" 
                :key="index" 
                :class="['timeline-item', index % 2 === 0 ? 'left' : 'right']">
              <div class="timeline-dot"></div>
              <div class="timeline-content">
                <h3 class="text-lg font-bold">{{ step.name }}</h3>
                <span class="text-sm text-gray-300">{{ step.date }}</span>
                <p class="mt-2">{{ step.description }}</p>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </section>

    <!-- Section Skills -->
    <section id="skills" class="min-h-screen bg-gray-900 flex flex-col items-center justify-center px-6 py-12">
      <h2 class="text-5xl font-bold mb-12 text-white font-chakra mb-10">
        {{ currentLanguage === 'english' ? 'Skills' : 'Compétences' }}
      </h2>
      <div class="flex flex-col w-full max-w-4xl space-y-8">
        <div 
          v-for="(skill, index) in filteredSkills" 
          :key="index"
          class="skill-card opacity-0 transition-all duration-700 flex flex-col md:flex-row justify-between items-center pb-8 border-b border-gray-700 mb-10"
        >
          <div class="flex items-baseline gap-4">
            <h3 class="font-chakra font-semibold text-3xl text-white">{{ skill.name }}</h3>
          </div>
          <p class="text-gray-300 font-chakra text-lg md:text-right max-w-xl mt-4 md:mt-0">{{ skill.description }}</p>
        </div>
      </div>
    </section>

    <!-- Section Projects -->
    <section id="projects" class="min-h-screen bg-gray-100 flex flex-col items-center justify-center px-6 py-12">
      <h2 class="text-4xl font-bold mb-10">
        {{ currentLanguage === 'english' ? 'Projects' : 'Projets' }}
      </h2>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 w-full max-w-6xl">
        <div 
          v-for="(project, index) in filteredProjects" 
          :key="index" 
          class="bg-white shadow-xl rounded-lg overflow-hidden transition-transform duration-300 hover:scale-105 border-t-4 border-blue-500"
        >
          <img 
            :src="project.image_url" 
            alt="Project Image" 
            class="w-full h-48 object-cover"
          >
          <div class="p-6">
            <h3 class="font-bold text-2xl mb-2">{{ project.name }}</h3>
            <p class="text-gray-600 mb-4">{{ project.description }}</p>
            <p class="text-sm text-gray-500">Tech stack: {{ project.tech_stack }}</p>
            <a 
              :href="project.github_url" 
              class="text-blue-500 mt-4 block transition-colors duration-200 hover:text-blue-700"
              target="_blank"
            >
              See on GitHub
            </a>
          </div>
        </div>
      </div>
    </section>

    <section id="contact" class="min-h-screen bg-gray-200 flex flex-col items-center justify-center">
      <h2 class="text-3xl font-bold mb-6">{{ currentLanguage === 'english' ? 'Contact Me' : 'Me Contacter' }}</h2>
      <form class="w-full max-w-lg" @submit.prevent="submitForm">
        <div class="mb-4">
          <label for="name" class="block text-sm font-medium">{{ currentLanguage === 'english' ? 'Name' : 'Nom' }}</label>
          <input id="name" v-model="form.name" type="text" class="w-full p-2 border rounded">
        </div>
        <div class="mb-4">
          <label for="email" class="block text-sm font-medium">{{ currentLanguage === 'english' ? 'Email' : 'E-mail' }}</label>
          <input id="email" v-model="form.email" type="email" class="w-full p-2 border rounded">
        </div>
        <div class="mb-4">
          <label for="message" class="block text-sm font-medium">{{ currentLanguage === 'english' ? 'Message' : 'Message' }}</label>
          <textarea id="message" v-model="form.message" class="w-full p-2 border rounded"></textarea>
        </div>
        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded">
          {{ currentLanguage === 'english' ? 'Send' : 'Envoyer' }}
        </button>
      </form>
    </section>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import photoUrl from '../assets/your-photo.jpg'
import logoUrl from '../assets/LogoSpng.png'
import photofaceUrl from '../assets/photoface.png'
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import Lenis from "lenis";
import chroma from "chroma-js";

let lenis;

// Déclaration de la langue actuelle
const currentLanguage = ref('english')

// Fonction pour changer de langue
const switchLanguage = () => {
  currentLanguage.value = currentLanguage.value === 'english' ? 'french' : 'english'
}

const skills = ref([])
const steps = ref([])
const projects = ref([])

const infoSection = ref(null)
const workSection = ref(null)
const infoClipPath = ref('inset(50% 0 50% 0)')
const infoOpacity = ref('0')
const infoTitleScale = ref('scale(0.8)')

const overlapText = ref(null)
const isFlipped = ref(false)

const timelineHeight = ref(0)

// Réaction au changement de langue, filtrage local
const filteredSkills = computed(() => skills.value.filter(skill => skill.language === currentLanguage.value))
const filteredSteps = computed(() => steps.value.filter(step => step.language === currentLanguage.value))
const filteredProjects = computed(() => projects.value.filter(project => project.language === currentLanguage.value))

const flipImage = () => {
  isFlipped.value = !isFlipped.value
}

onMounted(async () => {
  gsap.registerPlugin(ScrollTrigger);

  const lenis = new Lenis({ lerp: 0.08, smooth: true });

  function raf(time) {
    lenis.raf(time);
    requestAnimationFrame(raf);
  }
  requestAnimationFrame(raf);

  lenis.on('scroll', ScrollTrigger.update);

  try {
    const skillResponse = await fetch('/skills')
    skills.value = await skillResponse.json()
    
    const stepResponse = await fetch('/steps')
    steps.value = await stepResponse.json()
    
    const projectResponse = await fetch('/projects')
    projects.value = await projectResponse.json()
  } catch (error) {
    console.error(error)
  }

  // **✅ Effet de lien magnétique amélioré**
  document.querySelectorAll('.magnetic-link').forEach(link => {
    link.addEventListener('mousemove', (e) => {
      const rect = link.getBoundingClientRect();
      const x = (e.clientX - rect.left - rect.width / 2) * 0.2;
      const y = (e.clientY - rect.top - rect.height / 2) * 0.2;
      gsap.to(link, { x, y, scale: 1.1, duration: 0.2, ease: "power2.out" }); // ✅ Animation propre avec GSAP
    });

    link.addEventListener('mouseleave', () => {
      gsap.to(link, { x: 0, y: 0, scale: 1, duration: 0.2, ease: "power2.out" }); // ✅ Remise à zéro fluide
    });
  });

  // **✅ Effet de superposition des lettres du nom "Sylvain Cavalier"**
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

  document.querySelectorAll(".glow-button").forEach((button) => {
    const gradient = button.querySelector(".gradient");

    button.addEventListener("pointermove", (e) => {
      const rect = button.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;

      const mixAmount = x / rect.width;
      const mixedColor = chroma.mix(
        getComputedStyle(button).getPropertyValue("--button-glow-start").trim(),
        getComputedStyle(button).getPropertyValue("--button-glow-end").trim(),
        mixAmount
      );

      gsap.to(gradient, {
        x: x - rect.width / 2,
        y: y - rect.height / 2,
        duration: 0.4,
        ease: "power3.out",
        background: `radial-gradient(circle at ${x}px ${y}px, ${mixedColor}, transparent 80%)`,
      });
    });

    button.addEventListener("pointerleave", () => {
      gsap.to(gradient, {
        x: 0,
        y: 0,
        duration: 0.6,
        ease: "power3.out",
        background: `linear-gradient(90deg, var(--button-glow-start), var(--button-glow-end))`,
      });
    });
  });

  // SVG Line scrolling
  const path = document.querySelector('#line-path');
  const pathLength = path.getTotalLength();
  path.style.strokeDasharray = pathLength;
  path.style.strokeDashoffset = pathLength;

  window.addEventListener('scroll', () => {
    const scrollY = window.scrollY;
    const section = document.querySelector('#info');
    const sectionTop = section.offsetTop;
    const sectionHeight = section.offsetHeight;

    const progress = Math.min(Math.max((scrollY - sectionTop) / (sectionHeight - window.innerHeight), 0), 1);
    const drawLength = pathLength * progress;

    path.style.strokeDashoffset = pathLength - drawLength;
  });

  // Intersection Observer pour Timeline (apparition/disparition uniquement vers le haut)
  const timelineItems = document.querySelectorAll('.timeline-item');

  let lastScrollY = window.scrollY;
  let scrollingDown = true;

  window.addEventListener('scroll', () => {
    scrollingDown = window.scrollY > lastScrollY;
    lastScrollY = window.scrollY;
  });

  const timelineObserverOptions = {
    root: null,
    rootMargin: '-50% 0px -50% 0px',
    threshold: 0
  };

  const timelineObserver = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
      } else if (!scrollingDown) {
        entry.target.classList.remove('visible');
      }
    });
  }, timelineObserverOptions);

  timelineItems.forEach(item => timelineObserver.observe(item));

  // Intersection Observer pour Skills
  const skillCards = document.querySelectorAll('.skill-card');

  const skillsObserverOptions = {
    root: null,
    rootMargin: '0px 0px -100px 0px',
    threshold: 0.2
  };

  const skillsObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('opacity-100', 'translate-y-0');
        entry.target.classList.remove('opacity-0', 'translate-y-10');
      } else if (!scrollingDown) {
        entry.target.classList.remove('opacity-100', 'translate-y-0');
        entry.target.classList.add('opacity-0', 'translate-y-10');
      }
    });
  }, skillsObserverOptions);

  skillCards.forEach(card => {
    card.classList.add('translate-y-10');
    skillsObserver.observe(card);
  });
});

const form = ref({ name: '', email: '', message: '' })
const submitForm = () => {
  console.log('Formulaire soumis :', form.value)
}
</script>

<style scoped>
/* Animation de fade-in */

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

.animate-fadeIn {
  animation: fadeIn 1s ease-out forwards;
}

/* Transition de volet */

#hero {
  top: 0;
  left: 0;
  width: 100%;
  height: 100vh;
  z-index: 10;
  transition: opacity 0.5s ease-out;
}

#info {
  position: relative;
  height: 450vh;
}

/* Magnetic links */

.magnetic-link {
  display: inline-block;
  transition: transform 0.2s ease-out;
  cursor: pointer;
}

/* Lettres du nom chevauchées */

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

/* Rotation images */

.perspective {
  perspective: 1000px;
}

.flip-card-inner {
  width: 100%;
  height: 100%;
  transform-style: preserve-3d;
  transition: transform 0.7s cubic-bezier(0.68, -0.55, 0.27, 1.55);
  position: relative;
}

.flipped {
  transform: rotateY(180deg);
}

.flip-card-front, .flip-card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
}

.flip-card-back {
  transform: rotateY(180deg);
}

/* Animation Bouton Languages */

.glow-button {
  --button-background: #09041e;
  --button-color: #fff;
  --button-shadow: rgba(33, 4, 104, 0.2);
  --button-glow-start: #B000E8;
  --button-glow-end: #009FFD;
  --glow-color: rgba(176, 0, 232, 0.3);

  appearance: none;
  outline: none;
  border: none;
  font-family: inherit;
  font-size: 16px;
  font-weight: 500;
  border-radius: 11px;
  position: relative;
  line-height: 24px;
  cursor: pointer;
  color: var(--button-color);
  padding: 8px 12px;
  margin: 0;
  background: var(--button-background);
  z-index: 1;
  transition: all 0.4s ease-out;

  box-shadow: 0 0 5px rgba(0, 0, 0, 0.6), 0 0 15px var(--glow-color);
}

.glow-button:hover {
  box-shadow: 0 0 15px var(--button-glow-start), 
              0 0 25px var(--button-glow-end), 
              0 0 30px var(--button-glow-start), 
              0 0 50px var(--glow-color);
  background-color: rgba(144, 0, 232, 0.2);
}

.glow-button:active {
  transition: box-shadow 0.7s, background-color 0.7s;
}

.glow-button::before {
  content: '';
  position: absolute;
  top: -20%;
  left: -20%;
  right: -20%;
  bottom: -20%;
  z-index: -1;
  background: radial-gradient(circle, var(--button-glow-start), transparent);
  filter: blur(25px);
  transition: opacity 0.4s;
}

.glow-button:hover::before {
  opacity: 1;
}

/* --- Glitch effect ---> */

.glitch {
  position: relative;
  color: white !important; /* Assure que le texte est en blanc */
  cursor: pointer;
  text-shadow: 
    -2px -2px 0 #000, 
    2px -2px 0 #000, 
    -2px 2px 0 #000, 
    2px 2px 0 #000 !important; /* On force l'application du contour noir */
  font-size: 4rem !important; /* Remplace la classe text-5xl pour être sûr */
}

.glitch::before,
.glitch::after {
  content: attr(data-text);
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  background: transparent;
  clip: rect(0, 0, 0, 0);
}

.glitch::before {
  left: -2px;
  text-shadow: 2px 0 red;
  animation: glitch-loop-1 0.8s infinite ease-in-out alternate-reverse;
}

.glitch::after {
  left: 2px;
  text-shadow: -2px 0 blue;
  animation: glitch-loop-2 0.8s infinite ease-in-out alternate-reverse;
}

@keyframes glitch-loop-1 {
  0% { clip: rect(36px, 9999px, 9px, 0); }
  25% { clip: rect(25px, 9999px, 99px, 0); }
  50% { clip: rect(50px, 9999px, 102px, 0); }
  75% { clip: rect(30px, 9999px, 92px, 0); }
  100% { clip: rect(91px, 9999px, 98px, 0); }
}

@keyframes glitch-loop-2 {
  0% { top: -1px; left: 1px; clip: rect(65px, 9999px, 119px, 0); }
  25% { top: -6px; left: 4px; clip: rect(79px, 9999px, 19px, 0); }
  50% { top: -3px; left: 2px; clip: rect(68px, 9999px, 11px, 0); }
  75% { top: 0px; left: -4px; clip: rect(95px, 9999px, 53px, 0); }
  100% { top: -1px; left: -1px; clip: rect(31px, 9999px, 149px, 0); }
}

/* Style de la Timeline */

.draw-line-height {
  position: relative;
  width: 100%;
  height: 400vh;
}

#line-svg {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
}

/* Timeline - Container */
.timeline {
  position: relative;
  width: 100%;
  margin: 55vh;
  list-style: none;
}

/* Timeline Items */
.timeline-item {
  position: relative;
  margin-bottom: 55vh;
  opacity: 0;
  visibility: visible; /* 👈 Important : passer en visible par défaut */
  transition: opacity 0.6s ease-out, transform 0.6s ease-out;
}

/* Alternance gauche-droite initiale */
.timeline-item.left .timeline-content {
  transform: translateX(-150px);
}

.timeline-item.right .timeline-content {
  transform: translateX(150px);
}

/* Apparition/DISPARITION propre et symétrique */
.timeline-item.visible {
  opacity: 1;
}

.timeline-item.visible .timeline-content {
  transform: translateX(0);
}

/* Timeline Dot inchangé */
.timeline-dot {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
  width: 15px;
  height: 15px;
  background-color: white;
  border-radius: 50%;
}

/* Content Box */
.timeline-content {
  position: relative;
  background: rgba(28, 28, 28, 0.7); /* Transparence subtile */
  color: white;
  padding: 20px;
  border-radius: 16px; /* Plus doux */
  width: 300px;
  transition: transform 0.6s, box-shadow 0.4s;
  font-family: 'Chakra Petch', sans-serif; /* Police moderne (font-chakra) */
  backdrop-filter: blur(10px); /* Flou d'arrière-plan pour l'effet glass */
  box-shadow: 0 8px 24px rgba(176, 0, 232, 0.2); /* Ombrage doux */
  overflow: hidden; /* Nécessaire pour le reflet */
}

/* Effet de reflet léger */
.timeline-content::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background-image: linear-gradient(135deg, rgba(255,255,255,0.15) 0%, transparent 50%);
  transform: rotate(25deg);
  transition: all 0.6s ease;
}

/* Interaction au survol pour dynamiser l'effet */
.timeline-content:hover {
  box-shadow: 0 12px 30px rgba(176, 0, 232, 0.35);
}

.timeline-content:hover::before {
  top: -70%;
  left: -70%;
}

/* Positionnement inchangé */
.timeline-item.left .timeline-content {
  margin-right: 380px;
}

.timeline-item.right .timeline-content {
  margin-left: 380px;
}

.skill-card {
  position: relative;
  background: rgba(255, 255, 255, 0.05); /* transparence légère */
  border-radius: 16px;
  padding: 1.5rem;
  color: #fff;
  backdrop-filter: blur(10px); /* effet verre dépoli */
  box-shadow: 0 8px 20px rgba(176, 0, 232, 0.2);
  overflow: hidden;
}

.skill-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, rgba(176,0,232,0.25), rgba(0,159,253,0.25));
  opacity: 0;
  transition: opacity 0.4s ease;
}

.skill-card:hover::before {
  opacity: 1;
}

.skill-card h3, .skill-card p {
  position: relative; /* pour rester au-dessus du reflet */
  z-index: 1;
}
</style>
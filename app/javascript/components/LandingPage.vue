<template>
  <div class="min-h-screen bg-gray-100 flex flex-col relative overflow-x-hidden">
    <header class="bg-gray-900 text-white py-2 px-4 flex justify-evenly items-center fixed w-full z-50 shadow-md">
      <!-- Photo -->
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

      <!-- Nom -->
      <h1 ref="overlapText" class="text-3xl m-2 font-bold overlap">Sylvain Cavalier</h1>

      <!-- Menu de navigation -->
      <nav class="hidden md:flex gap-6">
        <div class="magnetic-area">
          <a href="#info" class="magnetic-link relative inline-block text-xl transition-all duration-300">
            {{ currentLanguage === 'english' ? 'Info' : 'Infos' }}
          </a>
        </div>
        <div class="magnetic-area">
          <a href="#skills" class="magnetic-link relative inline-block text-xl transition-all duration-300">
            {{ currentLanguage === 'english' ? 'Skills' : 'Compétences' }}
          </a>
        </div>
        <div class="magnetic-area">
          <a href="#projects" class="magnetic-link relative inline-block text-xl transition-all duration-300">
            {{ currentLanguage === 'english' ? 'Projects' : 'Projets' }}
          </a>
        </div>
        <div class="magnetic-area">
          <a href="#contact" class="magnetic-link relative inline-block text-xl transition-all duration-300">
            {{ currentLanguage === 'english' ? 'Contact' : 'Contact' }}
          </a>
        </div>
      </nav>
      <!-- Bouton hamburger (mobile) -->
      <button @click="toggleMobileMenu" class="block md:hidden text-3xl">
        ☰
      </button>
      <!-- Menu mobile -->
      <transition name="menu">
        <div
          v-show="mobileMenuOpen"
          class="md:hidden absolute top-16 right-0 w-[40vw] bg-gray-900 z-40 flex flex-col items-center space-y-4 py-4"
        >
          <a href="#info">Info</a>
          <a href="#skills">Skills</a>
          <a href="#projects">Projects</a>
          <a href="#contact">Contact</a>
        </div>
      </transition>
      <button @click="switchLanguage">
        <div class="gradient"></div>
        <span class="text-3xl">{{ currentLanguage === 'english' ? '🇫🇷' : '🇬🇧' }}</span>
      </button>
    </header>

    <!-- Hero Section -->
    <section id="hero" class="relative inset-0 h-screen flex flex-col items-center justify-center z-10 bg-gray-100">
      <h2 class="glitch font-chakra text-5xl font-bold opacity-0 animate-fadeIn" :data-text="currentLanguage === 'english' ? 'Web Developer & Creative' : 'Développeur Web & Créatif'">
        {{ currentLanguage === 'english' ? 'Web Developer & Creative' : 'Développeur Web & Créatif' }}
      </h2>
      <p class="font-chakra m-4 text-lg text-center opacity-0 animate-fadeIn delay-200">
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
          <svg id="line-svg"
              xmlns="http://www.w3.org/2000/svg"
              class="w-2 h-full"
              viewBox="0 0 10 1500" 
              preserveAspectRatio="none">
            <line id="line-path"
                  x1="5" y1="0" x2="5" y2="1428"
                  stroke="#2BAAE2"
                  stroke-width="4.8484"
                  stroke-linecap="round" />
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
    <section id="skills" class="min-h-screen bg-gray-900 flex flex-col items-center justify-center px-6 py-12 relative">
      <h2 class="text-5xl font-bold mb-10 text-white font-chakra">
        {{ currentLanguage === 'english' ? 'Skills' : 'Compétences' }}
      </h2>
        <!-- Logo en arrière-plan -->
      <div class="absolute flex inset-0 items-center justify-center opacity-20 z-0">
        <img :src="logoUrl" alt="Logo de fond" class="w-3/4 max-w-lg">
      </div>
      <div class="flex flex-col w-full max-w-4xl space-y-8">
        <div 
          v-for="(skill, index) in filteredSkills" 
          :key="index"
          class="skill-card opacity-0 transition-all duration-700 flex flex-col md:flex-row justify-between items-center pb-8 border-b border-gray-700"
        >
          <div class="flex items-baseline gap-4">
            <h3 class="font-chakra font-semibold text-3xl text-white">{{ skill.name }}</h3>
          </div>
          <p class="text-gray-300 font-chakra text-lg md:text-right max-w-xl mt-4 md:mt-0">{{ skill.description }}</p>
        </div>
      </div>
    </section>

    <!-- Section Projects -->
    <section id="projects" class="min-h-screen bg-gray-900 flex flex-col items-center justify-center px-6 py-12">
      <h2 class="text-5xl font-bold mb-10 text-white font-chakra">
        {{ currentLanguage === 'english' ? 'Projects' : 'Projets' }}
      </h2>
      <div class="w-full max-w-2xl">
        <div 
              v-for="(project, index) in filteredProjects" 
              :key="project.id" 
              class="project-card mb-16 p-8 transition-transform duration-300 hover:scale-105"
            >
          <!-- Carousel Swiper -->
          <div class="w-[80%] mx-auto">
            <Swiper
                    :modules="[Navigation]"
                    navigation
                    class="aspect-video rounded-lg overflow-hidden"
                    @swiper="handleSwiper"
                  >
              <SwiperSlide v-for="(photo, photoIndex) in project.photos" :key="photoIndex">
                <img :src="photo" class="mx-auto max-h-full object-contain" :alt="project.name" />
              </SwiperSlide>

              <SwiperSlide v-if="project.video_url">
                <video controls class="mx-auto max-h-full object-contain">
                  <source :src="project.video_url" type="video/mp4" />
                  Votre navigateur ne supporte pas les vidéos HTML5.
                </video>
              </SwiperSlide>
            </Swiper>
          </div>

          <div>
            <h3 class="font-bold text-2xl mb-2 text-white font-chakra">{{ project.name }}</h3>
            <p class="text-gray-300 mb-4">{{ project.description }}</p>
            <p class="text-gray-300">Tech stack: {{ project.tech_stack }}</p>
            <a 
              :href="project.github_url" 
              class="text-gray-300 mt-4 block transition-colors duration-200 hover:text-purple-600"
              target="_blank"
            >
              See on GitHub
            </a>
          </div>
        </div>
      </div>
    </section>

    <!-- Section Contact -->
    <section id="contact" class="min-h-screen flex flex-col items-center justify-center px-6 py-12 text-black">
      <h2 class="text-5xl font-bold mb-4 font-chakra">
        {{ currentLanguage === 'english' ? 'Contact Me' : 'Contactez-moi' }}
      </h2>
      <p class="text-gray-600 mb-8 text-3l font-chakra">mail@sylvaincavalier.com</p>

      <form @submit.prevent="submitForm" class="w-full max-w-2xl space-y-6">

        <!-----------------------------------
            CHAMP NOM
        --------------------------------->
        <div class="relative group">
          <input
            v-model="form.name"
            type="text"
            id="name"
            placeholder="Votre nom"
            class="w-full
                  bg-white/5 backdrop-blur-md
                  border-2 border-gray-900
                  rounded-lg
                  pr-4
                  py-3
                  text-black
                  text-center
                  placeholder-gray-400
                  transition-colors
                  duration-500
                  ease-out
                  z-0"
          />
          <label
            for="name"
            class="absolute inset-0
                  bg-gray-900 text-white
                  flex items-center justify-center
                  z-10
                  transition-all duration-500 ease-out"
                  :class="[form.name ? 'w-1/5' : 'group-hover:w-1/5 w-full']"
          >
            {{ currentLanguage === 'english' ? 'Name' : 'Nom' }}
          </label>
          <div
            v-if="form.name"
            class="absolute right-3 top-1/2 transform -translate-y-1/2 text-green-500 text-xl"
          >
            ✔
          </div>
        </div>
        <p v-if="errors.name" class="text-red-500 text-sm mt-1">{{ errors.name }}</p>

        <!-----------------------------------
            CHAMP EMAIL
        --------------------------------->
        <div class="relative group">
          <input
            v-model="form.email"
            type="email"
            id="email"
            placeholder="votre@email.com"
            class="w-full bg-white/5 backdrop-blur-md
                  border-2 border-gray-900
                  rounded-lg
                  pr-4
                  pl-8
                  py-3
                  text-black
                  text-center
                  placeholder-gray-400
                  transition-all duration-500
                  ease-out
                  z-0"
          />
          <label
            for="email"
            class="absolute inset-0
                  bg-gray-900 text-white
                  flex items-center justify-center
                  z-10
                  transition-all duration-500 ease-in-out"
                  :class="[form.email ? 'w-1/5' : 'group-hover:w-1/5 w-full']"
          >
            Email
          </label>
          <div
            v-if="form.email"
            class="absolute right-3 top-1/2 transform -translate-y-1/2 text-green-500 text-xl"
          >
            ✔
          </div>
        </div>
        <p v-if="errors.email" class="text-red-500 text-sm mt-1">{{ errors.email }}</p>

        <!-----------------------------------
            CHAMP MESSAGE
        --------------------------------->
        <div class="relative group">
          <textarea
            v-model="form.message"
            id="message"
            rows="4"
            placeholder="Votre message..."
            class="w-full bg-white/5 backdrop-blur-md
                  border-2 border-gray-900
                  rounded-lg
                  pr-4
                  pl-8
                  py-3
                  text-black
                  text-center
                  placeholder-gray-400
                  transition-all duration-500
                  ease-out
                  z-0"
          >
          </textarea>
          <label
            for="message"
            class="absolute inset-0
                  bg-gray-900 text-white
                  flex items-center justify-center
                  z-10
                  transition-all duration-500 ease-in-out"
                  :class="[form.message ? 'w-1/5' : 'group-hover:w-1/5 w-full']"
          >
            Message
          </label>
          <div
            v-if="form.message"
            class="absolute right-3 top-1/2 transform -translate-y-1/2 text-green-500 text-xl"
          >
            ✔
          </div>
        </div>
        <p v-if="errors.message" class="text-red-500 text-sm mt-1">{{ errors.message }}</p>

        <button
          type="submit"
          :disabled="isSending"
          class="bg-gray-900 hover:bg-gray-400 text-white font-bold py-3 px-6 rounded-lg transition duration-300 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {{ isSending ? 'Envoi...' : (currentLanguage === 'english' ? 'Send' : 'Envoyer') }}
        </button>

      </form>
    </section>

  </div>
  <Flash :message="flashNotice" @clear="flashNotice = ''" />
</template>

<script setup>
import { ref, computed, onMounted, nextTick, watch, reactive } from 'vue'
import { Swiper, SwiperSlide } from 'swiper/vue'
import 'swiper/css'
import 'swiper/css/navigation'
import { Navigation } from 'swiper/modules'
import photoUrl from '../assets/your-photo.jpg'
import logoUrl from '../assets/LogoSpng.png'
import photofaceUrl from '../assets/photoface.png'
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import Lenis from "lenis";
import chroma from "chroma-js";
import { z } from "zod"
import Flash from './Flash.vue'

const flashNotice = ref('')
const mobileMenuOpen = ref(false)
const toggleMobileMenu = () => {
  mobileMenuOpen.value = !mobileMenuOpen.value
}

const currentLanguage = ref('english');

const switchLanguage = () => {
  const overlay = document.getElementById('language-transition');
  if (!overlay) return;

  overlay.classList.remove('is-hidden');
  overlay.classList.remove('animate-out');
  overlay.offsetHeight;
  overlay.classList.add('animate-in');

  setTimeout(() => {
    currentLanguage.value = currentLanguage.value === 'english' ? 'french' : 'english';
    overlay.classList.remove('animate-in');
    overlay.classList.add('animate-out');

    setTimeout(() => {
      overlay.classList.remove('animate-out');
      overlay.classList.add('is-hidden');
    }, 600);
  }, 600);
};

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

const handleSwiper = (swiper) => {
  swiper.wrapperEl.classList.add('items-center', 'flex');
};

const isSending = ref(false)

const form = reactive({
  name: '',
  email: '',
  message: ''
})

const errors = reactive({
  name: '',
  email: '',
  message: ''
})

const contactSchema = z.object({
  name: z.string().min(1, "Le nom est requis").max(100, "Le nom est trop long"),
  email: z.string().email("Adresse email invalide").max(255, "Email trop long"),
  message: z.string().min(10, "Le message doit contenir au moins 10 caractères").max(2000, "Le message est trop long"),
})

async function submitForm() {
  if (isSending.value) return

  const result = contactSchema.safeParse(form)
  if (!result.success) {
    const fieldErrors = result.error.flatten().fieldErrors
    errors.name = fieldErrors.name?.[0] || ''
    errors.email = fieldErrors.email?.[0] || ''
    errors.message = fieldErrors.message?.[0] || ''
    return
  }

  errors.name = ''
  errors.email = ''
  errors.message = ''

  isSending.value = true

  try {
    const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    const response = await fetch("/contact", {
      method: "POST",
      headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": token
    },
      body: JSON.stringify(form)
    })

    const json = await response.json()

    if (!response.ok) {
      throw new Error(json.message || "Erreur lors de l'envoi")
    }

    flashNotice.value = json.message || "✉️ Message envoyé ! Merci !"
    form.name = ''
    form.email = ''
    form.message = ''
  } catch (error) {
    console.error(error)
    flashNotice.value = error.message || "Erreur inconnue lors de l’envoi"
  } finally {
    isSending.value = false
  }
}

const filteredSkills = computed(() => skills.value.filter(skill => skill.language === currentLanguage.value))
const filteredSteps = computed(() => steps.value.filter(step => step.language === currentLanguage.value))
const filteredProjects = computed(() => projects.value.filter(project => project.language === currentLanguage.value))

const flipImage = () => {
  isFlipped.value = !isFlipped.value
}

watch(filteredProjects, async () => {
  await nextTick()
  
  requestAnimationFrame(() => {
    const swipers = document.querySelectorAll('.swiper')

    swipers.forEach(swiperEl => {
      const swiperInstance = swiperEl.swiper

      if (!swiperInstance) return

      swiperInstance.on('slideChange', () => {
        swiperEl.querySelectorAll('video').forEach(video => video.pause())

        const activeSlide = swiperInstance.slides[swiperInstance.activeIndex]
        const video = activeSlide.querySelector('video')
        if (video) {
          video.play().catch(err => console.warn("Impossible de jouer la vidéo :", err))
        }
      })
    })

    const videos = document.querySelectorAll('video')
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        const video = entry.target
        if (!entry.isIntersecting && !video.paused) {
          video.pause()
        }
      })
    }, { threshold: 0.5 })

    videos.forEach(video => observer.observe(video))
  })
}, { immediate: true })

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

    await nextTick() 
  } catch (error) {
    console.error(error)
  }

  // **✅ Effet de lien magnétique amélioré**
  document.querySelectorAll('.magnetic-area').forEach(area => {
    const link = area.querySelector('.magnetic-link');

    area.addEventListener('mousemove', (e) => {
      const rect = area.getBoundingClientRect();
      const x = (e.clientX - rect.left - rect.width / 2) * 0.2;
      const y = (e.clientY - rect.top - rect.height / 2) * 0.2;
      gsap.to(link, { x, y, scale: 1.1, duration: 0.2, ease: "power2.out" });
    });

    area.addEventListener('mouseleave', () => {
      gsap.to(link, { x: 0, y: 0, scale: 1, duration: 0.2, ease: "power2.out" });
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

  // SVG Line scrolling (inchangé car parfait)
  const path = document.querySelector('#line-path');
  const pathLength = path.getTotalLength();
  path.style.strokeDasharray = pathLength;
  path.style.strokeDashoffset = pathLength;

  window.addEventListener('scroll', () => {
    const scrollY = window.scrollY;
    const section = document.querySelector('#info');
    const sectionTop = section.offsetTop;
    const sectionHeight = section.offsetHeight;

    const virtualHeight = sectionHeight * 1.05;

    const progress = Math.min(Math.max((scrollY - sectionTop) / (virtualHeight - window.innerHeight), 0), 1);
    const drawLength = pathLength * progress;

    path.style.strokeDashoffset = pathLength - drawLength;
  });

  // Intersection Observer + gestion direction scroll (version finale)
  const timelineItems = document.querySelectorAll('.timeline-item');

  let lastScrollY = window.scrollY;
  let scrollingDown = true;

  window.addEventListener('scroll', () => {
    scrollingDown = window.scrollY > lastScrollY;
    lastScrollY = window.scrollY;
  });

  const observerOptions = {
    root: null,
    rootMargin: '-50% 0px -50% 0px',
    threshold: 0
  };

  const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
      } else if (!scrollingDown) {
        entry.target.classList.remove('visible');
      }
    });
  }, observerOptions);

  timelineItems.forEach(item => observer.observe(item));

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

onMounted(() => {
  window.addEventListener('scroll', () => {
    mobileMenuOpen.value = false
  })
})

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

.magnetic-area {
  padding: 40px;
  margin: -40px;
  display: inline-block;
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
  --button-glow-start: #B000E8;
  --button-glow-end: #009FFD;
  --glow-color: rgba(176, 0, 232, 0.15);

  appearance: none;
  outline: none;
  border: none;
  font-family: inherit;
  font-weight: 500;
  border-radius: 8px;
  position: relative;
  line-height: 1;
  cursor: pointer;
  color: var(--button-color);
  margin: 1rem;
  background: var(--button-background);
  z-index: 1;
  transition: all 0.3s ease-out;

  box-shadow: 0 0 4px rgba(0, 0, 0, 0.4), 0 0 8px var(--glow-color);
}

.glow-button:hover {
  box-shadow: 0 0 8px var(--button-glow-start),
              0 0 10px var(--button-glow-end),
              0 0 12px var(--button-glow-start),
              0 0 15px var(--glow-color);
  background-color: rgba(144, 0, 232, 0.15);
}

.glow-button:active {
  transform: scale(0.97);
}

.glow-button::before {
  content: '';
  position: absolute;
  top: -30%;
  left: -30%;
  right: -30%;
  bottom: -30%;
  z-index: -1;
  background: radial-gradient(circle, var(--button-glow-start), transparent);
  filter: blur(20px);
  opacity: 0.4;
  transition: opacity 0.3s;
}

.glow-button:hover::before {
  opacity: 0.8;
}

/* --- Menu Hamburger ---> */

.menu-enter-active,
.menu-leave-active {
  transition: all 0.3s ease;
  transform-origin: top right;
}
.menu-enter-from,
.menu-leave-to {
  opacity: 0;
  transform: scaleY(0);
}
.menu-enter-to,
.menu-leave-from {
  opacity: 1;
  transform: scaleY(1);
}

/* --- Glitch effect ---> */

.glitch {
  position: relative;
  font-size: 3rem;
  font-weight: bold;
  color: #111;
  text-align: center;
  text-transform: uppercase;
  letter-spacing: 2px;
  z-index: 1;
}

.glitch::before,
.glitch::after {
  content: attr(data-text);
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  color: #111;
  z-index: -1;
}

.glitch::before {
  text-shadow: -2px 0 #ff00c8;
  clip-path: inset(0% 0 0% 0);
  animation: glitch-before 2s infinite linear alternate-reverse;
}

.glitch::after {
  text-shadow: 2px 0 #00fff9;
  clip-path: inset(0% 0 0% 0);
  animation: glitch-after 3s infinite linear alternate-reverse;
}

@keyframes glitch-before {
  0% { clip-path: inset(5% 0 80% 0); }
  25% { clip-path: inset(10% 0 65% 0); }
  50% { clip-path: inset(40% 0 30% 0); }
  75% { clip-path: inset(60% 0 10% 0); }
  100% { clip-path: inset(5% 0 80% 0); }
}

@keyframes glitch-after {
  0% { clip-path: inset(80% 0 5% 0); }
  25% { clip-path: inset(60% 0 25% 0); }
  50% { clip-path: inset(30% 0 40% 0); }
  75% { clip-path: inset(10% 0 60% 0); }
  100% { clip-path: inset(80% 0 5% 0); }
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
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  list-style: none;
  margin: 0;
  padding: 0;
}

/* Timeline Items */
.timeline-item {
  position: relative;
  margin: 0;
  opacity: 0;
  visibility: visible;
  transition: opacity 0.6s ease-out, transform 0.6s ease-out;
}

.timeline-item:first-child {
  margin-top: 55vh;
}

.timeline-item.left .timeline-content {
  transform: translateX(-150px);
}

.timeline-item.right .timeline-content {
  transform: translateX(150px);
}

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
  background: rgba(28, 28, 28, 0.7);
  color: white;
  padding: 20px;
  border-radius: 16px;
  width: 300px;
  transition: transform 0.6s, box-shadow 0.4s;
  font-family: 'Chakra Petch', sans-serif;
  backdrop-filter: blur(10px);
  box-shadow: 0 8px 24px rgba(176, 0, 232, 0.2);
  overflow: hidden;
}

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

@media (min-width: 768px) {
  .timeline-item.left .timeline-content {
    margin-right: 380px;
  }

  .timeline-item.right .timeline-content {
    margin-left: 380px;
  }
}

/* SECTION SKILLS */

.skill-card {
  position: relative;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 16px;
  padding: 1.5rem;
  color: #fff;
  backdrop-filter: blur(10px);
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
  position: relative; 
  z-index: 1;
}

/* SECTION PROJECTS */

.project-card {
  position: relative;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 16px;
  padding: 1.5rem;
  color: #fff;
  backdrop-filter: blur(10px);
  box-shadow: 0 8px 20px rgba(43, 170, 226, 0.2);
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.project-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, rgba(43,170,226,0.25), rgba(124,58,237,0.25));
  opacity: 0;
  transition: opacity 0.4s ease;
  z-index: 0;
}

.project-card:hover::before {
  opacity: 1;
}

.project-card h3,
.project-card p,
.project-card a {
  position: relative;
  z-index: 1;
}

.swiper-button-next,
.swiper-button-prev {
  color: #fff;
  background: rgba(176, 0, 232, 0.4);
  border-radius: 50%;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.swiper-button-next::after,
.swiper-button-prev::after {
  font-size: 20px;
}

.swiper-slide video {
  object-fit: cover;
  height: 100%;
  width: 100%;
}

</style>
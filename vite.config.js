import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    vue(),
  ],
  build: {
    outDir: 'public/vite',
    emptyOutDir: true,
    // Optimisation des chunks
    rollupOptions: {
      output: {
        manualChunks: {
          // Séparer les grosses librairies
          'vue-vendor': ['vue'],
          'gsap-vendor': ['gsap'],
          'swiper-vendor': ['swiper'],
        },
      },
    },
    // Augmenter le seuil de warning si nécessaire (après optimisation)
    chunkSizeWarningLimit: 600,
  },
  // Optimisation des images
  assetsInlineLimit: 4096, // Inline assets < 4kb
})
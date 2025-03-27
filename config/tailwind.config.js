const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/**/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.{js,vue}',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['"Roboto"', 'sans-serif'],
        chakra: ['"Chakra Petch"', 'sans-serif'],
      },
      boxShadow: {
        glow: '0 0 10px rgba(0, 170, 255, 0.6)',
      },
    },
  },
  safelist: [
    'bg-red-500', 'bg-gray-100', 'text-white', 'text-black', 'rounded', 'shadow-lg'
  ],
  plugins: [
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ]
}

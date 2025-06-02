const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/**/*.{html,erb}',
    './app/javascript/**/*.js',
    './app/javascript/**/*.vue',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Roboto', ...defaultTheme.fontFamily.sans],
        chakra: ['"Chakra Petch"', ...defaultTheme.fontFamily.sans],
      },
      boxShadow: {
        glow: '0 0 10px rgba(0, 170, 255, 0.6)',
      },
    },
  },
  safelist: [
    { pattern: /.*/ },
  ],
  corePlugins: {
    preflight: true,
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/aspect-ratio'),
  ],
}
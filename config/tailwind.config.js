const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      'white': '#ffffff',
      'light-rose': '#fce7f3',
      'rose-red': '#e11d48',
      'dark-rose': '#be123c',
      'light-purple': '#e9d5ff',
      'dark-purple': '#9333ea', 
      'light-gray': '#f3f4f6',
      'medium-gray': '#d1d5db',
      'dark-gray': '#374151',
      'dark-indigo': '#312e81',
      'light-emerald': '#d1fae5',
      'medium-emerald': '#34d399',
      'dark-emerald': '#065f46'
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}

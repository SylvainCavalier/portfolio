Project.destroy_all
Section.destroy_all

puts "Creating sections..."

Section.create([
  { title: "Info", content: "Bienvenue sur mon portfolio. Vous découvrirez mon parcours et mes projets.", order: 1 },
  { title: "Work", content: "Découvrez mes projets réalisés en tant que développeur web.", order: 2 },
  { title: "Archive", content: "Accédez à mes anciens travaux et expériences professionnelles.", order: 3 },
  { title: "Contact", content: "Contactez-moi via le formulaire ci-dessous.", order: 4 }
])

puts "Sections created!"

puts "Creating projects..."

Project.create([
  {
    name: "UnrealBnb",
    description: "Marketplace avec des réservations de lieux imaginaires, inspiré d'Airbnb.",
    github_url: "https://github.com/SylvainCavalier/UnrealBnB",
    image_url: "https://via.placeholder.com/300x200",
    tech_stack: "Ruby on Rails, Stimulus, Tailwind"
  },
  {
    name: "GN Map",
    description: "Plateforme de mise en relation pour les jeux de rôle grandeur nature, avec une map interactive.",
    github_url: "https://github.com/SylvainCavalier/GN-MAP",
    image_url: "https://via.placeholder.com/300x200",
    tech_stack: "Ruby on Rails, Vue.js, Stimulus, Tailwind"
  },
  {
    name: "SW-Crediter",
    description: "Application web futuriste pour un jeu de rôle Star Wars permettant l'échange de crédits et des notifications en jeu.",
    github_url: "https://github.com/SylvainCavalier/SW-Crediter",
    image_url: "https://via.placeholder.com/300x200",
    tech_stack: "Ruby on Rails, Tailwind"
  }
])

puts "Projects created!"


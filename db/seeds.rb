Project.destroy_all
Section.destroy_all
Skill.destroy_all
Step.destroy_all

puts "Creating sections..."

Section.create([
  { title: "Info", content: "Découvrez mon parcours.", order: 1, language: "french" },
  { title: "Skills", content: "Découvrez mes compétences.", order: 2, language: "french" },
  { title: "Projects", content: "Découvrez mes projets réalisés en tant que développeur web.", order: 3, language: "french" },
  { title: "Contact", content: "Contactez-moi via le formulaire ci-dessous.", order: 4, language: "french" },

  { title: "Info", content: "Discover my journey.", order: 1, language: "english" },
  { title: "Skills", content: "Explore my skills.", order: 2, language: "english" },
  { title: "Projects", content: "Check out my web development projects.", order: 3, language: "english" },
  { title: "Contact", content: "Contact me via the form below.", order: 4, language: "english" }
])

puts "Sections created!"

puts "Creating projects..."

Project.create([
  # Projet UnrealBnb
  {
    name: "UnrealBnb",
    description: "Marketplace avec des réservations de lieux imaginaires, inspiré d'Airbnb.",
    github_url: "https://github.com/SylvainCavalier/UnrealBnB",
    image_url: "https://via.placeholder.com/300x200",
    tech_stack: "Ruby on Rails, Stimulus, Bootstrap",
    language: "french"
  },
  {
    name: "UnrealBnb",
    description: "A marketplace for booking imaginary locations inspired by Airbnb.",
    github_url: "https://github.com/SylvainCavalier/UnrealBnB",
    image_url: "https://via.placeholder.com/300x200",
    tech_stack: "Ruby on Rails, Stimulus, Bootstrap",
    language: "english"
  },

  # Projet GN Map
  {
    name: "GN Map",
    description: "Réseau social et plateforme de mise en relation pour les évènements de jeux de rôle grandeur nature, avec une map interactive.",
    github_url: "https://github.com/SylvainCavalier/GN-MAP",
    image_url: "https://via.placeholder.com/300x200",
    tech_stack: "Ruby on Rails, Vue.js, Stimulus, Bootstrap",
    language: "french"
  },
  {
    name: "GN Map",
    description: "A social network and matchmaking platform for live-action role-playing events, featuring an interactive map.",
    github_url: "https://github.com/SylvainCavalier/GN-MAP",
    image_url: "https://via.placeholder.com/300x200",
    tech_stack: "Ruby on Rails, Vue.js, Stimulus, Bootstrap",
    language: "english"
  },

  # Projet StarWars-RPG
  {
    name: "StarWars-RPG",
    description: "Application web futuriste pour un collectif de jeu de rôle Star Wars permettant l'échange de crédits, la gestion des bases et des familiers, un système de messagerie avec notifications dynamiques et de nombreuses autres fonctionnalités en jeu.",
    github_url: "https://github.com/SylvainCavalier/SW-Crediter",
    image_url: "https://via.placeholder.com/300x200",
    tech_stack: "Ruby on Rails, Tailwind",
    language: "french"
  },
  {
    name: "StarWars-RPG",
    description: "A futuristic web application for a Star Wars role-playing game collective, enabling credit exchanges, base and pet management, a messaging system with dynamic notifications, and numerous other in-game features.",
    github_url: "https://github.com/SylvainCavalier/SW-Crediter",
    image_url: "https://via.placeholder.com/300x200",
    tech_stack: "Ruby on Rails, Tailwind",
    language: "english"
  }
])

puts "Projects created!"

puts "Creating skills..."

skills = [
  # Web Design
  { name: "Web Design", description: "I craft websites that align with your brand and engage your audience. My will is that each site is not just visually appealing but also robust, scalable, and easy to manage.", language: "english" },
  { name: "Web Design", description: "Je crée des sites web qui correspondent à votre marque et qui créent de l'engagement. Mon but est que chaque site soit non seulement agréable à visiter, mais aussi robuste, scalable, et facile à gérer", language: "french" },

  # Développement Web
  { name: "Web Development", description: "Fullstack : HTML, CSS (Bootstrap, Tailwind), Ruby on Rails, JavaScript (Stimulus, Vue.js). I focus on clean, maintainable code and performance-driven solutions.", language: "english" },
  { name: "Développement Web", description: "Fullstack : HTML, CSS (Bootstrap, Tailwind), Ruby on Rails, JavaScript (Stimulus, Vue.js). Mon approche privilégie un code propre, maintenable et performant.", language: "french" },

  # Intelligence Artificielle
  { name: "Artificial Intelligence", description: "Frequent use of AI tools like ChatGPT, MidJourney, Sora, Claude, Perplexity. Proficient in integrating AI APIs for web applications.", language: "english" },
  { name: "Intelligence Artificielle", description: "Utilisation fréquente d'outils d'IA comme ChatGPT, MidJourney, Sora, Claude, Perplexity. Compétence en intégration d'API d'IA pour sites web.", language: "french" },

  # Montage Vidéo & Photo
  { name: "Video & Photo Editing", description: "Regular use of Adobe Premiere Pro, After Effects, and Photoshop at an intermediate-advanced level.", language: "english" },
  { name: "Montage Vidéo & Photo", description: "Utilisation régulière d'Adobe Premiere Pro, After Effects et Photoshop à un niveau intermédiaire-avancé.", language: "french" },

  # Langues
  { name: "Languages", description: "French: Native Language - English: Advanced level (C1) - Russian: Good level (B2) - Spanish: Intermediate level (B1)", language: "english" },
  { name: "Langues", description: "Français: Langue maternelle - Anglais: Très bon niveau (C1) - Russe: Bon niveau (B2) - Espagnol: Niveau intermédiaire (B1)", language: "french" },

  # Autres compétences
  { name: "Videography", description: "Content creator on YouTube, video production, and editing.", language: "english" },
  { name: "Vidéographie", description: "Créateur de contenu sur YouTube, production et montage vidéo.", language: "french" },

  { name: "Speaker", description: "Lecturer on disinformation and cybersecurity.", language: "english" },
  { name: "Conférencier", description: "Intervenant sur la désinformation et la cybersécurité.", language: "french" },

  { name: "Trainer", description: "Teaching labor law at the Faculty of Law of ICP Paris.", language: "english" },
  { name: "Formateur", description: "Enseignement du droit du travail à la faculté de droit de l'ICP Paris.", language: "french" }
]

Skill.create!(skills)

puts "Skills created successfully!"

steps = [
  # Développeur Web
  { name: "Développeur Web", date: "2024", location: "Le Wagon Paris", description: "Bootcamp Développement Web Fullstack.", language: "french" },
  { name: "Web Developer", date: "2024", location: "Le Wagon Paris", description: "Fullstack Web Development Bootcamp.", language: "english" },

  # Juriste & Chargé de TD
  { name: "Juriste & Chargé de TD", date: "2018-2024", location: "Tribunal de Créteil & ICP Paris", description: "Fonctionnaire de greffe au Ministère de la Justice, et chargé de TD en droit du travail en Licence de droit.", language: "french" },
  { name: "Legal Expert & Lecturer", date: "2018-2024", location: "Créteil Court & ICP Paris", description: "Court clerk at the Ministry of Justice, and labor law lecturer for undergraduate law students.", language: "english" },

  # Master 2 Sécurité Internationale et Défense
  { name: "Master 2 Sécurité Internationale et Défense", date: "2015", location: "Université de Grenoble", description: "Mémoire de recherche : « Les cryptomonnaies dans la criminalité organisée et le terrorisme ». ", language: "french" },
  { name: "Master's Degree in International Security & Defense", date: "2015", location: "University of Grenoble", description: "Research thesis: ‘Cryptocurrencies in Organized Crime and Terrorism’", language: "english" },

  # Échange Universitaire en Russie
  { name: "Échange Universitaire en Russie", date: "2014", location: "Université d’État de Saint-Pétersbourg", description: "Cours : Droit international, Management d’événements, Civilisation russe.", language: "french" },
  { name: "University Exchange in Russia", date: "2014", location: "Saint Petersburg State University", description: "Courses: International Economic Law, Event Management, Russian Civilization.", language: "english" },

  # Étudiant et Sapeur-Pompier Volontaire
  { name: "Étudiant & Pompier", date: "2009-2014", location: "Grenoble", description: "Étudiant en Droit, et job étudiant : Sapeur-Pompier volontaire de Grenoble.", language: "french" },
  { name: "Student & Firefighter", date: "2009-2014", location: "Grenoble", description: "Law student, part-time job as a volunteer firefighter in Grenoble.", language: "english" }
]

Step.create!(steps)

puts "Steps created successfully!"

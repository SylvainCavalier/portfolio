# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal portfolio website for Sylvain Cavalier, built with Rails 7.1 + Vue 3 + Vite. The site showcases projects, skills, and professional journey with bilingual support (English/French).

## Development Commands

```bash
# Start development server (Rails + Vite)
bin/dev

# Rails server only
bin/rails server

# Vite dev server only
bin/vite dev

# Database
bin/rails db:migrate
bin/rails db:seed

# Tests (RSpec)
bundle exec rspec              # Run all specs
bundle exec rspec spec/models  # Run model specs only
bundle exec rspec spec/path/to/spec.rb:42  # Run specific test
```

## Architecture

### Stack
- **Backend**: Rails 7.1, PostgreSQL, Ruby 3.3.5
- **Frontend**: Vue 3 (SFC with `<script setup>`), Vite, Tailwind CSS 3
- **Storage**: Active Storage with Cloudinary for images
- **Animations**: GSAP + ScrollTrigger, Lenis (smooth scrolling)

### Frontend Entry Point
The Vue app is mounted from `app/javascript/entrypoints/application.js` which loads `App.vue` -> `LandingPage.vue`. The landing page is a single-page application with sections: Hero, Info (timeline), Skills, Projects, Contact.

### Data Flow
- Vue components fetch data from Rails JSON endpoints (`/skills`, `/steps`, `/projects`)
- Language filtering happens client-side via computed properties (`filteredSkills`, `filteredSteps`, `filteredProjects`)
- Each model (Project, Skill, Step, Section) has a `language` field for bilingual content

### Key Controllers
- `LandingController` - Main landing page
- `SkillsController`, `StepsController`, `ProjectsController` - JSON API endpoints
- `ContactController` - Contact form with email via `ContactMailer`

### Styling
- Tailwind config in `tailwind.config.js` with custom fonts (Roboto, Chakra Petch) and glow shadow
- Vue SFC scoped styles for complex animations (glitch effects, timeline, flip cards)

## Environment Variables

Required in `.env`:
- Cloudinary credentials for image storage
- Mail configuration for contact form

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal portfolio website for Sylvain Cavalier, built with Rails 7.1 + Vue 3 + Vite. The site showcases projects, skills, and professional journey with bilingual support (English/French).

## Development Commands

```bash
# Start development server (Puma; Vite is auto-served by vite_ruby in dev)
bin/dev

# Rails server only
bin/rails server

# Vite dev server standalone (rarely needed — vite_ruby spawns it on demand)
bin/vite dev

# Database
bin/rails db:migrate
bin/rails db:seed     # destroys & recreates all records, downloads project media from Cloudinary via open-uri

# Tests (RSpec — this is the real suite; the legacy test/ dir is unused minitest scaffolding)
bundle exec rspec                          # Run all specs
bundle exec rspec spec/models              # Run model specs only
bundle exec rspec spec/path/to/spec.rb:42  # Run specific test
```

Note: `Procfile.dev` only declares `web: puma`. Vite is started automatically by `vite_ruby` middleware in development — there is no separate Vite process line.

## Architecture

### Stack
- **Backend**: Rails 7.1, PostgreSQL, Ruby 3.3.5
- **Frontend**: Vue 3 (SFC with `<script setup>`), Vite (`vite_rails`/`vite_plugin_ruby`), Tailwind CSS 3
- **Storage**: Active Storage with Cloudinary backend for images/videos
- **Animations**: GSAP + ScrollTrigger, Lenis (smooth scrolling), Swiper (carousels)

### Frontend Entry Point
The Vue app mounts from `app/javascript/entrypoints/application.js`, loading `App.vue` → `LandingPage.vue`. `LandingPage.vue` is a ~1300-line monolith holding every section (Hero, Info/timeline, Skills, Projects, Contact) plus all GSAP animations and scoped styles — most frontend work happens in this single file.

### Data Flow & Bilingual Content
- Vue fetches JSON from Rails endpoints: `/skills`, `/steps`, `/projects` (each is `resources … only: [:index]`). The `Section` model is seeded but **not** exposed via any route.
- Each record carries a `language` field holding the literal string `"french"` or `"english"` (not locale codes like `fr`/`en`). Content is duplicated per language as separate rows.
- Language filtering is **client-side**: Vue computed properties (`filteredSkills`, `filteredSteps`, `filteredProjects`) select rows matching the active language. Server-side `/change_language/:locale` (`ApplicationController#change_language`) also exists.

### Project Media via Cloudinary
`ProjectsController#index` does **not** serve photos through Active Storage's default URLs. It builds direct Cloudinary delivery URLs with `Cloudinary::Utils.cloudinary_url(photo.key, resource_type: …)`, picking `image`/`video`/`raw` from the blob content type, so media bypasses the Rails app entirely. Responses are cached with `expires_in 1.hour, public: true`.

### Key Controllers
- `LandingController#index` — root page, renders the Vue host view
- `SkillsController`, `StepsController`, `ProjectsController` — JSON `index` endpoints (no views)
- `ContactController#send_message` — `POST /contact`; uses `protect_from_forgery with: :null_session`, validates presence + length server-side, sends mail via `ContactMailer` with `deliver_now`

### Models
All under `app/models`, plain ActiveRecord with no validations/associations except `Project has_many_attached :photos`:
- `Project` — name, description, github_url, tech_stack, language, video_url, attached photos
- `Skill` — name, description, language
- `Step` — name, date (string), location, description, language (timeline entries)
- `Section` — title, content, order, language

### Styling
- `tailwind.config.js` — custom fonts (Roboto, Chakra Petch) and a custom `glow` shadow
- Complex animations (glitch effects, timeline, flip cards) live in Vue SFC scoped styles inside `LandingPage.vue`

## Environment Variables

Required in `.env`:
- Cloudinary credentials for image/video storage
- Mail configuration for the contact form

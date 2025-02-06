Rails.application.routes.draw do
  # Définition de la page d'accueil
  root 'landing#index'

  # Route pour afficher un projet spécifique
  resources :projects, only: [:index, :show]

  # Route pour changer la langue
  get '/change_language/:locale', to: 'application#change_language', as: :change_language

  # Route pour le service worker
  get '/service-worker.js', to: proc { [200, {}, ['']] }

  # Vérification du statut de l'application
  get "up" => "rails/health#show", as: :rails_health_check
end
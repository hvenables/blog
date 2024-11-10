Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "main#index"

  resources :articles do
    resources :likes, only: :create
  end
  resource :contact, only: %i[show create]
  resource :session, only: %i[new create destroy]
  resource :about, only: :show

  namespace :admin do
    resource :dashboard, only: :show
  end
end

require "sidekiq/web"
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  mount Sidekiq::Web => "/sidekiq"
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  get "sign_in", to: "sign_in#new"
  post "sign_in", to: "sign_in#create"
  delete "sign_out", to: "sign_in#destroy"

  get "sign_up", to: "sign_up#new"
  post "sign_up", to: "sign_up#create"

  get "reset_password", to: "reset_password#new"
  post "reset_password", to: "reset_password#create"
  get "reset_password/edit", to: "reset_password#edit"
  patch "reset_password/update", to: "reset_password#update"

  root "home#index"
  post "async_action", to: "home#async_action"
end

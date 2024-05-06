Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  get "profile/edit", to: "users#profile_edit"
  post "profile/edit", to: "users#profile_update"
  get "users/confirm", to: "users#confirm"
  patch "users/withdrawal", to: "users#withdrawal"

  resources :users, only: [:show]
  resources :categories, only: [:new, :create, :show, :update, :destroy]
  resources :bookmarks
  resources :timestamps, only: [:create, :edit, :update, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end

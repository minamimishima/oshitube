Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  get "profile/edit", to: "users#profile_edit"
  post "profile/edit", to: "users#profile_update"
  get "users/confirm", to: "users#confirm"
  patch "users/withdrawal", to: "users#withdrawal"
  get "categories/new_cancel", to: "categories#new_cancel"

  resources :users, only: [:show]
  resources :categories, except: [:index] do
    member do
      get "edit_cancel"
    end
  end
  resources :bookmarks
  resources :timestamps, only: [:create, :show, :edit, :update, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end

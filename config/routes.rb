Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users, controllers: {
    passwords: 'users/passwords',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  devise_for :registrations, class_name: "User::Registration", controllers: {
    confirmations: 'users/registrations'
  }
  devise_scope :registration do
    post "/registrations/destroy", to: "users/registrations#destroy",  as: "destroy_user_registration"
  end
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
    delete '/registrations', to: 'devise/registrations#destroy', as: "user_registration"
    patch 'users/confirmation', to: 'users/confirmations#update'
  end

  authenticated :user do
    root to: "users/users#index", as: :user_root
  end

  namespace :users do
    resources :users, only: %w[index show edit update]
  end

  root to: 'home#index'

end

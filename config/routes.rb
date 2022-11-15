Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users, controllers: {
    passwords: 'users/passwords',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }

  # 認証機能付き登録
  devise_for :registrations, class_name: "User::Registration", controllers: {
    confirmations: 'users/registrations'
  }
  devise_scope :registration do
    post "/registrations/destroy", to: "users/registrations#destroy",  as: "destroy_user_registration"
  end

  # email変更
  devise_for :settings, class_name: "User::Registration", controllers: {
    confirmations: 'users/settings'
  }

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
    delete '/registrations', to: 'devise/registrations#destroy', as: "user_registration"
  end

  authenticated :user do
    root to: "users/users#index", as: :user_root
  end

  namespace :users do
    resources :users, only: %w[index show edit update]
  end

  root to: 'home#index'

end

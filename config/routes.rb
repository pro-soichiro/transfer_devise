Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users, controllers: {
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks',
    # omniauth_callbacks: 'users/omniauth_callbacks',
  }
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  authenticated :user do
    root to: "users/users#index", as: :user_root
  end

  namespace :users do
    get 'users/index'
  end

  root to: 'home#index'

end

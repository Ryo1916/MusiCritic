Rails.application.routes.draw do
  root 'creatives#index'
  get 'creatives/index'

  devise_for :users,
              controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                             passwords: "users/passwords",
                             registrations: 'users/registrations',
                             sessions: 'users/sessions' }
  resources :users, only: [:show, :edit, :update]
  resources :artists, only: [:index, :destroy]
  resources :albums, only: [:index, :show, :destroy]
  resources :reviews, only: [:create, :edit, :update, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

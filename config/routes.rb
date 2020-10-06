Rails.application.routes.draw do
  root 'creatives#index'
  get 'creatives/terms_and_conditions', as: :terms
  get 'creatives/privacy_notice', as: :privacy

  devise_for :users,
              controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                             passwords: 'users/passwords',
                             registrations: 'users/registrations',
                             sessions: 'users/sessions' }
  resources :users, only: %i[show edit update]
  resources :artists, only: %i[index show destroy] do
    get :search, on: :collection
  end
  resources :albums, only: %i[index show destroy] do
    get :search, on: :collection
  end
  resources :reviews, only: %i[create update destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end

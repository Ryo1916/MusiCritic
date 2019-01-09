Rails.application.routes.draw do
  root 'creatives#index'
  get 'creatives/index'
  get 'mains/top'

  devise_for :users,
              controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                             passwords: "users/passwords",
                             registrations: 'users/registrations',
                             sessions: 'users/sessions' }
  resources :reviews
  resources :artists
  resources :albums

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end

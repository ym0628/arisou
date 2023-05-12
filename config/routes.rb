Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'static_pages#top'

  get 'terms_of_use', to: 'static_pages#terms_of_use'
  get 'privacy_policy', to: 'static_pages#privacy_policy'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :tools
  resources :password_resets, only: %i[new create edit update]
end

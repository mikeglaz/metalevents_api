Rails.application.routes.draw do
  resources :users
  resources :events

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'


end

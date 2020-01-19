Rails.application.routes.draw do
  resources :venues
  resources :events
  resources :users do
    collection do
      post 'confirm'
    end
  end

  resources :password_reset, only: :create #[:create, :edit, :update]

  post 'signup', to: 'users#create'
  post 'login', to: 'users#login'

  get '/activation', to: 'users#activation', as: 'activation'
  get '/password_reset', to: 'password_reset#edit', as: 'edit_password_reset'
  put '/password_reset/', to: 'password_reset#update', as: 'password_reset'
end

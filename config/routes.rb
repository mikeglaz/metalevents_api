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

  get '/activation/:token', to: 'users#activation', as: 'activation'
  get '/password_reset/:token', to: 'password_reset#edit', as: 'password_reset'
end

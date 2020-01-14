Rails.application.routes.draw do
  resources :venues
  resources :events
  resources :users do
    collection do
      post 'confirm'
    end
  end

  post 'signup', to: 'users#create'
  post 'login', to: 'users#login'

  get '/activation/:token', to: 'users#activation', as: 'activation'

end

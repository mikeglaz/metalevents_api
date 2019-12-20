Rails.application.routes.draw do
  resources :events
  resources :users do
    collection do
      post 'confirm'
    end
  end

  post 'signup', to: 'users#create'

  get '/activation/:token', to: 'users#activation'

end

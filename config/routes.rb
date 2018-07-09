Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
  resources :concerts, only: [:index, :show] do
    collection do
      get :upcoming
    end
    resources :concert_predictions, only: [:index, :show, :create, :update]
  end

  resources :songs, only: [:index]
end

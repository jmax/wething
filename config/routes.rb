Wething::Application.routes.draw do
  devise_for :users, :companies

  resources :things, only: [:new, :create, :show] do
    resources :user_favorites, only: [:create]
  end


  get "/thing/this", to: 'things#new', as: 'thing_this'

  get "home/index"

  get "my/favorites", to: 'user_favorites#show', as: 'my_favorites'

  root to: "home#index"
end

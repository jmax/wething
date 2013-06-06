Wething::Application.routes.draw do
  devise_for :users, :companies

  resources :things, only: [:new, :create]

  get "/thing/this", to: 'things#new', as: 'thing_this'

  get "home/index"

  root to: "home#index"
end

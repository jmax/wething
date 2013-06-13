Wething::Application.routes.draw do
  devise_for :users, :companies

  resources :things, only: [:new, :create, :show] do
    resources :user_favorites, only: [:create]
  end

  get "/thing/this",       to: 'things#new',          as: 'thing_this'
  get "my/favorites",      to: 'user_favorites#show', as: 'my_favorites'
  get "/things/:id/visit", to: 'things#show',         as: 'visit_thing'
  get "home/index"

  root to: "home#index"
end

Wething::Application.routes.draw do
  devise_for :users, :companies

  get "home/index"

  root to: "home#index"
end

Rails.application.routes.draw do
  root "buttons#index"
  post "buttons/:button", to: "buttons#create"
  get "messages", to: "messages#index"

  resources :players, only: [:new, :create]
end

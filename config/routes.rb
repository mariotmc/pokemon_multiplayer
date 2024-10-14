Rails.application.routes.draw do
  root "buttons#index"
  post "buttons/:button", to: "buttons#create"

  resources :players, only: [:new, :create]
end

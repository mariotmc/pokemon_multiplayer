Rails.application.routes.draw do
  root "buttons#index"
  post "buttons/:button", to: "buttons#create"
end

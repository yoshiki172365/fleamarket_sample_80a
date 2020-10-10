Rails.application.routes.draw do
  get 'addresses/new'
  devise_for :users
  root 'items#index'
  resources :cards
end

Rails.application.routes.draw do
  resources :addresses
  devise_for :users
  root 'items#index'
  resources :cards
end

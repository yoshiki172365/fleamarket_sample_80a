Rails.application.routes.draw do

  get 'purchase/index'
  devise_for :users, controllers: {
    resgistration: 'users/registrations'
  }
  devise_scope :user do
    get 'registrations', to: 'users/registrations#create_users'
  end

  root to:'items#index'
  resources :addresses, only: [:new]
  resources :items only: [:index, :new, :show]
  resources :categories, only: [:index]
end

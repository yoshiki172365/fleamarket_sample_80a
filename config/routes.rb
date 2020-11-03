Rails.application.routes.draw do

  get 'purchase/index'
  get 'users/show'


  # ユーザーログイン機能実装後に get 'users/:id/logout', to 'users/logout'にする
  get 'users/logout'

  devise_for :users, controllers: {
    resgistration: 'users/registrations'
  }
  devise_scope :user do
    get 'registrations', to: 'users/registrations#create_users'
  end

  root to:'items#index'
  resources :addresses, only: [:new]
  resources :items
  resources :cards, only: [:new, :create]
  resources :categories, only: [:index]
  resources :purhase, only: [:create]
end

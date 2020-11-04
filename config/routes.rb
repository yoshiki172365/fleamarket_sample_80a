Rails.application.routes.draw do

  get 'purchase/index'
  get 'users/show'
  #仮ログインログアウト用
  get 'users/index'


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

  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
      get 'new', to: 'cards#new'
    end
  end

  resources :categories, only: [:index]

  resources :purhase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end

end

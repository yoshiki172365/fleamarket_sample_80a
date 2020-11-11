Rails.application.routes.draw do
  devise_for :users, controllers: {
    resgistration: 'users/registrations'
  }
  devise_scope :user do
    get 'registrations', to: 'users/registrations#create_users'
  end

  resources :users, only: [:show]

  root to:'items#index'
  resources :addresses, only: [:new]

  resources :items do
    resources :purchase, only: [:index] do
      collection do
        get 'index', to: 'purchase#index'
        post 'pay', to: 'purchase#pay'
        get 'done', to: 'purchase#done'
      end
    end

    resources :comments, only: [:create, :destroy, :edit]
  end

  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
      get 'new', to: 'cards#new'
    end
  end

  resources :categories, only: [:index]

end

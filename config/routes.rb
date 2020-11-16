Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  resources :users, only: [:show]

  root to:'items#index'
  resources :addresses, only: [:new]

  resources :items do
    collection do
      match 'search_index', to: 'items#search_index', via: [:get, :post]
      get 'search', to: 'items#search'
      get 'result', to: 'items#result'
    end

    resources :purchase do
      collection do
        get 'index', to: 'purchase#index'
        post 'pay', to: 'purchase#pay'
        get 'done', to: 'purchase#done'
      end
    end
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

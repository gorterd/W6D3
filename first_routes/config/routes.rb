Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # get "users", to: "users#index"
  # get "users/:id", to: "users#show", as: "user"
  # patch "users/:id", to: "users#update"
  # put "users/:id", to: "users#update"
  # post "users", to: "users#create"
  # delete "users/:id", to: "users#destroy"
  # get "users/new", to: "users#new", as: "new_user"
  # get "users/:id/edit", to: "users#edit", as: "edit_user"

  resources :users, only: [:index, :show, :update, :create, :destroy] do
    resources :artworks, only: [:index]
    resources :comments, only: [:index]
    resources :likes, only: :index

    member do
      patch 'set_favorite'
      get 'get_favorite'
    end

  end
  
  resources :artworks, only: [:show, :update, :create, :destroy] do
    resources :comments, only: [:index]
    resources :likes, only: :index
  end

  resources :artwork_shares, only: [:index, :create, :destroy]

  resources :comments, only: [:index, :create, :destroy]

  resources :likes, only: [:index, :create, :destroy]
end

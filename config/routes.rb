Rails.application.routes.draw do
  root to: "books#home"
  get "/home/about", to: "books#about", as: "about"
  post "/search", to: "searches#search", as: "search"

  devise_for :users

  resources :books, only: [:index, :show, :create, :destroy, :edit, :update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index] do
    resource :relationships, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

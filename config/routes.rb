Rails.application.routes.draw do
  devise_for :users
  root 'books#top'
  get "home/about" => "books#about"
  
  resources :books do
  	resources :book_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :update, :index, :create] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

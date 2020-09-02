Rails.application.routes.draw do
  devise_for :users
  root 'books#top'
  resources :books do
  	resources :book_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index, :create]
  get "home/about" => "books#about"
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

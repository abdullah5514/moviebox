Rails.application.routes.draw do
  devise_for :users
  
  root 'movies#index'
  get '/search', to: 'movies#search', as: 'search_movies'
  resources :movies do
    resources :comments, only: :create
    resources :reviews, only: :create
  end
end

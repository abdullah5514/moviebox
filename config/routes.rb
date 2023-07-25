Rails.application.routes.draw do
  devise_for :users
  
  root 'movies#index'
  get '/search', to: 'movies#search', as: 'search_movies'
  get '/tmdb_show', to: 'movies#tmdb_show', as: 'tmdb_show'
  resources :movies do
    resources :comments, only: :create
    resources :reviews, only: :create
  end
  get '*path', to: redirect('/')
end

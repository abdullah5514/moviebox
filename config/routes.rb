Rails.application.routes.draw do
  root 'movies#index'

  resources :movies do
    resources :comments, only: :create
    resources :reviews, only: :create
  end
end

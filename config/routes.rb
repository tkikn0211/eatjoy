Rails.application.routes.draw do
  
  devise_for :users
  root to: "homes#top"
  get "/about" => "home#about"
  resources :users, omly: [:show, :edit]
  resources :recruitments, only: [:new, :index, :show, :edit]
  resources :genres, only: [:index]
  resources :profiles, only: [:show]
  resources :notifications, only: [:index]

  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

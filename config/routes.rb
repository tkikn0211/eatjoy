Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  get "home_about"=>"homes#about"
  resources :users, omly: [:show, :edit, :update] do
    collection do
      get 'unsubscribe'
      patch 'withdraw'
    end
  end
  resources :recruitments,only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
  end
  resources :genres, only: [:index]
  resources :profiles, only: [:show]
  resources :notifications, only: [:index]
  resources :messages, only:[:index, :show, :create]
  get "search" => "searches#search"
  


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

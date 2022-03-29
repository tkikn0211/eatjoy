Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :sessions => 'users/sessions'
  }

  #ゲストログイン
  devise_scope :user do
    post '/users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root "homes#top"
  get "home_about"=>"homes#about"
  resources :users, only: [:show, :edit, :update, :index] do
    collection do
      get 'rooms'#DM一覧
      get 'unsubscribe'#退会機能ネストする
      patch 'withdraw'
    end
    member do#いいね一覧idが必要なためmemberを使用userにネスト
      get :favorites
    end
  end

  resources :recruitments,only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
  end
  resources :genres, only: [:index]
  resources :profiles, only: [:show]
  resources :notifications, only: [:index]
  resources :messages, only:[:show, :create, :destroy]
  resources :notifications, only: [:index]
  get "search" => "searches#search"

  #退会機能
  get 'unsubscribe/:name' => 'homes#unsubscribe', as: 'confirm_unsubscribe'
  patch ':id/withdraw/:name' => 'homes#withdraw', as: 'withdraw_user'
  put 'withdraw/:name' => 'users#withdraw'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

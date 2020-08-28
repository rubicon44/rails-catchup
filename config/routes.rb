Rails.application.routes.draw do
  # 認証（devise）
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

  # post機能
  root 'goals#index'
  resources :goals

  # ユーザープロフィール機能
  resources :users, only: [:show]
end

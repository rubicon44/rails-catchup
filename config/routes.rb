require 'url_constrainer'

Rails.application.routes.draw do
  # get 'messages/create'
  # get 'chat_rooms/create'
  # get 'chat_rooms/index'
  # get 'chat_rooms/show'
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

  # goal機能
  root 'goals#index'
  resources :goals
  resources :goals, only: [:index, :show, :create] do
    # コメント機能
    resources :comments, only: [:create, :destroy]
    # いいね機能
    resources :likes, only: [:create, :destroy]
  end

  # ユーザープロフィール機能
  constraints(UrlConstrainer.new) do
    resources :users, param: :username, only: [:show, :edit, :update]
  end
  resources :users, only: [:show] do
    # フォロー機能
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  # 通知機能
  resources :notifications, only: [:index]

  # チャット機能
  # resources :messages, only: [:create]
  # resources :chat_rooms, only: [:create, :index, :show]
end

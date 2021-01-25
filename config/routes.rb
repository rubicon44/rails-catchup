require 'url_constrainer'

Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :confirmations => 'users/confirmations',
    :passwords => 'users/passwords'
  }

  devise_scope :user do
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

  # root 'goals#index'
  root 'static_pages#home'
  get 'static_pages/home'

  resources :goals
  resources :goals, only: [:index, :show, :create] do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:index, :create, :destroy]
  end

  constraints(UrlConstrainer.new) do
    resources :users, param: :username, only: [:show, :edit, :update, :destroy]
  end

  resources :users, only: [:index] do
    collection do
      get :search
    end
  end

  resources :users, only: [:show] do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end

  resources :notifications, only: [:index]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

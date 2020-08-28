Rails.application.routes.draw do
  root 'goals#index'
  resources :goals
end

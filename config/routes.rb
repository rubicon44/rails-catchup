Rails.application.routes.draw do
  root 'goals#index'

  get 'goals/index'
  get 'goals/show'
  get 'goals/new'
  get 'goals/edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
